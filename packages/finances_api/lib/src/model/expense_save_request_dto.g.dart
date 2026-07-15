// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_save_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseSaveRequestDtoCWProxy {
  ExpenseSaveRequestDto userEmail(String userEmail);

  ExpenseSaveRequestDto gmailMessageId(String? gmailMessageId);

  ExpenseSaveRequestDto date(String date);

  ExpenseSaveRequestDto detail(ExpenseSaveDetail detail);

  ExpenseSaveRequestDto currency(String currency);

  ExpenseSaveRequestDto amount(String amount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSaveRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSaveRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSaveRequestDto call({
    String userEmail,
    String? gmailMessageId,
    String date,
    ExpenseSaveDetail detail,
    String currency,
    String amount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseSaveRequestDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseSaveRequestDto.copyWith.fieldName(...)`
class _$ExpenseSaveRequestDtoCWProxyImpl
    implements _$ExpenseSaveRequestDtoCWProxy {
  const _$ExpenseSaveRequestDtoCWProxyImpl(this._value);

  final ExpenseSaveRequestDto _value;

  @override
  ExpenseSaveRequestDto userEmail(String userEmail) =>
      this(userEmail: userEmail);

  @override
  ExpenseSaveRequestDto gmailMessageId(String? gmailMessageId) =>
      this(gmailMessageId: gmailMessageId);

  @override
  ExpenseSaveRequestDto date(String date) => this(date: date);

  @override
  ExpenseSaveRequestDto detail(ExpenseSaveDetail detail) =>
      this(detail: detail);

  @override
  ExpenseSaveRequestDto currency(String currency) => this(currency: currency);

  @override
  ExpenseSaveRequestDto amount(String amount) => this(amount: amount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSaveRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSaveRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSaveRequestDto call({
    Object? userEmail = const $CopyWithPlaceholder(),
    Object? gmailMessageId = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? detail = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
  }) {
    return ExpenseSaveRequestDto(
      userEmail: userEmail == const $CopyWithPlaceholder()
          ? _value.userEmail
          // ignore: cast_nullable_to_non_nullable
          : userEmail as String,
      gmailMessageId: gmailMessageId == const $CopyWithPlaceholder()
          ? _value.gmailMessageId
          // ignore: cast_nullable_to_non_nullable
          : gmailMessageId as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as String,
      detail: detail == const $CopyWithPlaceholder()
          ? _value.detail
          // ignore: cast_nullable_to_non_nullable
          : detail as ExpenseSaveDetail,
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

extension $ExpenseSaveRequestDtoCopyWith on ExpenseSaveRequestDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseSaveRequestDto.copyWith(...)` or like so:`instanceOfExpenseSaveRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseSaveRequestDtoCWProxy get copyWith =>
      _$ExpenseSaveRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseSaveRequestDto _$ExpenseSaveRequestDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseSaveRequestDto', json, ($checkedConvert) {
  $checkKeys(
    json,
    requiredKeys: const ['userEmail', 'date', 'detail', 'currency', 'amount'],
  );
  final val = ExpenseSaveRequestDto(
    userEmail: $checkedConvert('userEmail', (v) => v as String),
    gmailMessageId: $checkedConvert('gmailMessageId', (v) => v as String?),
    date: $checkedConvert('date', (v) => v as String),
    detail: $checkedConvert(
      'detail',
      (v) => ExpenseSaveDetail.fromJson(v as Map<String, dynamic>),
    ),
    currency: $checkedConvert('currency', (v) => v as String),
    amount: $checkedConvert('amount', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$ExpenseSaveRequestDtoToJson(
  ExpenseSaveRequestDto instance,
) => <String, dynamic>{
  'userEmail': instance.userEmail,
  'gmailMessageId': ?instance.gmailMessageId,
  'date': instance.date,
  'detail': instance.detail.toJson(),
  'currency': instance.currency,
  'amount': instance.amount,
};
