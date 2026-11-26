import 'package:flutter/material.dart';
import 'package:personal_finances_mobile_v1/commons/theme/app_theme.dart';

class DesignPage extends StatelessWidget {
  const DesignPage({required this.title, required this.child, super.key});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: Text(title),
      leadingWidth: 56,
      leading: Padding(
        padding: const EdgeInsets.only(left: 8),
        child: IconButton(
          tooltip: MaterialLocalizations.of(context).backButtonTooltip,
          onPressed: () => Navigator.maybePop(context),
          style: IconButton.styleFrom(
            backgroundColor: Theme.of(context).colorScheme.surface,
          ),
          icon: const Icon(Icons.chevron_left),
        ),
      ),
    ),
    body: SafeArea(
      child: Align(
        alignment: Alignment.topCenter,
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: child,
        ),
      ),
    ),
  );
}

class DesignNotice extends StatelessWidget {
  const DesignNotice({
    required this.title,
    required this.message,
    this.color = AppTheme.sky,
    this.ink = AppTheme.blue,
    super.key,
  });

  final String title;
  final String message;
  final Color color;
  final Color ink;

  @override
  Widget build(BuildContext context) => DecoratedBox(
    decoration: BoxDecoration(color: color, borderRadius: AppTheme.cardRadius),
    child: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            title,
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(color: ink),
          ),
          const SizedBox(height: 6),
          Text(
            message,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(color: ink),
          ),
        ],
      ),
    ),
  );
}

class DesignBadge extends StatelessWidget {
  const DesignBadge({required this.label, this.index = 0, super.key});

  final String label;
  final int index;

  @override
  Widget build(BuildContext context) {
    const accents = [
      (AppTheme.mint, AppTheme.green),
      (AppTheme.lavender, AppTheme.primary),
      (AppTheme.sky, AppTheme.blue),
      (AppTheme.sand, AppTheme.amber),
      (AppTheme.pink, AppTheme.red),
    ];
    final (surface, ink) = accents[index % accents.length];
    return ExcludeSemantics(
      child: Container(
        width: 42,
        height: 42,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: ink,
            fontSize: 12,
            fontWeight: FontWeight.w800,
          ),
        ),
      ),
    );
  }
}

Future<bool> confirmDesignAction(
  BuildContext context, {
  required String title,
  required String message,
  required String action,
}) async =>
    await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(title),
        content: Text(message),
        actions: [
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.red,
              foregroundColor: Colors.white,
            ),
            onPressed: () => Navigator.pop(context, true),
            child: Text(action),
          ),
          FilledButton.tonal(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancelar'),
          ),
        ],
      ),
    ) ??
    false;
