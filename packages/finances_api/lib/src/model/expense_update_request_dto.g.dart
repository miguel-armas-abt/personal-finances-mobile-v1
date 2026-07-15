// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_update_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseUpdateRequestDtoCWProxy {
  ExpenseUpdateRequestDto date(String date);

  ExpenseUpdateRequestDto detail(ExpenseUpdateDetail detail);

  ExpenseUpdateRequestDto currency(String currency);

  ExpenseUpdateRequestDto amount(String amount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseUpdateRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseUpdateRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseUpdateRequestDto call({
    String date,
    ExpenseUpdateDetail detail,
    String currency,
    String amount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseUpdateRequestDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseUpdateRequestDto.copyWith.fieldName(...)`
class _$ExpenseUpdateRequestDtoCWProxyImpl
    implements _$ExpenseUpdateRequestDtoCWProxy {
  const _$ExpenseUpdateRequestDtoCWProxyImpl(this._value);

  final ExpenseUpdateRequestDto _value;

  @override
  ExpenseUpdateRequestDto date(String date) => this(date: date);

  @override
  ExpenseUpdateRequestDto detail(ExpenseUpdateDetail detail) =>
      this(detail: detail);

  @override
  ExpenseUpdateRequestDto currency(String currency) => this(currency: currency);

  @override
  ExpenseUpdateRequestDto amount(String amount) => this(amount: amount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseUpdateRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseUpdateRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseUpdateRequestDto call({
    Object? date = const $CopyWithPlaceholder(),
    Object? detail = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
  }) {
    return ExpenseUpdateRequestDto(
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      detail: detail == const $CopyWithPlaceholder()
          ? _value.detail
          // ignore: cast_nullable_to_non_nullable
          : detail as ExpenseUpdateDetail,
      currency: currency == const $CopyWithPlaceholder()
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as String,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as String,
    );
  }
}

extension $ExpenseUpdateRequestDtoCopyWith on ExpenseUpdateRequestDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseUpdateRequestDto.copyWith(...)` or like so:`instanceOfExpenseUpdateRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseUpdateRequestDtoCWProxy get copyWith =>
      _$ExpenseUpdateRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseUpdateRequestDto _$ExpenseUpdateRequestDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseUpdateRequestDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['date', 'detail', 'currency', 'amount'],
  );
  final val = ExpenseUpdateRequestDto(
    date: $checkedConvert('date', (v) => v as String),
    detail: $checkedConvert(
      'detail',
      (v) => ExpenseUpdateDetail.fromJson(v as Map<String, dynamic>),
    ),
    currency: $checkedConvert('currency', (v) => v as String),
    amount: $checkedConvert('amount', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$ExpenseUpdateRequestDtoToJson(
  ExpenseUpdateRequestDto instance,
) => <String, dynamic>{
  'date': instance.date,
  'detail': instance.detail.toJson(),
  'currency': instance.currency,
  'amount': instance.amount,
};
