import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/model/expense_category.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/presentation/controllers/categories_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settingsValue = ref.watch(categoriesControllerProvider);

    return settingsValue.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, stackTrace) => _CategoryError(
        message: error is AppFailure
            ? error.message
            : 'No se pudieron cargar las categorías.',
        onRetry: () => ref.invalidate(categoriesControllerProvider),
      ),
      data: (settings) => _CategoryEditor(initialSettings: settings),
    );
  }
}

class _CategoryEditor extends ConsumerStatefulWidget {
  const _CategoryEditor({required this.initialSettings});

  final ExpenseCategorySettings initialSettings;

  @override
  ConsumerState<_CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends ConsumerState<_CategoryEditor> {
  late ExpenseCategorySettings _settings;
  bool _busy = false;
  bool _overwriteExisting = false;

  @override
  void initState() {
    super.initState();
    _settings = widget.initialSettings;
  }

  @override
  void didUpdateWidget(covariant _CategoryEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initialSettings != widget.initialSettings) {
      _settings = widget.initialSettings;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.separated(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 88),
        itemCount: _settings.categories.length + 1,
        separatorBuilder: (context, index) => const SizedBox(height: 8),
        itemBuilder: (context, index) {
          if (index == 0) {
            return _CategoryActions(
              currency: _settings.currency,
              overwriteExisting: _overwriteExisting,
              onCurrencyChanged: (currency) => setState(() {
                _settings = ExpenseCategorySettings(
                  currency: currency,
                  categories: _settings.categories,
                );
              }),
              onOverwriteChanged: (value) =>
                  setState(() => _overwriteExisting = value),
              onAssign: _busy ? null : _assignExisting,
              onSave: _busy ? null : _save,
            );
          }
          final category = _settings.categories[index - 1];
          return _CategoryTile(
            category: category,
            currency: _settings.currency,
            onEdit: () =>
                _openCategoryDialog(category: category, index: index - 1),
            onDelete: () => setState(() {
              final categories = [..._settings.categories]..removeAt(index - 1);
              _settings = ExpenseCategorySettings(
                currency: _settings.currency,
                categories: categories,
              );
            }),
          );
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: _busy ? null : () => _openCategoryDialog(),
        icon: const Icon(Icons.add),
        label: const Text('Categoría'),
      ),
    );
  }

  Future<void> _save() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      await ref.read(categoriesControllerProvider.notifier).save(_settings);
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Categor\u00edas guardadas.')),
      );
    } on AppFailure catch (failure) {
      if (!mounted) return;
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _assignExisting() async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      final updated = await ref
          .read(categoriesControllerProvider.notifier)
          .assignExisting(
            from: DateTime.now().subtract(const Duration(days: 365)),
            overwriteExistingCategories: _overwriteExisting,
          );
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Gastos actualizados: $updated')));
    } on AppFailure catch (failure) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(failure.message)));
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  Future<void> _openCategoryDialog({
    ExpenseCategory? category,
    int? index,
  }) async {
    final result = await showDialog<ExpenseCategory>(
      context: context,
      builder: (context) => _CategoryDialog(category: category),
    );
    if (result == null) {
      return;
    }
    setState(() {
      final categories = [..._settings.categories];
      if (index == null) {
        categories.add(result);
      } else {
        categories[index] = result;
      }
      _settings = ExpenseCategorySettings(
        currency: _settings.currency,
        categories: categories,
      );
    });
  }
}

class _CategoryActions extends StatelessWidget {
  const _CategoryActions({
    required this.currency,
    required this.overwriteExisting,
    required this.onCurrencyChanged,
    required this.onOverwriteChanged,
    required this.onAssign,
    required this.onSave,
  });

  final CurrencyCode currency;
  final bool overwriteExisting;
  final ValueChanged<CurrencyCode> onCurrencyChanged;
  final ValueChanged<bool> onOverwriteChanged;
  final VoidCallback? onAssign;
  final VoidCallback? onSave;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: DropdownButtonFormField<CurrencyCode>(
                initialValue: currency,
                decoration: const InputDecoration(
                  labelText: 'Moneda de límites',
                  prefixIcon: Icon(Icons.currency_exchange),
                ),
                items: CurrencyCode.values
                    .map(
                      (value) => DropdownMenuItem(
                        value: value,
                        child: Text(value.code),
                      ),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value != null) {
                    onCurrencyChanged(value);
                  }
                },
              ),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: onSave,
              icon: const Icon(Icons.save),
              label: const Text('Guardar'),
            ),
          ],
        ),
        SwitchListTile(
          contentPadding: EdgeInsets.zero,
          title: const Text('Recalcular gastos categorizados'),
          value: overwriteExisting,
          onChanged: onOverwriteChanged,
        ),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: onAssign,
            icon: const Icon(Icons.auto_fix_high),
            label: const Text('Aplicar a gastos existentes'),
          ),
        ),
      ],
    );
  }
}

