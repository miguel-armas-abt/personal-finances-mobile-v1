import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';

enum RecipientPatternCode {
  sameAs('SAME_AS'),
  startWith('START_WITH'),
  contains('CONTAINS'),
  endsWith('ENDS_WITH');

  const RecipientPatternCode(this.code);

  factory RecipientPatternCode.fromCode(String code) {
    return RecipientPatternCode.values.firstWhere(
      (value) => value.code == code,
      orElse: () =>
          throw const FormatException('Unsupported recipient pattern'),
    );
  }

  final String code;
}

class RecipientPattern {
  const RecipientPattern({required this.code, required this.value});

  final RecipientPatternCode code;
  final String value;
}

class CategoryLimit {
  const CategoryLimit({
    required this.amount,
    required this.isExceeded,
    required this.balance,
  });

  final int amount;
  final bool isExceeded;
  final int balance;
}

class ExpenseCategory {
  const ExpenseCategory({
    required this.name,
    required this.limit,
    required this.recipientPatterns,
  });

  final String name;
  final CategoryLimit limit;
  final List<RecipientPattern> recipientPatterns;
}

class ExpenseCategorySettings {
  const ExpenseCategorySettings({
    required this.currency,
    required this.categories,
  });

  final CurrencyCode currency;
  final List<ExpenseCategory> categories;
}
