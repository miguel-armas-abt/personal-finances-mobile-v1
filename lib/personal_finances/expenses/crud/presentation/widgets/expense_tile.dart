import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/crud/model/expense.dart';

class ExpenseTile extends StatelessWidget {
  const ExpenseTile({
    required this.expense,
    this.index = 0,
    required this.onOpen,
    super.key,
  });

  final Expense expense;
  final int index;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final text = Theme.of(context).textTheme;
    final label = expenseTitle(expense);
    final source = expense.source.trim().toUpperCase();
    final sourceStyle = switch (source) {
      'BBVA_DEBIT_CARD' => (Icons.credit_card, const Color(0xFF1973E8), 'BBVA'),
      'BBVA_PLIN' ||
      'BBVA_PLIN_MERCHANT_QR' ||
      'IBK_PLIN' => (Icons.qr_code_2, const Color(0xFF7D3C98), 'Plin'),
      'BBVA_SERVICE_PAYMENT' => (
        Icons.receipt_long,
        const Color(0xFF1973E8),
        'BBVA',
      ),
      'BCP_DEBIT_CARD' => (Icons.credit_card, const Color(0xFFF5C400), 'BCP'),
      _ when source.contains('MANUAL') || expense.gmailMessageId == null => (
        Icons.edit_note,
        const Color(0xFFC59AFF),
        'Registro manual',
      ),
      _ when source.contains('GMAIL') || expense.gmailMessageId != null => (
        Icons.mail_outline,
        const Color(0xFFA6A4BA),
        'Correo',
      ),
      _ => (
        Icons.account_balance,
        const Color(0xFFA6A4BA),
        source.isEmpty ? 'Origen desconocido' : expense.source,
      ),
    };
    final date = DateFormat('d MMM', 'es_PE').format(expense.date);
    return Card(
      child: InkWell(
        onTap: onOpen,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 11),
          child: Row(
            children: [
              Semantics(
                label: sourceStyle.$3,
                child: ExcludeSemantics(
                  child: Container(
                    width: 42,
                    height: 42,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: sourceStyle.$2.withValues(alpha: .16),
                      borderRadius: BorderRadius.circular(13),
                    ),
                    child: Icon(
                      sourceStyle.$1,
                      color: sourceStyle.$2,
                      size: 21,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 13),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      label,
                      style: text.titleMedium,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      [
                        if (expense.category case final category?
                            when category.isNotEmpty)
                          category,
                        if (!expense.money.currency.isKnown) 'Moneda pendiente',
                        date,
                      ].join(' · '),
                      style: text.bodySmall,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '−${expenseAmount(expense)}',
                textAlign: TextAlign.end,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: text.titleMedium?.copyWith(fontSize: 13),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

String expenseTitle(Expense expense) {
  final comment = expense.comments?.trim();
  if (comment != null && comment.isNotEmpty) return comment;

  final recipient = expense.recipient?.trim();
  return recipient == null || recipient.isEmpty ? expense.source : recipient;
}

String expenseAmount(Expense expense) => NumberFormat.currency(
  locale: 'en_US',
  symbol: '${expense.money.currency.symbol} ',
).format(expense.money.amount / 100);
