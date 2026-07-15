// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_currency.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryCurrencyCWProxy {
  ExpenseCategoryCurrency code(String? code);

  ExpenseCategoryCurrency symbol(String? symbol);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryCurrency(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryCurrency(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryCurrency call({String? code, String? symbol});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryCurrency.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryCurrency.copyWith.fieldName(...)`
class _$ExpenseCategoryCurrencyCWProxyImpl
    implements _$ExpenseCategoryCurrencyCWProxy {
  const _$ExpenseCategoryCurrencyCWProxyImpl(this._value);

  final ExpenseCategoryCurrency _value;

  @override
  ExpenseCategoryCurrency code(String? code) => this(code: code);

  @override
  ExpenseCategoryCurrency symbol(String? symbol) => this(symbol: symbol);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryCurrency(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryCurrency(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryCurrency call({
    Object? code = const $CopyWithPlaceholder(),
    Object? symbol = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryCurrency(
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

extension $ExpenseCategoryCurrencyCopyWith on ExpenseCategoryCurrency {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryCurrency.copyWith(...)` or like so:`instanceOfExpenseCategoryCurrency.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryCurrencyCWProxy get copyWith =>
      _$ExpenseCategoryCurrencyCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryCurrency _$ExpenseCategoryCurrencyFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseCategoryCurrency', json, ($checkedConvert) {
  final val = ExpenseCategoryCurrency(
    code: $checkedConvert('code', (v) => v as String?),
    symbol: $checkedConvert('symbol', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ExpenseCategoryCurrencyToJson(
  ExpenseCategoryCurrency instance,
) => <String, dynamic>{'code': ?instance.code, 'symbol': ?instance.symbol};
