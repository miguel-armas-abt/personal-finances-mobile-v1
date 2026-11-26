import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/period_expenses_controller.dart';

class AnalysisPage extends ConsumerStatefulWidget {
  const AnalysisPage({required this.initialMonth, super.key});

  final DateTime initialMonth;

  @override
  ConsumerState<AnalysisPage> createState() => _AnalysisPageState();
}

class _AnalysisPageState extends ConsumerState<AnalysisPage> {
  late DateTimeRange _range = _monthRange(widget.initialMonth);
  String? _currency;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadRange(_range));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(expenseDataRevisionProvider, (_, _) => _loadRange(_range));
    final state = ref.watch(analysisExpensesControllerProvider);
    final today = DateUtils.dateOnly(DateTime.now());
    final to = _range.end.isAfter(today) ? today : _range.end;
    final currencies =
        state.expenses
            .map((expense) => expense.money.currency.code)
            .toSet()
            .toList()
          ..sort();
    final selectedCurrency =
        _currency ?? (currencies.isEmpty ? null : currencies.first);
    final expenses = state.expenses.where((expense) {
      final day = DateUtils.dateOnly(expense.date);
      return !day.isBefore(DateUtils.dateOnly(_range.start)) &&
          !day.isAfter(to) &&
          (selectedCurrency == null ||
              expense.money.currency.code == selectedCurrency);
    }).toList();
    final totals = <String, int>{};
    for (final expense in expenses) {
      final category = expense.category?.trim();
      final key = category == null || category.isEmpty
          ? 'Sin categoría'
          : category;
      totals.update(
        key,
        (amount) => amount + expense.money.amount,
        ifAbsent: () => expense.money.amount,
      );
    }
    final total = totals.values.fold<int>(0, (sum, amount) => sum + amount);
    final categories = totals.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final colors = [
      AppTheme.nightAccent,
      AppTheme.categoryMint,
      AppTheme.nightBlue,
      AppTheme.categoryGold,
      AppTheme.expenseAccent,
    ];

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 12, 24, 32),
          children: [
            Row(
              children: [
                IconButton(
                  tooltip: 'Volver al calendario',
                  onPressed: () => Navigator.maybePop(context),
                  icon: const Icon(Icons.arrow_back),
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Análisis',
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      Text(
                        _rangeLabel(_range),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: 'Filtrar fechas',
                  onPressed: () => _chooseRange(today),
                  icon: const Icon(Icons.calendar_month_outlined),
                ),
              ],
            ),
            const SizedBox(height: 26),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'TOTAL DE GASTOS',
                        style: Theme.of(context).textTheme.labelSmall?.copyWith(
                          color: AppTheme.nightMuted,
                          letterSpacing: 1.2,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        _money(total, selectedCurrency ?? 'PEN'),
                        style: Theme.of(context).textTheme.headlineSmall,
                      ),
                    ],
                  ),
                ),
                if (currencies.length > 1)
                  DropdownButton<String?>(
                    value: selectedCurrency,
                    hint: const Text('Moneda'),
                    items: [
                      for (final code in currencies)
                        DropdownMenuItem(value: code, child: Text(code)),
                    ],
                    onChanged: (value) => setState(() => _currency = value),
                  ),
              ],
            ),
            const SizedBox(height: 22),
            if (state.isLoading && state.expenses.isEmpty)
              const Padding(
                padding: EdgeInsets.all(36),
                child: Center(child: CircularProgressIndicator()),
              )
            else if (state.loadError != null && state.expenses.isEmpty)
              _AnalysisMessage(
                title: 'No se pudo cargar el análisis',
                detail: state.loadError!,
                action: TextButton.icon(
                  onPressed: () => _loadRange(_range),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              )
            else if (total == 0)
              const _AnalysisMessage(
                title: 'Sin gastos en este periodo',
                detail: 'Prueba con otro rango de fechas.',
              )
            else ...[
              SizedBox(
                height: 248,
                child: CustomPaint(
                  painter: _DonutPainter(
                    values: categories
                        .map((entry) => entry.value.toDouble())
                        .toList(),
                    colors: colors,
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        const Text(
                          'GASTOS',
                          style: TextStyle(
                            color: AppTheme.nightMuted,
                            fontSize: 11,
                            letterSpacing: 1.2,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _money(total, selectedCurrency ?? 'PEN'),
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              for (final (index, entry) in categories.indexed)
                Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(
                      backgroundColor: colors[index % colors.length].withValues(
                        alpha: .18,
                      ),
                      child: Icon(
                        Icons.category_outlined,
                        color: colors[index % colors.length],
                        size: 19,
                      ),
                    ),
                    title: Text(entry.key),
                    subtitle: Text('${(entry.value * 100 / total).round()}%'),
                    trailing: Text(
                      _money(entry.value, selectedCurrency ?? 'PEN'),
                    ),
                  ),
                ),
            ],
          ],
        ),
      ),
    );
  }

  Future<void> _chooseRange(DateTime today) async {
    final initial = DateTimeRange(
      start: _range.start.isAfter(today) ? today : _range.start,
      end: _range.end.isAfter(today) ? today : _range.end,
    );
    final selected = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: today,
      initialDateRange: initial,
      helpText: 'Filtrar gastos por fechas',
    );
    if (selected == null || !mounted) return;
    setState(() => _range = selected);
    await _loadRange(selected);
  }

  Future<void> _loadRange(DateTimeRange range) async {
    if (!mounted) return;
    final today = DateTime.now();
    final endOfDay = DateTime(
      range.end.year,
      range.end.month,
      range.end.day,
      23,
      59,
      59,
      999,
    );
    final to = endOfDay.isAfter(today) ? today : endOfDay;
    await ref
        .read(analysisExpensesControllerProvider.notifier)
        .load(
          ExpenseSearchCriteria(from: DateUtils.dateOnly(range.start), to: to),
        );
  }
}

