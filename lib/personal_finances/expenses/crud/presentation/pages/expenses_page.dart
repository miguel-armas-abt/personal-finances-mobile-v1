import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finances_mobile_v1/app/router/app_router.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/expenses_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/widgets/expense_tile.dart';

class ExpensesPage extends ConsumerStatefulWidget {
  const ExpensesPage({super.key});

  @override
  ConsumerState<ExpensesPage> createState() => _ExpensesPageState();
}

class _ExpensesPageState extends ConsumerState<ExpensesPage> {
  final _recipientController = TextEditingController();
  String? _currency;

  @override
  void dispose() {
    _recipientController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(expensesControllerProvider);

    ref.listen(expensesControllerProvider.select((value) => value.message), (
      _,
      message,
    ) {
      if (message != null && mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return Scaffold(
      body: RefreshIndicator(
        onRefresh: () =>
            ref.read(expensesControllerProvider.notifier).loadFirstPage(),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 8),
                child: _ExpenseFilters(
                  recipientController: _recipientController,
                  currency: _currency,
                  onCurrencyChanged: (value) =>
                      setState(() => _currency = value),
                  onApply: () {
                    ref
                        .read(expensesControllerProvider.notifier)
                        .loadFirstPage(
                          criteria: ExpenseSearchCriteria(
                            recipient: _recipientController.text,
                            currency: _currency,
                          ),
                        );
                  },
                  onSync: state.isSyncing
                      ? null
                      : () => ref
                            .read(expensesControllerProvider.notifier)
                            .syncFromGmail(),
                  isSyncing: state.isSyncing,
                ),
              ),
            ),
            if (state.isLoading)
              const SliverFillRemaining(
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.expenses.isEmpty)
              const SliverFillRemaining(
                child: Center(child: Text('Aún no hay gastos para mostrar.')),
              )
            else
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 88),
                sliver: SliverList.separated(
                  itemCount: state.expenses.length + (state.hasMore ? 1 : 0),
                  separatorBuilder: (context, index) =>
                      const SizedBox(height: 8),
                  itemBuilder: (context, index) {
                    if (index == state.expenses.length) {
                      return Center(
                        child: OutlinedButton.icon(
                          onPressed: state.isLoadingMore
                              ? null
                              : () => ref
                                    .read(expensesControllerProvider.notifier)
                                    .loadMore(),
                          icon: state.isLoadingMore
                              ? const SizedBox.square(
                                  dimension: 16,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Icon(Icons.expand_more),
                          label: const Text('Cargar más'),
                        ),
                      );
                    }
                    final expense = state.expenses[index];
                    return ExpenseTile(
                      expense: expense,
                      onEdit: () =>
                          context.push(AppRoutes.editExpense, extra: expense),
                      onDelete: () => ref
                          .read(expensesControllerProvider.notifier)
                          .delete(expense.id),
                    );
                  },
                ),
              ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        heroTag: null,
        onPressed: () => context.push(AppRoutes.newExpense),
        icon: const Icon(Icons.add),
        label: const Text('Gasto'),
      ),
    );
  }
}

class _ExpenseFilters extends StatelessWidget {
  const _ExpenseFilters({
    required this.recipientController,
    required this.currency,
    required this.onCurrencyChanged,
    required this.onApply,
    required this.onSync,
    required this.isSyncing,
  });

  final TextEditingController recipientController;
  final String? currency;
  final ValueChanged<String?> onCurrencyChanged;
  final VoidCallback onApply;
  final VoidCallback? onSync;
  final bool isSyncing;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
              child: TextField(
                controller: recipientController,
                decoration: const InputDecoration(
                  labelText: 'Destinatario',
                  prefixIcon: Icon(Icons.search),
                ),
                textInputAction: TextInputAction.search,
                onSubmitted: (_) => onApply(),
              ),
            ),
            const SizedBox(width: 8),
            SizedBox(
              width: 112,
              child: DropdownButtonFormField<String>(
                initialValue: currency,
                decoration: const InputDecoration(labelText: 'Moneda'),
                items: const [
                  DropdownMenuItem(value: 'PEN', child: Text('PEN')),
                  DropdownMenuItem(value: 'USD', child: Text('USD')),
                ],
                onChanged: onCurrencyChanged,
              ),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(
              child: OutlinedButton.icon(
                onPressed: onSync,
                icon: isSyncing
                    ? const SizedBox.square(
                        dimension: 16,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : const Icon(Icons.sync),
                label: const Text('Sincronizar Gmail'),
              ),
            ),
            const SizedBox(width: 8),
            FilledButton.icon(
              onPressed: onApply,
              icon: const Icon(Icons.filter_alt),
              label: const Text('Filtrar'),
            ),
          ],
        ),
      ],
    );
  }
}
