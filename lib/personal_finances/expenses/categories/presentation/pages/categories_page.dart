import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';
import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:personal_finances_mobile_v1/commons/widgets/design_widgets.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/model/expense_category.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/presentation/controllers/categories_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

class CategoriesPage extends ConsumerWidget {
  const CategoriesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final settings = ref.watch(categoriesControllerProvider);
    return settings.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (error, _) => ListView(
        padding: const EdgeInsets.all(24),
        children: [
          DesignNotice(
            title: 'No pudimos cargar tus categorías',
            message: error is AppFailure
                ? error.message
                : 'Revisa tu conexión y vuelve a intentar.',
            color: AppTheme.sand,
            ink: AppTheme.amber,
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => ref.invalidate(categoriesControllerProvider),
            child: const Text('Reintentar'),
          ),
        ],
      ),
      data: (value) => _CategoryEditor(initial: value),
    );
  }
}

class _CategoryEditor extends ConsumerStatefulWidget {
  const _CategoryEditor({required this.initial});

  final ExpenseCategorySettings initial;

  @override
  ConsumerState<_CategoryEditor> createState() => _CategoryEditorState();
}

class _CategoryEditorState extends ConsumerState<_CategoryEditor> {
  late ExpenseCategorySettings _settings = widget.initial;
  bool _busy = false;
  bool get _dirty => !identical(_settings, widget.initial);

  @override
  void didUpdateWidget(covariant _CategoryEditor oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.initial != widget.initial) _settings = widget.initial;
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final categories = _settings.categories;
    final exceeded = _dirty
        ? null
        : categories.where((category) => category.limit.isExceeded).firstOrNull;

    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
      children: [
        const Text('Límites y reglas para clasificar gastos'),
        const SizedBox(height: 24),
        DropdownButtonFormField<CurrencyCode>(
          initialValue: _settings.currency,
          decoration: const InputDecoration(labelText: 'Moneda de límites'),
          items: [
            for (final currency in CurrencyCode.values)
              DropdownMenuItem(value: currency, child: Text(currency.code)),
          ],
          onChanged: _busy
              ? null
              : (currency) {
                  if (currency == null || currency == _settings.currency) {
                    return;
                  }
                  setState(
                    () => _settings = ExpenseCategorySettings(
                      currency: currency,
                      categories: categories,
                    ),
                  );
                },
        ),
        const SizedBox(height: 16),
        if (_dirty) ...[
          DesignNotice(
            title: 'Hay cambios pendientes',
            message: _settings.currency == widget.initial.currency
                ? 'Guarda para aplicar el conjunto de categorías.'
                : 'Al guardar, los límites se interpretarán en ${_settings.currency.code}.',
          ),
          const SizedBox(height: 16),
        ] else if (exceeded != null) ...[
          DesignNotice(
            title: 'Límite excedido · ${exceeded.name}',
            message:
                '${_amount(exceeded.limit.balance.abs())} por encima del límite',
            color: colors.errorContainer,
            ink: colors.onErrorContainer,
          ),
          const SizedBox(height: 16),
        ],
        if (categories.isEmpty) ...[
          const DesignNotice(
            title: 'Aún no tienes categorías',
            message: 'Añade una categoría para organizar tus gastos.',
          ),
          const SizedBox(height: 10),
        ],
        for (final (index, category) in categories.indexed) ...[
          _CategoryLimitCard(
            category: category,
            index: index,
            currency: _settings.currency,
            onTap: _busy ? null : () => _edit(index: index),
          ),
          const SizedBox(height: 9),
        ],
        const SizedBox(height: 17),
        OverflowBar(
          alignment: MainAxisAlignment.spaceBetween,
          overflowSpacing: 8,
          children: [
            FilledButton.tonal(
              style: FilledButton.styleFrom(
                backgroundColor: colors.primaryContainer,
                foregroundColor: colors.onPrimaryContainer,
              ),
              onPressed: _busy ? null : () => _edit(),
              child: const Text('+ Categoría'),
            ),
            FilledButton(
              onPressed: _busy || !_dirty ? null : _save,
              child: Text(_busy ? 'Procesando…' : 'Guardar cambios'),
            ),
          ],
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: _busy || _dirty ? null : _confirmAssignment,
          child: const Text('Aplicar reglas a gastos existentes'),
        ),
      ],
    );
  }

  String _amount(int amount) => NumberFormat.currency(
    locale: 'en_US',
    symbol: '${_settings.currency.symbol} ',
  ).format(amount / 100);

  Future<void> _edit({int? index}) async {
    final category = index == null ? null : _settings.categories[index];
    final result =
        await Navigator.push<({ExpenseCategory? category, bool remove})>(
          context,
          MaterialPageRoute(builder: (_) => _CategoryForm(category: category)),
        );
    if (result == null || !mounted) return;
    final categories = [..._settings.categories];
    if (result.remove && index != null) {
      categories.removeAt(index);
    } else if (result.category case final value?) {
      if (index == null) {
        categories.add(value);
      } else {
        categories[index] = value;
      }
    }
    setState(
      () => _settings = ExpenseCategorySettings(
        currency: _settings.currency,
        categories: categories,
      ),
    );
  }

  Future<void> _save() => _run(() async {
    await ref.read(categoriesControllerProvider.notifier).save(_settings);
    return 'Categorías guardadas.';
  });

  Future<void> _confirmAssignment() async {
    final overwrite = await Navigator.push<bool>(
      context,
      MaterialPageRoute(builder: (_) => const _AssignmentPage()),
    );
    if (overwrite == null || !mounted) return;
    await _run(() async {
      final updated = await ref
          .read(categoriesControllerProvider.notifier)
          .assignExisting(
            from: DateTime.now().subtract(const Duration(days: 365)),
            overwriteExistingCategories: overwrite,
          );
      return 'Gastos actualizados: $updated';
    });
  }

  Future<void> _run(Future<String> Function() command) async {
    if (_busy) return;
    setState(() => _busy = true);
    try {
      _notify(await command());
    } on AppFailure catch (failure) {
      _notify(failure.message);
    } finally {
      if (mounted) setState(() => _busy = false);
    }
  }

  void _notify(String message) {
    if (mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }
}

