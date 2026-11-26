import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';
import 'package:personal_finances_mobile_v1/commons/widgets/design_widgets.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/expenses_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/pages/expense_form_page.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/widgets/expense_tile.dart';

class ExpenseDetailPage extends ConsumerStatefulWidget {
  const ExpenseDetailPage({required this.expense, super.key});

  final Expense expense;

  @override
  ConsumerState<ExpenseDetailPage> createState() => _ExpenseDetailPageState();
}

class _ExpenseDetailPageState extends ConsumerState<ExpenseDetailPage> {
  bool _deleting = false;

  @override
  Widget build(BuildContext context) {
    final expense = widget.expense;
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final date = DateFormat(
      'd MMM yyyy · HH:mm',
      'es_PE',
    ).format(expense.date.toLocal());

    return DesignPage(
      title: 'Detalle del gasto',
      child: ListView(
        padding: const EdgeInsets.fromLTRB(24, 18, 24, 32),
        children: [
          Text(date),
          const SizedBox(height: 24),
          DecoratedBox(
            decoration: const BoxDecoration(
              color: AppTheme.navy,
              borderRadius: AppTheme.cardRadius,
            ),
            child: Padding(
              padding: const EdgeInsets.all(18),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expenseTitle(expense),
                    style: theme.textTheme.titleMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    expenseAmount(expense),
                    style: theme.textTheme.headlineLarge?.copyWith(
                      color: Colors.white,
                      fontSize: 36,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    [
                      expense.category ?? 'Sin categoría',
                      expense.money.currency.code,
                    ].join(' · '),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (!expense.money.currency.isKnown) ...[
            const SizedBox(height: 16),
            DesignNotice(
              title: 'Moneda sin identificar',
              message: 'Edita el gasto para seleccionar la moneda correcta.',
              color: AppTheme.sand,
              ink: AppTheme.amber,
            ),
          ],
          const SizedBox(height: 32),
          Card(
            child: ListTile(
              title: const Text('Origen'),
              subtitle: Text(expense.source),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child: ListTile(
              title: const Text('Comentario'),
              subtitle: Text(expense.comments ?? 'Sin comentario'),
            ),
          ),
          const SizedBox(height: 32),
          FilledButton(
            onPressed: _deleting ? null : _edit,
            child: Text(
              expense.money.currency.isKnown
                  ? 'Editar gasto'
                  : 'Completar gasto',
            ),
          ),
          const SizedBox(height: 12),
          FilledButton.tonal(
            style: FilledButton.styleFrom(
              backgroundColor: colors.errorContainer,
              foregroundColor: colors.onErrorContainer,
            ),
            onPressed: _deleting ? null : _delete,
            child: Text(_deleting ? 'Eliminando…' : 'Eliminar gasto'),
          ),
        ],
      ),
    );
  }

  Future<void> _edit() async {
    final saved = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (_) => ExpenseFormPage(expense: widget.expense),
      ),
    );
    if (saved == true && mounted) Navigator.pop(context);
  }

  Future<void> _delete() async {
    final expense = widget.expense;
    final confirmed = await confirmDesignAction(
      context,
      title: 'Eliminar gasto',
      message:
          '${expenseTitle(expense)} · ${expenseAmount(expense)}\nSe retirará de tus movimientos.',
      action: 'Eliminar gasto',
    );
    if (!confirmed || !mounted) return;
    setState(() => _deleting = true);
    try {
      final deleted = await ref
          .read(expensesControllerProvider.notifier)
          .delete(expense.id);
      if (deleted && mounted) Navigator.pop(context);
    } finally {
      if (mounted) setState(() => _deleting = false);
    }
  }
}
