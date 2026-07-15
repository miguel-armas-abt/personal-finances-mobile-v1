# Finanzas Personales · Flutter

## ▶️ Arranque local en Android

1. Instala Flutter con Dart compatible con [pubspec.yaml](pubspec.yaml) y Android Studio con Android SDK, Platform Tools y Emulator.
2. Levanta el backend en el puerto `8080` con `mvn quarkus:dev` desde su repositorio. Usa su README para configurar los servicios y variables que necesita.
3. Abre **Device Manager** en Android Studio e inicia un emulador con Google Play. Abre la raíz de este proyecto, donde están `pubspec.yaml` y `lib/main.dart`.
4. Confirma el entorno desde una terminal en esa raíz.

```powershell
flutter doctor -v
flutter doctor --android-licenses # Si flutter doctor indica licencias pendientes
flutter pub get
flutter devices
```

| Valor | Configuración local |
| --- | --- |
| `API_BASE_URL` | `http://10.0.2.2:8080/poc/personal-finances/v1` para el emulador Android. `10.0.2.2` apunta al equipo que ejecuta el emulador. En un teléfono físico usa la IP del equipo en tu red. |
| `GOOGLE_WEB_CLIENT_ID` | ID del cliente OAuth de tipo **Aplicación web** en Google Cloud. Debe coincidir con `GOOGLE_WEB_CLIENT_ID` en el backend, que lo usa para validar la audiencia del token. Los perfiles de VS Code e IntelliJ ya incluyen el valor de desarrollo. |
| `CALLER_NAME` | `personal-finances-mobile` por defecto. |

Para iniciar sesión, registra en Google el `applicationId` de [Android](android/app/build.gradle.kts) junto con el SHA-1 de la firma de depuración. Obtén el SHA-1 ejecutando `./gradlew.bat signingReport` desde `android/` en Windows después de la primera compilación Android, que prepara el wrapper de Gradle. El ID OAuth es público. Los secretos permanecen en el backend. [Configuración de Google Sign-In para Android](https://pub.dev/packages/google_sign_in_android).

### Opción 1 · VS Code

1. Instala la extensión **Flutter**. Selecciona el emulador desde la barra de estado o con `Ctrl+Shift+P` → **Flutter: Select Device**.
2. En **Run and Debug**, elige **Flutter Android - Dev** y pulsa **F5**. Los argumentos están en [.vscode/launch.json](.vscode/launch.json).
3. Durante la sesión usa **Ctrl+F5** para hot reload, **Ctrl+Shift+F5** para hot restart y **Shift+F5** para detener. [Guía oficial de Flutter para VS Code](https://docs.flutter.dev/tools/vs-code).

### Opción 2 · Android Studio o IntelliJ IDEA

1. Instala el plugin **Flutter** y selecciona el emulador en la barra de herramientas.
2. Selecciona **Flutter Android - Dev** en el selector de configuraciones de ejecución. El perfil incluye los argumentos para conectar con el backend local y configurar Google Sign-In. Está guardado en [.run/Flutter_Android_Dev.run.xml](.run/Flutter_Android_Dev.run.xml).

3. Usa **Shift+F10** para ejecutar o **Shift+F9** para depurar en Windows. Pulsa el rayo para hot reload o **Shift+clic** en el rayo para hot restart. [Flutter en Android Studio](https://docs.flutter.dev/tools/android-studio) · [Atajos de Android Studio](https://developer.android.com/studio/intro/keyboard-shortcuts).

### Opción 3 · Terminal

```powershell
flutter emulators
flutter emulators --launch <ID_EMULADOR>
flutter devices
flutter run -d <ID_DISPOSITIVO> --dart-define=GOOGLE_WEB_CLIENT_ID=<CLIENT_ID_WEB>
```

En la sesión de `flutter run`, pulsa **r** para hot reload, **R** para hot restart o **q** para salir. Para cambiar los `--dart-define`, detén y vuelve a ejecutar la app.

Si Flutter no detecta el emulador, comprueba **Device Manager** y `flutter devices`. Si falla la conexión, comprueba que el backend escuche en `8080`, la URL base y el dispositivo seleccionado. Si aparece un error de symlinks en Windows, activa **Modo para desarrolladores** en Configuración.

## 🔄 Clientes REST

El [contrato versionado](contracts/openapi.yaml) viene de `personal-finances-v1/src/main/resources/META-INF/openapi.yaml`. El snapshot inicial corresponde a `a5142bbac45d1815c7c022bd4d460ac0621c358a`. Al actualizarlo, registra también la nueva revisión aquí. La app usa el paquete generado incluido en el repositorio para iniciar con `flutter pub get`.

Para actualizar el cliente, sustituye el contrato y ejecuta desde la raíz con JDK 17+, el Dart de Flutter y PowerShell. El script valida el contrato, descarga y verifica OpenAPI Generator 7.22.0, genera el código Dio y ejecuta la serialización con dependencias fijadas.

```powershell
powershell -ExecutionPolicy Bypass -File tool/generate_api.ps1
powershell -ExecutionPolicy Bypass -File tool/generate_api.ps1 -Check
flutter pub get
flutter analyze
flutter test
```

`-GeneratorJar <ruta>` permite reutilizar un JAR local de la versión fijada. La generación ajusta el SDK del paquete a través de una plantilla y omite el esquema de importación CSV solo mientras ninguna operación activa lo referencie. Para sumar una operación sin contrato, implementa su acceso en el repositorio funcional correspondiente. Los clientes consumidos hoy se generan desde OpenAPI.

## 📁 Estructura

```text
lib/app/                                  Arranque, composición, rutas y pantalla principal
lib/commons/                              Configuración, red, errores, almacenamiento y tema
lib/personal_finances/auth/session/         Inicio y restauración de sesión
lib/personal_finances/expenses/crud/        Consulta, edición y sincronización de gastos
lib/personal_finances/expenses/categories/ Configuración y asignación de categorías
packages/finances_api/                    Cliente generado
```

Cada subdominio agrupa su presentación, repositorios, modelos y mapeos. Los repositorios encapsulan el acceso a fuentes externas. El logger REST de depuración registra operación, estado, duración y trazabilidad.
