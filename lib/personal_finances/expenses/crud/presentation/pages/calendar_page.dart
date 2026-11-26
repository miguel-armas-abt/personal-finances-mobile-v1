import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/app/router/app_router.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense_search_criteria.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/period_expenses_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/pages/expense_detail_page.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/widgets/expense_tile.dart';

class CalendarPage extends ConsumerStatefulWidget {
  const CalendarPage({super.key});

  @override
  ConsumerState<CalendarPage> createState() => _CalendarPageState();
}

class _CalendarPageState extends ConsumerState<CalendarPage> {
  late DateTime _month = _monthStart(DateTime.now());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadMonth(_month));
  }

  @override
  Widget build(BuildContext context) {
    ref.listen(expenseDataRevisionProvider, (_, _) => _loadMonth(_month));
    final state = ref.watch(calendarExpensesControllerProvider);
    final now = DateTime.now();
    final today = DateUtils.dateOnly(now);
    final expenses =
        state.expenses
            .where(
              (expense) =>
                  expense.date.year == _month.year &&
                  expense.date.month == _month.month &&
                  !DateUtils.dateOnly(expense.date).isAfter(today),
            )
            .toList()
          ..sort((a, b) => b.date.compareTo(a.date));
    final byDay = <DateTime, List<Expense>>{};
    for (final expense in expenses) {
      byDay
          .putIfAbsent(DateUtils.dateOnly(expense.date), () => [])
          .add(expense);
    }

    return Scaffold(
      floatingActionButton: FloatingActionButton(
        tooltip: 'Nuevo gasto',
        onPressed: () => context.push(AppRoutes.newExpense),
        child: const Icon(Icons.add),
      ),
      body: RefreshIndicator(
        onRefresh: () => _loadMonth(_month),
        child: ListView(
          padding: const EdgeInsets.fromLTRB(24, 18, 24, 100),
          children: [
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: _chooseMonth,
                    icon: const Icon(Icons.calendar_month_outlined),
                    label: Text(
                      DateFormat.yMMMM('es_PE').format(_month),
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                    style: TextButton.styleFrom(
                      foregroundColor: Theme.of(context).colorScheme.onSurface,
                      alignment: Alignment.centerLeft,
                    ),
                  ),
                ),
                FilledButton.tonalIcon(
                  onPressed: () =>
                      context.push(AppRoutes.analysis, extra: _month),
                  icon: const Icon(Icons.pie_chart_outline),
                  label: const Text('Gastos'),
                ),
              ],
            ),
            const SizedBox(height: 14),
            _MonthArt(month: _month.month),
            const SizedBox(height: 24),
            if (state.isLoading && expenses.isEmpty)
              const Center(
                child: Padding(
                  padding: EdgeInsets.all(36),
                  child: CircularProgressIndicator(),
                ),
              )
            else if (state.loadError != null && expenses.isEmpty)
              _CalendarMessage(
                icon: Icons.cloud_off_outlined,
                title: 'No se pudieron cargar los gastos',
                detail: state.loadError!,
                action: TextButton.icon(
                  onPressed: () => _loadMonth(_month),
                  icon: const Icon(Icons.refresh),
                  label: const Text('Reintentar'),
                ),
              )
            else if (byDay.isEmpty)
              _CalendarMessage(
                icon: Icons.receipt_long_outlined,
                title: 'Sin gastos este mes',
                detail: 'Aquí aparecerán únicamente los días con gastos.',
              )
            else
              for (final entry in byDay.entries) ...[
                Padding(
                  padding: const EdgeInsets.only(bottom: 8, top: 14),
                  child: Text(
                    DateFormat('d MMMM · EEEE', 'es_PE').format(entry.key),
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      color: AppTheme.nightMuted,
                    ),
                  ),
                ),
                for (final expense in entry.value)
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: ExpenseTile(
                      expense: expense,
                      onOpen: () => Navigator.of(context).push(
                        MaterialPageRoute<void>(
                          builder: (_) => ExpenseDetailPage(expense: expense),
                        ),
                      ),
                    ),
                  ),
              ],
          ],
        ),
      ),
    );
  }

  Future<void> _chooseMonth() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _month.isAfter(DateUtils.dateOnly(DateTime.now()))
          ? DateTime.now()
          : _month,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
      helpText: 'Elige un mes',
    );
    if (picked == null || !mounted) return;
    final month = _monthStart(picked);
    setState(() => _month = month);
    await _loadMonth(month);
  }

  Future<void> _loadMonth(DateTime month) async {
    if (!mounted) return;
    final now = DateTime.now();
    final first = _monthStart(month);
    final monthEnd = DateTime(first.year, first.month + 1, 0, 23, 59, 59, 999);
    final to = monthEnd.isAfter(now) ? now : monthEnd;
    await ref
        .read(calendarExpensesControllerProvider.notifier)
        .load(ExpenseSearchCriteria(from: first, to: to));
  }
}

