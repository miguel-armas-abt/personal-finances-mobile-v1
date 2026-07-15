param([string]$GeneratorJar, [switch]$Check)

$ErrorActionPreference = 'Stop'
$version = '7.22.0'
$expectedHash = '3F1E6CE5C6AD4F15242C6170AB43AAD4BAD771622617EEECE4A7D4F72FFAF329'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$temp = Join-Path ([IO.Path]::GetTempPath()) ("finances-openapi-" + [guid]::NewGuid())
$destination = Join-Path $root 'packages/finances_api'
$lock = Join-Path $root 'tool/finances_api.pubspec.lock'

function Invoke-Checked {
    param([string]$Command, [string[]]$Arguments)
    $ErrorActionPreference = 'Continue'
    & $Command @Arguments
    if ($LASTEXITCODE -ne 0) { throw "$Command failed ($LASTEXITCODE)" }
}

New-Item -ItemType Directory -Path $temp | Out-Null
try {
    if (-not $GeneratorJar) {
        $GeneratorJar = Join-Path $temp "openapi-generator-cli-$version.jar"
        Invoke-WebRequest -UseBasicParsing -Uri "https://repo.maven.apache.org/maven2/org/openapitools/openapi-generator-cli/$version/openapi-generator-cli-$version.jar" -OutFile $GeneratorJar
    }
    $GeneratorJar = (Resolve-Path -LiteralPath $GeneratorJar).Path
    if ((Get-FileHash -LiteralPath $GeneratorJar).Hash -ne $expectedHash) {
        throw "OpenAPI Generator must match version $version and its pinned checksum."
    }

    $original = Join-Path $root 'contracts/openapi.yaml'
    Invoke-Checked java @('-jar', $GeneratorJar, 'validate', '-i', $original)
    $contract = [IO.File]::ReadAllText($original)
    $activeContract = [regex]::Replace($contract, '(?m)^[ \t]*#.*$', '')
    # Exclude only the orphan upload schema. Automatically keep it if an active operation references it.
    if (-not $activeContract.Contains('#/components/schemas/ImportExpenseCsvRequest')) {
        $contract = [regex]::Replace($contract, '(?ms)^    ImportExpenseCsvRequest:\r?\n.*?(?=^    \S|\z)', '')
    }
    $inputSpec = Join-Path $temp 'openapi.yaml'
    [IO.File]::WriteAllText($inputSpec, $contract)
    $output = Join-Path $temp 'finances_api'
    Invoke-Checked java @('-jar', $GeneratorJar, 'generate', '-g', 'dart-dio', '-i', $inputSpec,
        '-o', $output, '-t', (Join-Path $root 'tool/templates'), '-c', (Join-Path $root 'contracts/generator.yaml'),
        '--global-property', 'apiDocs=false,modelDocs=false,apiTests=false,modelTests=false')

    Push-Location $output
    try {
        Copy-Item -LiteralPath $lock -Destination pubspec.lock
        Invoke-Checked dart @('pub', 'get', '--enforce-lockfile')
        Invoke-Checked dart @('run', 'build_runner', 'build')
        Copy-Item (Join-Path $root 'tool/generated_analysis_options.yaml') analysis_options.yaml
        Invoke-Checked dart @('format', 'lib')
        Invoke-Checked dart @('analyze')
    } finally { Pop-Location }

    $published = Join-Path $temp 'published'
    New-Item -ItemType Directory -Path $published | Out-Null
    foreach ($entry in @('lib', 'pubspec.yaml', 'build.yaml', 'analysis_options.yaml')) {
        Copy-Item -LiteralPath (Join-Path $output $entry) -Destination $published -Recurse
    }

    if ($Check) {
        function Get-Manifest($folder) {
            Get-ChildItem -LiteralPath $folder -File -Recurse | ForEach-Object {
                $relative = $_.FullName.Substring($folder.Length + 1).Replace('\','/')
                if ($relative -eq 'pubspec.yaml' -or $relative -eq 'build.yaml' -or $relative -eq 'analysis_options.yaml' -or $relative.StartsWith('lib/')) {
                    $content = [IO.File]::ReadAllText($_.FullName).TrimEnd().Replace("`r`n", "`n")
                    "$relative $content"
                }
            } | Sort-Object
        }
        if (Compare-Object @(Get-Manifest $destination) @(Get-Manifest $published)) {
            throw 'Generated client is out of date. Run tool/generate_api.ps1.'
        }
    } else {
        foreach ($entry in @('lib', 'pubspec.yaml', 'build.yaml', 'analysis_options.yaml')) {
            $target = Join-Path $destination $entry
            if (Test-Path -LiteralPath $target) {
                $resolved = (Resolve-Path -LiteralPath $target).Path
                if ($resolved -ne $target) { throw "Unexpected target $resolved" }
                Remove-Item -LiteralPath $target -Recurse -Force
            }
        }
        New-Item -ItemType Directory -Path $destination -Force | Out-Null
        Copy-Item -Path (Join-Path $published '*') -Destination $destination -Recurse
    }
} finally {
    if ((Resolve-Path -LiteralPath $temp).Path -eq $temp) {
        Remove-Item -LiteralPath $temp -Recurse -Force
    }
}