class _CategoryTile extends StatelessWidget {
  const _CategoryTile({
    required this.category,
    required this.currency,
    required this.onEdit,
    required this.onDelete,
  });

  final ExpenseCategory category;
  final CurrencyCode currency;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final format = NumberFormat.currency(
      locale: 'es_PE',
      symbol: '${currency.symbol} ',
    );
    return Card(
      child: ListTile(
        title: Text(category.name),
        subtitle: Text(
          category.recipientPatterns.isEmpty
              ? 'Sin patrones'
              : category.recipientPatterns
                    .map((pattern) => '${pattern.code.code}: ${pattern.value}')
                    .join(' · '),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              format.format(category.limit.amount / 100),
              style: Theme.of(context).textTheme.titleMedium,
            ),
            PopupMenuButton<String>(
              tooltip: 'Opciones',
              onSelected: (value) {
                if (value == 'edit') {
                  onEdit();
                }
                if (value == 'delete') {
                  onDelete();
                }
              },
              itemBuilder: (context) => const [
                PopupMenuItem(value: 'edit', child: Text('Editar')),
                PopupMenuItem(value: 'delete', child: Text('Eliminar')),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _CategoryDialog extends StatefulWidget {
  const _CategoryDialog({this.category});

  final ExpenseCategory? category;

  @override
  State<_CategoryDialog> createState() => _CategoryDialogState();
}

class _CategoryDialogState extends State<_CategoryDialog> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _nameController;
  late final TextEditingController _limitController;
  late final TextEditingController _patternController;
  late RecipientPatternCode _patternCode;

  @override
  void initState() {
    super.initState();
    final category = widget.category;
    final firstPattern = category?.recipientPatterns.firstOrNull;
    _nameController = TextEditingController(text: category?.name ?? '');
    _limitController = TextEditingController(
      text: category == null ? '' : formatMinorUnits(category.limit.amount),
    );
    _patternController = TextEditingController(text: firstPattern?.value ?? '');
    _patternCode = firstPattern?.code ?? RecipientPatternCode.contains;
  }

  @override
  void dispose() {
    _nameController.dispose();
    _limitController.dispose();
    _patternController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        widget.category == null ? 'Nueva categoría' : 'Editar categoría',
      ),
      content: Form(
        key: _formKey,
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(labelText: 'Nombre'),
                validator: _requiredText,
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _limitController,
                decoration: const InputDecoration(labelText: 'Límite'),
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                validator: _positiveAmount,
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<RecipientPatternCode>(
                initialValue: _patternCode,
                decoration: const InputDecoration(labelText: 'Patrón'),
                items: RecipientPatternCode.values
                    .map(
                      (code) =>
                          DropdownMenuItem(value: code, child: Text(code.code)),
                    )
                    .toList(growable: false),
                onChanged: (value) {
                  if (value != null) {
                    setState(() => _patternCode = value);
                  }
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: _patternController,
                decoration: const InputDecoration(
                  labelText: 'Texto destinatario',
                ),
              ),
            ],
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancelar'),
        ),
        FilledButton(onPressed: _submit, child: const Text('Guardar')),
      ],
    );
  }

  void _submit() {
    if (!(_formKey.currentState?.validate() ?? false)) {
      return;
    }
    final patternText = _patternController.text.trim();
    Navigator.of(context).pop(
      ExpenseCategory(
        name: _nameController.text.trim(),
        limit: CategoryLimit(
          amount: parseMinorUnits(_limitController.text.replaceAll(',', '.')),
          isExceeded: widget.category?.limit.isExceeded ?? false,
          balance: widget.category?.limit.balance ?? 0,
        ),
        recipientPatterns: patternText.isEmpty
            ? const []
            : [RecipientPattern(code: _patternCode, value: patternText)],
      ),
    );
  }

  String? _requiredText(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Campo requerido.';
    }
    return null;
  }

  String? _positiveAmount(String? value) {
    final amount = tryParseMinorUnits((value ?? '').replaceAll(',', '.'));
    if (amount == null || amount <= 0) {
      return 'Ingresa un monto mayor a cero.';
    }
    return null;
  }
}

class _CategoryError extends StatelessWidget {
  const _CategoryError({required this.message, required this.onRetry});

  final String message;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              Icons.error_outline,
              color: Theme.of(context).colorScheme.error,
            ),
            const SizedBox(height: 12),
            Text(message, textAlign: TextAlign.center),
            const SizedBox(height: 12),
            OutlinedButton.icon(
              onPressed: onRetry,
              icon: const Icon(Icons.refresh),
              label: const Text('Reintentar'),
            ),
          ],
        ),
      ),
    );
  }
}