DateTimeRange _monthRange(DateTime month) {
  final now = DateTime.now();
  final start = DateTime(month.year, month.month);
  final last = DateTime(month.year, month.month + 1, 0);
  return DateTimeRange(start: start, end: last.isAfter(now) ? now : last);
}

String _rangeLabel(DateTimeRange range) =>
    '${DateFormat('d MMM yyyy', 'es_PE').format(range.start)} – ${DateFormat('d MMM yyyy', 'es_PE').format(range.end)}';

String _money(int minorUnits, String code) => NumberFormat.currency(
  locale: 'en_US',
  name: code,
  symbol: code == 'PEN'
      ? 'S/'
      : code == 'USD'
      ? r'$'
      : '$code ',
).format(minorUnits / 100);

class _DonutPainter extends CustomPainter {
  const _DonutPainter({required this.values, required this.colors});

  final List<double> values;
  final List<Color> colors;

  @override
  void paint(Canvas canvas, Size size) {
    final total = values.fold<double>(0, (sum, value) => sum + value);
    if (total == 0) return;
    final rect = Rect.fromCenter(
      center: size.center(Offset.zero),
      width: 174,
      height: 174,
    );
    var start = -math.pi / 2;
    for (final (index, value) in values.indexed) {
      final sweep = value / total * math.pi * 2;
      final paint = Paint()
        ..color = colors[index % colors.length]
        ..style = PaintingStyle.stroke
        ..strokeWidth = 27
        ..strokeCap = StrokeCap.butt;
      canvas.drawArc(rect, start, sweep, false, paint);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(covariant _DonutPainter oldDelegate) =>
      oldDelegate.values != values || oldDelegate.colors != colors;
}

class _AnalysisMessage extends StatelessWidget {
  const _AnalysisMessage({
    required this.title,
    required this.detail,
    this.action,
  });

  final String title;
  final String detail;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          const Icon(Icons.pie_chart_outline, color: AppTheme.nightMuted),
          const SizedBox(height: 10),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(detail, textAlign: TextAlign.center),
          ?action,
        ],
      ),
    ),
  );
}
