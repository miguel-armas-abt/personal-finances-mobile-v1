import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

class ExpenseWriteRequest {
  const ExpenseWriteRequest({
    required this.date,
    required this.currency,
    required this.amount,
    required this.source,
    required this.category,
    required this.comments,
    this.userEmail,
    this.gmailMessageId,
    this.recipient,
  });

  final String? userEmail;
  final String? gmailMessageId;
  final DateTime date;
  final CurrencyCode currency;
  final int amount;
  final String source;
  final String category;
  final String comments;
  final String? recipient;
}
