class ExpenseSearchCriteria {
  const ExpenseSearchCriteria({
    this.recipient,
    this.category,
    this.currency,
    this.from,
    this.to,
  });

  final String? recipient;
  final String? category;
  final String? currency;
  final DateTime? from;
  final DateTime? to;

  bool get hasFilters {
    return recipient != null ||
        category != null ||
        currency != null ||
        from != null ||
        to != null;
  }
}
