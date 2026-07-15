enum CurrencyCode {
  pen('PEN', 'S/'),
  usd('USD', r'$');

  const CurrencyCode(this.code, this.symbol);

  factory CurrencyCode.fromCode(String code) {
    return CurrencyCode.values.firstWhere(
      (value) => value.code == code,
      orElse: () => throw const FormatException('Unsupported currency'),
    );
  }

  final String code;
  final String symbol;
}

class Money {
  const Money({required this.amount, required this.currency});

  final int amount;
  final CurrencyCode currency;
}
