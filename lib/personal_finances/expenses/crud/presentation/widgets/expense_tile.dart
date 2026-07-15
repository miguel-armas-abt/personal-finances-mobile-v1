import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    required this.expense,
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  final Expense expense;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final currencyFormat = NumberFormat.currency(
      locale: 'es_PE',
      symbol: '${expense.money.currency.symbol} ',
    );
    final colorScheme = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 10, 8, 10),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.recipient?.isNotEmpty == true
                        ? expense.recipient!
                        : expense.source,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.titleMedium,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    [
                      expense.formattedDate,
                      if (expense.category?.isNotEmpty == true)
                        expense.category!,
                      expense.source,
                    ].join(' - '),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: textTheme.bodyMedium,
                  ),
                  if (expense.comments?.isNotEmpty == true)
                    Text(
                      expense.comments!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: textTheme.bodySmall,
                    ),
                ],
              ),
            ),
            const SizedBox(width: 12),
            SizedBox(
              width: 84,
              child: Text(
                currencyFormat.format(expense.money.amount / 100),
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: textTheme.titleMedium?.copyWith(
                  color: colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            IconButton(
              tooltip: 'Editar',
              onPressed: onEdit,
              icon: const Icon(Icons.edit_outlined),
            ),
            IconButton(
              tooltip: 'Eliminar',
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ),
    );
  }
}
