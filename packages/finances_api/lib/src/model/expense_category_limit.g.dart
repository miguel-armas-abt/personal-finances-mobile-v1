// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_limit.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryLimitCWProxy {
  ExpenseCategoryLimit amount(String? amount);

  ExpenseCategoryLimit isExceeded(bool? isExceeded);

  ExpenseCategoryLimit balance(String? balance);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryLimit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryLimit(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryLimit call({
    String? amount,
    bool? isExceeded,
    String? balance,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryLimit.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryLimit.copyWith.fieldName(...)`
class _$ExpenseCategoryLimitCWProxyImpl
    implements _$ExpenseCategoryLimitCWProxy {
  const _$ExpenseCategoryLimitCWProxyImpl(this._value);

  final ExpenseCategoryLimit _value;

  @override
  ExpenseCategoryLimit amount(String? amount) => this(amount: amount);

  @override
  ExpenseCategoryLimit isExceeded(bool? isExceeded) =>
      this(isExceeded: isExceeded);

  @override
  ExpenseCategoryLimit balance(String? balance) => this(balance: balance);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryLimit(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryLimit(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryLimit call({
    Object? amount = const $CopyWithPlaceholder(),
    Object? isExceeded = const $CopyWithPlaceholder(),
    Object? balance = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryLimit(
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as String?,
      isExceeded: isExceeded == const $CopyWithPlaceholder()
          ? _value.isExceeded
          // ignore: cast_nullable_to_non_nullable
          : isExceeded as bool?,
      balance: balance == const $CopyWithPlaceholder()
          ? _value.balance
          // ignore: cast_nullable_to_non_nullable
          : balance as String?,
    );
  }
}

extension $ExpenseCategoryLimitCopyWith on ExpenseCategoryLimit {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryLimit.copyWith(...)` or like so:`instanceOfExpenseCategoryLimit.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryLimitCWProxy get copyWith =>
      _$ExpenseCategoryLimitCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryLimit _$ExpenseCategoryLimitFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseCategoryLimit', json, ($checkedConvert) {
  final val = ExpenseCategoryLimit(
    amount: $checkedConvert('amount', (v) => v as String?),
    isExceeded: $checkedConvert('isExceeded', (v) => v as bool?),
    balance: $checkedConvert('balance', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ExpenseCategoryLimitToJson(
  ExpenseCategoryLimit instance,
) => <String, dynamic>{
  'amount': ?instance.amount,
  'isExceeded': ?instance.isExceeded,
  'balance': ?instance.balance,
};
