import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/commons/errors/app_failure.dart';
import 'package:personal_finances_mobile_v1/commons/widgets/design_widgets.dart';
import 'package:personal_finances_mobile_v1/app/dependencies.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_state.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/presentation/controllers/categories_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/presentation/pages/categories_page.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/controllers/period_expenses_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/presentation/pages/calendar_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage>
    with WidgetsBindingObserver {
  int _selected = 0;
  bool _signingOut = false;
  bool _connectingGmail = false;
  DateTime? _lastAutoSyncAt;
  Future<void>? _autoSyncFuture;

  static const _labels = ['Meta', 'Calendario', 'M\u00e1s'];
  static const _icons = [
    Icons.flag_outlined,
    Icons.calendar_month_outlined,
    Icons.more_horiz,
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) => _scheduleAutoSync());
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) _scheduleAutoSync();
  }

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final wide = MediaQuery.sizeOf(context).width >= 720;

    return Scaffold(
      appBar: AppBar(title: Text(_labels[_selected])),
      body: SafeArea(
        top: false,
        child: Row(
          children: [
            if (wide)
              NavigationRail(
                selectedIndex: _selected,
                onDestinationSelected: _select,
                labelType: NavigationRailLabelType.selected,
                destinations: [
                  for (final (index, label) in _labels.indexed)
                    NavigationRailDestination(
                      icon: Icon(_icons[index]),
                      label: Text(label),
                    ),
                ],
              ),
            Expanded(
              child: Center(
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 680),
                  child: IndexedStack(
                    index: _selected,
                    sizing: StackFit.expand,
                    children: [
                      const CategoriesPage(),
                      const CalendarPage(),
                      _more(context),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: wide
          ? null
          : Material(
              color: colors.surface,
              child: SafeArea(
                minimum: const EdgeInsets.fromLTRB(24, 10, 24, 12),
                child: Row(
                  children: [
                    for (final (index, label) in _labels.indexed)
                      Expanded(
                        child: Semantics(
                          selected: _selected == index,
                          button: true,
                          label: label,
                          child: IconButton(
                            tooltip: label,
                            onPressed: () => _select(index),
                            style: IconButton.styleFrom(
                              minimumSize: const Size(52, 52),
                              backgroundColor: _selected == index
                                  ? colors.primaryContainer
                                  : Colors.transparent,
                              foregroundColor: _selected == index
                                  ? colors.onPrimaryContainer
                                  : colors.onSurfaceVariant,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(28),
                              ),
                            ),
                            icon: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Icon(_icons[index]),
                                if (_selected == index) ...[
                                  const SizedBox(width: 7),
                                  Text(
                                    label,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ],
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ),
    );
  }

  void _select(int index) => setState(() => _selected = index);

  void _scheduleAutoSync() {
    if (!mounted ||
        ref.read(authControllerProvider).status != AuthStatus.authenticated) {
      return;
    }
    final now = DateTime.now();
    if (_autoSyncFuture != null) return;
    if (_lastAutoSyncAt != null &&
        now.difference(_lastAutoSyncAt!) < const Duration(seconds: 4)) {
      return;
    }
    _lastAutoSyncAt = now;
    final future = _syncIfAuthorized();
    _autoSyncFuture = future;
    unawaited(
      future.whenComplete(() {
        if (identical(_autoSyncFuture, future)) _autoSyncFuture = null;
      }),
    );
  }

  Future<void> _syncIfAuthorized() async {
    try {
      final ids = await ref
          .read(expenseSyncServiceProvider)
          .syncIfGmailAuthorized(
            isActive: () =>
                mounted &&
                ref.read(authControllerProvider).status ==
                    AuthStatus.authenticated,
          );
      if (!mounted || ids == null || ids.isEmpty) return;
      ref.read(expenseDataRevisionProvider.notifier).increment();
      ref.invalidate(categoriesControllerProvider);
    } on AppFailure catch (failure) {
      if (mounted) _showMessage(failure.message);
    } on Exception {
      if (mounted) {
        _showMessage(
          'No se pudo completar la sincronizaci\u00f3n autom\u00e1tica de Gmail.',
        );
      }
    }
  }

  Widget _more(BuildContext context) {
    final session = ref.watch(authControllerProvider).session;
    return ListView(
      padding: const EdgeInsets.fromLTRB(24, 18, 24, 24),
      children: [
        const Text('Cuenta y sincronizaci\u00f3n'),
        const SizedBox(height: 14),
        Card(
          child: ListTile(
            leading: const Icon(Icons.mail_outline),
            title: const Text('Conectar Gmail'),
            subtitle: const Text(
              'Sincronizaci\u00f3n autom\u00e1tica al abrir la app. Gestiona el permiso de Gmail aqu\u00ed.',
            ),
            trailing: const Icon(Icons.chevron_right),
            onTap: _connectingGmail ? null : _connectGmail,
          ),
        ),
        const SizedBox(height: 14),
        Card(
          child: ListTile(
            leading: const DesignBadge(label: 'PF', index: 1),
            title: const Text('Sesi\u00f3n de Google'),
            subtitle: Text(session?.user.email ?? 'Cuenta conectada'),
          ),
        ),
        const SizedBox(height: 30),
        OutlinedButton(
          onPressed: _signingOut ? null : _signOut,
          style: OutlinedButton.styleFrom(
            foregroundColor: Theme.of(context).colorScheme.error,
          ),
          child: const Text('Cerrar sesi\u00f3n'),
        ),
      ],
    );
  }

  Future<void> _connectGmail() async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Conectar Gmail'),
        content: const Text(
          'Google solicitar\u00e1 permiso para leer los correos compatibles. La app no sincroniza si el permiso no est\u00e1 disponible.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Ahora no'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Continuar'),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) return;
    setState(() => _connectingGmail = true);
    try {
      final ids = await ref
          .read(expenseSyncServiceProvider)
          .syncFromGmail(
            isActive: () =>
                mounted &&
                ref.read(authControllerProvider).status ==
                    AuthStatus.authenticated,
          );
      if (!mounted) return;
      if (ids.isNotEmpty) {
        ref.read(expenseDataRevisionProvider.notifier).increment();
        ref.invalidate(categoriesControllerProvider);
      }
      _showMessage(
        ids.isEmpty
            ? 'No se encontraron gastos nuevos.'
            : 'Se sincronizaron ${ids.length} gastos.',
      );
    } on AppFailure catch (failure) {
      if (mounted) _showMessage(failure.message);
    } on Exception {
      if (mounted) _showMessage('No se pudo sincronizar con Gmail.');
    } finally {
      if (mounted) setState(() => _connectingGmail = false);
    }
  }

  void _showMessage(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  Future<void> _signOut() async {
    final confirmed = await confirmDesignAction(
      context,
      title: 'Cerrar sesi\u00f3n',
      message: 'Podr\u00e1s volver con tu cuenta de Google.',
      action: 'Cerrar sesi\u00f3n',
    );
    if (!confirmed || !mounted) return;
    setState(() => _signingOut = true);
    try {
      await ref.read(authControllerProvider.notifier).signOut();
    } finally {
      if (mounted) setState(() => _signingOut = false);
    }
  }
}
