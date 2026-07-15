import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:personal_finances_mobile_v1/app/router/router_refresh_notifier.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_state.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/pages/login_page.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/pages/expense_form_page.dart';
import 'package:personal_finances_mobile_v1/app/shell/home_page.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final refreshNotifier = RouterRefreshNotifier(ref);
  ref.onDispose(refreshNotifier.dispose);

  final router = GoRouter(
    initialLocation: AppRoutes.home,
    refreshListenable: refreshNotifier,
    redirect: (context, state) {
      final authState = ref.read(authControllerProvider);
      final isLogin = state.matchedLocation == AppRoutes.login;

      return switch (authState.status) {
        AuthStatus.checking => isLogin ? null : AppRoutes.login,
        AuthStatus.unauthenticated => isLogin ? null : AppRoutes.login,
        AuthStatus.authenticated => isLogin ? AppRoutes.home : null,
      };
    },
    routes: [
      GoRoute(
        path: AppRoutes.login,
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: AppRoutes.home,
        builder: (context, state) => const HomePage(),
        routes: [
          GoRoute(
            path: AppRoutes.newExpenseSegment,
            builder: (context, state) => const ExpenseFormPage(),
          ),
          GoRoute(
            path: AppRoutes.editExpenseSegment,
            redirect: (context, state) =>
                state.extra is Expense ? null : AppRoutes.home,
            builder: (context, state) {
              final expense = state.extra is Expense
                  ? state.extra! as Expense
                  : null;
              return ExpenseFormPage(expense: expense);
            },
          ),
        ],
      ),
    ],
  );
  ref.onDispose(router.dispose);
  return router;
});

class AppRoutes {
  const AppRoutes._();

  static const login = '/login';
  static const home = '/';
  static const newExpenseSegment = 'expenses/new';
  static const editExpenseSegment = 'expenses/edit';
  static const newExpense = '/expenses/new';
  static const editExpense = '/expenses/edit';
}