class _CategoryLimitCard extends StatelessWidget {
  const _CategoryLimitCard({
    required this.category,
    required this.index,
    required this.currency,
    required this.onTap,
  });

  final ExpenseCategory category;
  final int index;
  final CurrencyCode currency;
  final VoidCallback? onTap;

  String _amount(int amount) => NumberFormat.currency(
    locale: 'en_US',
    symbol: '${currency.symbol} ',
  ).format(amount / 100);

  @override
  Widget build(BuildContext context) {
    final limit = category.limit.amount;
    final remaining = category.limit.balance;
    final spent = limit - remaining;
    final progress = limit <= 0 ? 0.0 : (spent / limit).clamp(0.0, 1.0);
    final colors = Theme.of(context).colorScheme;
    final status = category.limit.isExceeded
        ? 'Excedido por ${_amount(remaining.abs())}'
        : 'Disponible ${_amount(remaining)}';

    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(20),
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(13, 12, 15, 13),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  DesignBadge(
                    label: String.fromCharCodes(
                      category.name.runes.take(2),
                    ).toUpperCase(),
                    index: index,
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          category.name,
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Gastado ${_amount(spent)} de ${_amount(limit)}',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    status,
                    textAlign: TextAlign.end,
                    style: Theme.of(context).textTheme.labelMedium?.copyWith(
                      color: category.limit.isExceeded
                          ? colors.error
                          : colors.primary,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Semantics(
                label:
                    'L?mite de ${category.name}: ${_amount(spent)} gastados de ${_amount(limit)}',
                child: LinearProgressIndicator(
                  value: progress,
                  minHeight: 7,
                  borderRadius: BorderRadius.circular(8),
                  color: category.limit.isExceeded
                      ? colors.error
                      : colors.primary,
                  backgroundColor: colors.surfaceContainerHighest,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AssignmentPage extends StatefulWidget {
  const _AssignmentPage();

  @override
  State<_AssignmentPage> createState() => _AssignmentPageState();
}

class _AssignmentPageState extends State<_AssignmentPage> {
  bool _overwrite = false;

  @override
  Widget build(BuildContext context) => DesignPage(
    title: 'Aplicar reglas',
    child: ListView(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
      children: [
        const Text('Revisa el alcance antes de ejecutar.'),
        const SizedBox(height: 24),
        const Card(
          child: ListTile(
            title: Text('Periodo'),
            subtitle: Text('Últimos 365 días'),
          ),
        ),
        const SizedBox(height: 12),
        Card(
          child: SwitchListTile(
            title: const Text('Reemplazar categorías existentes'),
            value: _overwrite,
            onChanged: (value) => setState(() => _overwrite = value),
          ),
        ),
        if (_overwrite) ...[
          const SizedBox(height: 16),
          const DesignNotice(
            title: 'Se recalcularán categorías previas',
            message: 'El cambio puede afectar gastos editados a mano.',
            color: AppTheme.sand,
            ink: AppTheme.amber,
          ),
        ],
        const SizedBox(height: 24),
        FilledButton(
          onPressed: () => Navigator.pop(context, _overwrite),
          child: Text(
            _overwrite ? 'Recalcular categorías' : 'Aplicar a gastos',
          ),
        ),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('Cancelar'),
        ),
      ],
    ),
  );
}

class _CategoryForm extends StatefulWidget {
  const _CategoryForm({this.category});

  final ExpenseCategory? category;

  @override
  State<_CategoryForm> createState() => _CategoryFormState();
}

class _CategoryFormState extends State<_CategoryForm> {
  final _form = GlobalKey<FormState>();
  late final _name = TextEditingController(text: widget.category?.name);
  late final _limit = TextEditingController(
    text: widget.category == null
        ? ''
        : formatMinorUnits(widget.category!.limit.amount),
  );
  late final _recipient = TextEditingController(
    text: widget.category?.recipientPatterns.firstOrNull?.value,
  );
  late RecipientPatternCode? _pattern =
      widget.category?.recipientPatterns.firstOrNull?.code;

  @override
  void dispose() {
    _name.dispose();
    _limit.dispose();
    _recipient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final editing = widget.category != null;
    final colors = Theme.of(context).colorScheme;
    return DesignPage(
      title: editing ? 'Editar categoría' : 'Nueva categoría',
      child: Form(
        key: _form,
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
          children: [
            Text(
              editing
                  ? 'El cambio quedará pendiente de guardar.'
                  : 'Añade un límite y una regla opcional.',
            ),
            const SizedBox(height: 28),
            TextFormField(
              controller: _name,
              decoration: const InputDecoration(
                labelText: 'Nombre',
                hintText: 'Ej. Ocio',
              ),
              validator: (value) =>
                  (value ?? '').trim().isEmpty ? 'Campo requerido.' : null,
            ),
            const SizedBox(height: 11),
            TextFormField(
              controller: _limit,
              decoration: const InputDecoration(
                labelText: 'Límite',
                hintText: '0.00',
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (value) {
                final amount = tryParseMinorUnits(
                  (value ?? '').replaceAll(',', '.'),
                );
                return amount == null || amount <= 0
                    ? 'Ingresa un monto mayor a cero.'
                    : null;
              },
            ),
            const SizedBox(height: 11),
            DropdownButtonFormField<RecipientPatternCode>(
              initialValue: _pattern,
              hint: const Text('Sin patrón'),
              decoration: const InputDecoration(labelText: 'Patrón'),
              items: [
                const DropdownMenuItem(child: Text('Sin patrón')),
                for (final code in RecipientPatternCode.values)
                  DropdownMenuItem(
                    value: code,
                    child: Text(_patternLabel(code)),
                  ),
              ],
              onChanged: (value) => setState(() => _pattern = value),
            ),
            if (_pattern != null) ...[
              const SizedBox(height: 11),
              TextFormField(
                controller: _recipient,
                decoration: const InputDecoration(
                  labelText: 'Texto del destinatario',
                ),
                validator: (value) =>
                    (value ?? '').trim().isEmpty ? 'Campo requerido.' : null,
              ),
            ],
            const SizedBox(height: 40),
            FilledButton(
              onPressed: _submit,
              child: Text(editing ? 'Aplicar cambio' : 'Guardar'),
            ),
            if (editing) ...[
              const SizedBox(height: 12),
              FilledButton.tonal(
                style: FilledButton.styleFrom(
                  backgroundColor: colors.errorContainer,
                  foregroundColor: colors.onErrorContainer,
                ),
                onPressed: () => Navigator.pop(context, (
                  category: null as ExpenseCategory?,
                  remove: true,
                )),
                child: const Text('Quitar del borrador'),
              ),
            ],
          ],
        ),
      ),
    );
  }

  void _submit() {
    if (!_form.currentState!.validate()) return;
    final category = ExpenseCategory(
      name: _name.text.trim(),
      limit: CategoryLimit(
        amount: parseMinorUnits(_limit.text.replaceAll(',', '.')),
        isExceeded: false,
        balance: 0,
      ),
      recipientPatterns: [
        if (_pattern case final pattern?)
          RecipientPattern(code: pattern, value: _recipient.text.trim()),
        ...?widget.category?.recipientPatterns.skip(1),
      ],
    );
    Navigator.pop(context, (category: category, remove: false));
  }
}

String _patternLabel(RecipientPatternCode code) => switch (code) {
  RecipientPatternCode.sameAs => 'Igual a',
  RecipientPatternCode.startWith => 'Empieza con',
  RecipientPatternCode.contains => 'Contiene',
  RecipientPatternCode.endsWith => 'Termina con',
};
