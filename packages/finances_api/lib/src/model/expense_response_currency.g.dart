// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_response_currency.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseResponseCurrencyCWProxy {
  ExpenseResponseCurrency code(String? code);

  ExpenseResponseCurrency symbol(String? symbol);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseCurrency(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseCurrency(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseCurrency call({String? code, String? symbol});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseResponseCurrency.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseResponseCurrency.copyWith.fieldName(...)`
class _$ExpenseResponseCurrencyCWProxyImpl
    implements _$ExpenseResponseCurrencyCWProxy {
  const _$ExpenseResponseCurrencyCWProxyImpl(this._value);

  final ExpenseResponseCurrency _value;

  @override
  ExpenseResponseCurrency code(String? code) => this(code: code);

  @override
  ExpenseResponseCurrency symbol(String? symbol) => this(symbol: symbol);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseCurrency(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseCurrency(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseCurrency call({
    Object? code = const $CopyWithPlaceholder(),
    Object? symbol = const $CopyWithPlaceholder(),
  }) {
    return ExpenseResponseCurrency(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      symbol: symbol == const $CopyWithPlaceholder()
          ? _value.symbol
          // ignore: cast_nullable_to_non_nullable
          : symbol as String?,
    );
  }
}

extension $ExpenseResponseCurrencyCopyWith on ExpenseResponseCurrency {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseResponseCurrency.copyWith(...)` or like so:`instanceOfExpenseResponseCurrency.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseResponseCurrencyCWProxy get copyWith =>
      _$ExpenseResponseCurrencyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseResponseCurrency _$ExpenseResponseCurrencyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseResponseCurrency', json, ($checkedConvert) {
  final val = ExpenseResponseCurrency(
    code: $checkedConvert('code', (v) => v as String?),
    symbol: $checkedConvert('symbol', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ExpenseResponseCurrencyToJson(
  ExpenseResponseCurrency instance,
) => <String, dynamic>{'code': ?instance.code, 'symbol': ?instance.symbol};
