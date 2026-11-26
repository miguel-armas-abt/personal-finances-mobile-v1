import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_controller.dart';
import 'package:personal_finances_mobile_v1/personal_finances/auth/session/presentation/controllers/auth_state.dart';

class LoginPage extends ConsumerWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(authControllerProvider);
    final busy = state.isSubmitting || state.status == AuthStatus.checking;
    final text = Theme.of(context).textTheme;

    return Scaffold(
      body: SafeArea(
        child: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.fromLTRB(24, 24, 24, 32),
              children: [
                Text('Personal Finances', style: text.headlineSmall),
                const SizedBox(height: 32),
                const _LoginCover(),
                const SizedBox(height: 54),
                FilledButton.icon(
                  onPressed: busy
                      ? null
                      : () => ref
                            .read(authControllerProvider.notifier)
                            .signInWithGoogle(),
                  icon: busy
                      ? const SizedBox.square(
                          dimension: 16,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : const Text(
                          'G',
                          style: TextStyle(fontWeight: FontWeight.w800),
                        ),
                  label: const Text('Continuar con Google'),
                ),
                const SizedBox(height: 20),
                const Text('La sincronización de Gmail se activa aparte.'),
                if (state.message case final message?) ...[
                  const SizedBox(height: 12),
                  Semantics(
                    liveRegion: true,
                    child: Text(
                      message,
                      style: TextStyle(
                        color: Theme.of(context).colorScheme.error,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _LoginCover extends StatelessWidget {
  const _LoginCover();

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.fromLTRB(23, 30, 23, 36),
    decoration: BoxDecoration(
      color: AppTheme.navy,
      borderRadius: BorderRadius.circular(28),
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 50,
          height: 50,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppTheme.lavender,
            borderRadius: BorderRadius.circular(16),
          ),
          child: const Text(
            'PF',
            style: TextStyle(
              color: AppTheme.primary,
              fontSize: 17,
              fontWeight: FontWeight.w800,
            ),
          ),
        ),
        const SizedBox(height: 29),
        Text(
          'Tus gastos,\nen orden.',
          style: Theme.of(
            context,
          ).textTheme.headlineLarge?.copyWith(color: Colors.white),
        ),
        const SizedBox(height: 31),
        const Text(
          'Registra y organiza tus gastos\nen un solo lugar.',
          style: TextStyle(color: Colors.white, fontSize: 15, height: 1.5),
        ),
        Align(
          alignment: Alignment.centerRight,
          heightFactor: .65,
          child: ExcludeSemantics(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                for (final (index, height) in [
                  32.0,
                  49.0,
                  23.0,
                  55.0,
                  37.0,
                  66.0,
                ].indexed)
                  Container(
                    width: 10,
                    height: height,
                    margin: const EdgeInsets.only(left: 7),
                    decoration: BoxDecoration(
                      color: [
                        AppTheme.sky,
                        AppTheme.mint,
                        AppTheme.lavender,
                      ][index % 3],
                      borderRadius: BorderRadius.circular(5),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ],
    ),
  );
}
