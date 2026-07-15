import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

class Expense {
  const Expense({
    required this.id,
    required this.date,
    required this.formattedDate,
    required this.money,
    required this.source,
    this.gmailMessageId,
    this.category,
    this.comments,
    this.recipient,
  });

  final String id;
  final String? gmailMessageId;
  final DateTime date;
  final String formattedDate;
  final Money money;
  final String source;
  final String? category;
  final String? comments;
  final String? recipient;
}