DateTime _monthStart(DateTime date) => DateTime(date.year, date.month);

class _MonthArt extends StatelessWidget {
  const _MonthArt({required this.month});

  final int month;

  @override
  Widget build(BuildContext context) {
    final summer = month == 12 || month <= 2;
    final autumn = month >= 3 && month <= 5;
    final winter = month >= 6 && month <= 8;
    final palette = month == 6
        ? (
            const Color(0xFF4E9774),
            const Color(0xFF9DCE9B),
            const Color(0xFFFFD98A),
          )
        : month == 7
        ? (
            const Color(0xFFD87570),
            const Color(0xFFF3A28C),
            const Color(0xFFFFD28D),
          )
        : summer
        ? (
            const Color(0xFF397C9B),
            const Color(0xFF8BC7D2),
            const Color(0xFFFFD87A),
          )
        : autumn
        ? (
            const Color(0xFFB96356),
            const Color(0xFFE7A16C),
            const Color(0xFFFFDA95),
          )
        : winter
        ? (
            const Color(0xFF4B8791),
            const Color(0xFF9AC7B1),
            const Color(0xFFFFD28A),
          )
        : (
            const Color(0xFF5B8E61),
            const Color(0xFFA7C983),
            const Color(0xFFFFD166),
          );
    final monthName = DateFormat.MMMM(
      'es_PE',
    ).format(DateTime(2026, month)).toUpperCase();
    return Container(
      height: 136,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [palette.$1, palette.$2],
        ),
      ),
      clipBehavior: Clip.antiAlias,
      child: Stack(
        children: [
          Positioned.fill(
            child: CustomPaint(
              painter: _LandscapePainter(palette.$1, palette.$2, month),
            ),
          ),
          Positioned(
            left: 18,
            top: 16,
            child: Text(
              monthName,
              style: const TextStyle(
                color: Color(0xFFE6E4FF),
                letterSpacing: 1.3,
                fontSize: 11,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _LandscapePainter extends CustomPainter {
  const _LandscapePainter(this.back, this.front, this.month);

  final Color back;
  final Color front;
  final int month;

  @override
  void paint(Canvas canvas, Size size) {
    final backPaint = Paint()..color = back.withValues(alpha: .76);
    final frontPaint = Paint()..color = front.withValues(alpha: .7);
    final rise = .22 + (month % 3) * .04;
    final backPath = Path()
      ..moveTo(0, size.height * .72)
      ..quadraticBezierTo(
        size.width * .35,
        size.height * rise,
        size.width * .6,
        size.height * .68,
      )
      ..quadraticBezierTo(
        size.width * .85,
        size.height * .93,
        size.width,
        size.height * .48,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    final frontPath = Path()
      ..moveTo(0, size.height * .86)
      ..quadraticBezierTo(
        size.width * .25,
        size.height * .5,
        size.width * .48,
        size.height * .82,
      )
      ..quadraticBezierTo(
        size.width * .76,
        size.height * 1.06,
        size.width,
        size.height * .72,
      )
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();
    canvas.drawPath(backPath, backPaint);
    canvas.drawPath(frontPath, frontPaint);
    final sunPaint = Paint()
      ..color = Color.lerp(back, front, .62)!.withValues(alpha: .94);
    canvas.drawCircle(
      Offset(size.width * .79, size.height * .29),
      size.height * .12,
      sunPaint,
    );
    final highlight = Paint()
      ..color = const Color(0xFFFFF1C1).withValues(alpha: .5);
    final ridge = Path()
      ..moveTo(size.width * .04, size.height * .76)
      ..quadraticBezierTo(
        size.width * .24,
        size.height * .4,
        size.width * .43,
        size.height * .76,
      )
      ..lineTo(size.width * .36, size.height * .76)
      ..quadraticBezierTo(
        size.width * .23,
        size.height * .55,
        size.width * .1,
        size.height * .76,
      )
      ..close();
    canvas.drawPath(ridge, highlight);
  }

  @override
  bool shouldRepaint(covariant _LandscapePainter oldDelegate) =>
      oldDelegate.back != back ||
      oldDelegate.front != front ||
      oldDelegate.month != month;
}

class _CalendarMessage extends StatelessWidget {
  const _CalendarMessage({
    required this.icon,
    required this.title,
    required this.detail,
    this.action,
  });

  final IconData icon;
  final String title;
  final String detail;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Card(
    child: Padding(
      padding: const EdgeInsets.all(24),
      child: Column(
        children: [
          Icon(icon, color: AppTheme.nightMuted, size: 28),
          const SizedBox(height: 12),
          Text(title, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 6),
          Text(detail, textAlign: TextAlign.center),
          ?action,
        ],
      ),
    ),
  );
}
