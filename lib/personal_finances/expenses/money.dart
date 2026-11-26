enum CurrencyCode {
  pen('PEN', 'S/'),
  usd('USD', r'$'),
  unknown('UNKNOWN', 'UNKNOWN');

  const CurrencyCode(this.code, this.symbol);

  factory CurrencyCode.fromCode(String? code) => CurrencyCode.values.firstWhere(
    (value) => value.code == code?.trim().toUpperCase(),
    orElse: () => CurrencyCode.unknown,
  );

  bool get isKnown => this != CurrencyCode.unknown;

  final String code;
  final String symbol;
}

class Money {
  const Money({required this.amount, required this.currency});

  final int amount;
  final CurrencyCode currency;
}
