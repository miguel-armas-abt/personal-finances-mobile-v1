import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/app/router/app_router.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';
import 'package:personal_finances_mobile_v1/commons/widgets/design_widgets.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/expenses_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/pages/expense_detail_page.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/widgets/expense_tile.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

class ExpensesPage extends ConsumerWidget {
  const ExpensesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(expensesControllerProvider);
    final controller = ref.read(expensesControllerProvider.notifier);
    final theme = Theme.of(context);
    final colors = theme.colorScheme;
    final criteria = state.criteria;

    ref.listen(expensesControllerProvider.select((value) => value.message), (
      _,
      message,
    ) {
      if (message != null && context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(message)));
      }
    });

    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.fromLTRB(24, 12, 24, 24),
        child: OverflowBar(
          alignment: state.hasMore
              ? MainAxisAlignment.spaceBetween
              : MainAxisAlignment.end,
          overflowSpacing: 8,
          children: [
            if (state.hasMore)
              OutlinedButton(
                onPressed: state.isLoadingMore ? null : controller.loadMore,
                child: Text(state.isLoadingMore ? 'Cargando…' : 'Cargar más'),
              ),
            FilledButton(
              onPressed: () => context.push(AppRoutes.newExpense),
              child: const Text('+ Nuevo gasto'),
            ),
          ],
        ),
      ),
      body: RefreshIndicator(
        onRefresh: controller.loadFirstPage,
        child: CustomScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
              sliver: SliverToBoxAdapter(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Consulta y organiza tus movimientos'),
                    const SizedBox(height: 22),
                    Wrap(
                      spacing: 10,
                      runSpacing: 8,
                      children: [
                        FilledButton.tonal(
                          style: FilledButton.styleFrom(
                            backgroundColor: colors.primaryContainer,
                            foregroundColor: colors.onPrimaryContainer,
                          ),
                          onPressed: () => _filter(context, ref, criteria),
                          child: const Text('Filtrar'),
                        ),
                        FilledButton.tonal(
                          onPressed: state.isSyncing
                              ? null
                              : () => _sync(context, ref),
                          child: Text(
                            state.isSyncing
                                ? 'Sincronizando…'
                                : 'Sincronizar Gmail',
                          ),
                        ),
                      ],
                    ),
                    if (criteria.hasFilters) ...[
                      const SizedBox(height: 8),
                      Wrap(
                        spacing: 8,
                        children: [
                          if (criteria.recipient case final recipient?)
                            Chip(label: Text(recipient)),
                          if (criteria.currency case final currency?)
                            Chip(label: Text(currency)),
                          TextButton(
                            onPressed: () => controller.loadFirstPage(
                              criteria: const ExpenseSearchCriteria(),
                            ),
                            child: const Text('Limpiar'),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 23),
                    Text(
                      'Movimientos recientes',
                      style: theme.textTheme.titleLarge,
                    ),
                  ],
                ),
              ),
            ),
            if (state.omittedCount > 0)
              SliverPadding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 16),
                sliver: SliverToBoxAdapter(
                  child: DesignNotice(
                    title: 'Algunos gastos no se pudieron mostrar',
                    message:
                        'Registros con datos inválidos: ${state.omittedCount}.',
                    color: AppTheme.sand,
                    ink: AppTheme.amber,
                  ),
                ),
              ),
            if (state.isLoading && state.expenses.isEmpty)
              SliverPadding(
                padding: AppTheme.pagePadding,
                sliver: SliverList.list(
                  children: [
                    Semantics(
                      label: 'Cargando movimientos',
                      child: const LinearProgressIndicator(),
                    ),
                    for (var index = 0; index < 4; index++)
                      const Padding(
                        padding: EdgeInsets.only(top: 10),
                        child: Card(child: SizedBox(height: 62)),
                      ),
                  ],
                ),
              )
            else if (state.expenses.isEmpty)
              SliverPadding(
                padding: AppTheme.pagePadding,
                sliver: SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      DesignNotice(
                        title: state.loadError != null
                            ? 'No pudimos cargar tus gastos'
                            : criteria.hasFilters
                            ? 'No hay coincidencias'
                            : 'Aún no tienes gastos',
                        message:
                            state.loadError ??
                            (criteria.hasFilters
                                ? 'Prueba otros filtros para buscar movimientos.'
                                : 'Registra un gasto o sincroniza tu Gmail.'),
                        color: state.loadError == null
                            ? AppTheme.lavender
                            : AppTheme.sand,
                        ink: state.loadError == null
                            ? AppTheme.primary
                            : AppTheme.amber,
                      ),
                      if (state.loadError != null) ...[
                        const SizedBox(height: 12),
                        OutlinedButton(
                          onPressed: controller.loadFirstPage,
                          child: const Text('Reintentar'),
                        ),
                      ],
                    ],
                  ),
                ),
              )
            else
              SliverPadding(
                padding: AppTheme.pagePadding,
                sliver: SliverList.builder(
                  itemCount: state.expenses.length,
                  itemBuilder: (context, index) {
                    final expense = state.expenses[index];
                    final month = DateUtils.dateOnly(expense.date.toLocal());
                    final prev = index == 0
                        ? null
                        : state.expenses[index - 1].date.toLocal();
                    final heading =
                        prev == null ||
                        prev.month != month.month ||
                        prev.year != month.year;
                    final period = DateFormat(
                      'MMMM yyyy',
                      'es_PE',
                    ).format(month);
                    return Column(
                      key: ValueKey(expense.id),
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        if (heading) ...[
                          Text(
                            period[0].toUpperCase() + period.substring(1),
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                          const SizedBox(height: 12),
                        ],
                        ExpenseTile(
                          expense: expense,
                          index: index,
                          onOpen: () => Navigator.push<void>(
                            context,
                            MaterialPageRoute(
                              builder: (_) =>
                                  ExpenseDetailPage(expense: expense),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  },
                ),
              ),
            if (state.loadError != null &&
                state.expenses.isNotEmpty &&
                !state.isLoading)
              SliverPadding(
                padding: AppTheme.pagePadding,
                sliver: SliverToBoxAdapter(
                  child: OutlinedButton(
                    onPressed: controller.loadFirstPage,
                    child: const Text('Reintentar'),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Future<void> _filter(
    BuildContext context,
    WidgetRef ref,
    ExpenseSearchCriteria criteria,
  ) async {
    final result = await Navigator.push<ExpenseSearchCriteria>(
      context,
      MaterialPageRoute(builder: (_) => _ExpenseFilters(criteria: criteria)),
    );
    if (result == null || !context.mounted) return;
    await ref
        .read(expensesControllerProvider.notifier)
        .loadFirstPage(criteria: result);
  }

  Future<void> _sync(BuildContext context, WidgetRef ref) async {
    final confirmed = await Navigator.push<bool>(
      context,
      MaterialPageRoute(
        builder: (context) => DesignPage(
          title: 'Sincronizar Gmail',
          child: ListView(
            padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
            children: [
              const Text('Importa gastos detectados en correos compatibles.'),
              const SizedBox(height: 24),
              const DesignNotice(
                title: 'Permiso de lectura de Gmail',
                message: 'Google te pedirá autorización para continuar.',
              ),
              const SizedBox(height: 30),
              FilledButton(
                onPressed: () => Navigator.pop(context, true),
                child: const Text('Continuar a Google'),
              ),
              const SizedBox(height: 12),
              OutlinedButton(
                onPressed: () => Navigator.pop(context, false),
                child: const Text('Cancelar'),
              ),
            ],
          ),
        ),
      ),
    );
    if (confirmed != true || !context.mounted) return;
    await ref.read(expensesControllerProvider.notifier).syncFromGmail();
  }
}

class _ExpenseFilters extends StatefulWidget {
  const _ExpenseFilters({required this.criteria});

  final ExpenseSearchCriteria criteria;

  @override
  State<_ExpenseFilters> createState() => _ExpenseFiltersState();
}

class _ExpenseFiltersState extends State<_ExpenseFilters> {
  late final TextEditingController _recipient = TextEditingController(
    text: widget.criteria.recipient,
  );
  late String? _currency = widget.criteria.currency;

  @override
  void dispose() {
    _recipient.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => DesignPage(
    title: 'Filtrar gastos',
    child: ListView(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
      children: [
        const Text('Busca por destinatario y moneda'),
        const SizedBox(height: 26),
        TextField(
          controller: _recipient,
          decoration: const InputDecoration(
            labelText: 'Destinatario',
            hintText: 'Ej. Mercado Central',
          ),
          textInputAction: TextInputAction.search,
          onSubmitted: (_) => _apply(),
        ),
        const SizedBox(height: 12),
        DropdownButtonFormField<String>(
          initialValue: _currency ?? '',
          decoration: const InputDecoration(labelText: 'Moneda'),
          items: [
            const DropdownMenuItem(value: '', child: Text('Todas')),
            for (final currency in CurrencyCode.values)
              DropdownMenuItem(
                value: currency.code,
                child: Text(currency.code),
              ),
          ],
          onChanged: (value) => _currency = value == '' ? null : value,
        ),
        const SizedBox(height: 35),
        FilledButton(onPressed: _apply, child: const Text('Aplicar filtros')),
        const SizedBox(height: 12),
        OutlinedButton(
          onPressed: () =>
              Navigator.pop(context, const ExpenseSearchCriteria()),
          child: const Text('Limpiar filtros'),
        ),
      ],
    ),
  );

  void _apply() {
    final recipient = _recipient.text.trim();
    Navigator.pop(
      context,
      ExpenseSearchCriteria(
        recipient: recipient.isEmpty ? null : recipient,
        currency: _currency,
        category: widget.criteria.category,
        from: widget.criteria.from,
        to: widget.criteria.to,
      ),
    );
  }
}
