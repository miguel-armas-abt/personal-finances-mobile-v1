// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseResponseDtoCWProxy {
  ExpenseResponseDto id(String? id);

  ExpenseResponseDto gmailMessageId(String? gmailMessageId);

  ExpenseResponseDto date(ExpenseResponseDate? date);

  ExpenseResponseDto detail(ExpenseResponseDetail? detail);

  ExpenseResponseDto currency(ExpenseResponseCurrency? currency);

  ExpenseResponseDto amount(String? amount);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseDto call({
    String? id,
    String? gmailMessageId,
    ExpenseResponseDate? date,
    ExpenseResponseDetail? detail,
    ExpenseResponseCurrency? currency,
    String? amount,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseResponseDto.copyWith.fieldName(...)`
class _$ExpenseResponseDtoCWProxyImpl implements _$ExpenseResponseDtoCWProxy {
  const _$ExpenseResponseDtoCWProxyImpl(this._value);

  final ExpenseResponseDto _value;

  @override
  ExpenseResponseDto id(String? id) => this(id: id);

  @override
  ExpenseResponseDto gmailMessageId(String? gmailMessageId) =>
      this(gmailMessageId: gmailMessageId);

  @override
  ExpenseResponseDto date(ExpenseResponseDate? date) => this(date: date);

  @override
  ExpenseResponseDto detail(ExpenseResponseDetail? detail) =>
      this(detail: detail);

  @override
  ExpenseResponseDto currency(ExpenseResponseCurrency? currency) =>
      this(currency: currency);

  @override
  ExpenseResponseDto amount(String? amount) => this(amount: amount);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseDto call({
    Object? id = const $CopyWithPlaceholder(),
    Object? gmailMessageId = const $CopyWithPlaceholder(),
    Object? date = const $CopyWithPlaceholder(),
    Object? detail = const $CopyWithPlaceholder(),
    Object? currency = const $CopyWithPlaceholder(),
    Object? amount = const $CopyWithPlaceholder(),
  }) {
    return ExpenseResponseDto(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      gmailMessageId: gmailMessageId == const $CopyWithPlaceholder()
          ? _value.gmailMessageId
          // ignore: cast_nullable_to_non_nullable
          : gmailMessageId as String?,
      date: date == const $CopyWithPlaceholder()
          ? _value.date
          // ignore: cast_nullable_to_non_nullable
          : date as ExpenseResponseDate?,
      detail: detail == const $CopyWithPlaceholder()
          ? _value.detail
          // ignore: cast_nullable_to_non_nullable
          : detail as ExpenseResponseDetail?,
      currency: currency == const $CopyWithPlaceholder()
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as ExpenseResponseCurrency?,
      amount: amount == const $CopyWithPlaceholder()
          ? _value.amount
          // ignore: cast_nullable_to_non_nullable
          : amount as String?,
    );
  }
}

extension $ExpenseResponseDtoCopyWith on ExpenseResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseResponseDto.copyWith(...)` or like so:`instanceOfExpenseResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseResponseDtoCWProxy get copyWith =>
      _$ExpenseResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseResponseDto _$ExpenseResponseDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExpenseResponseDto', json, ($checkedConvert) {
      final val = ExpenseResponseDto(
        id: $checkedConvert('id', (v) => v as String?),
        gmailMessageId: $checkedConvert('gmailMessageId', (v) => v as String?),
        date: $checkedConvert(
          'date',
          (v) => v == null
              ? null
              : ExpenseResponseDate.fromJson(v as Map<String, dynamic>),
        ),
        detail: $checkedConvert(
          'detail',
          (v) => v == null
              ? null
              : ExpenseResponseDetail.fromJson(v as Map<String, dynamic>),
        ),
        currency: $checkedConvert(
          'currency',
          (v) => v == null
              ? null
              : ExpenseResponseCurrency.fromJson(v as Map<String, dynamic>),
        ),
        amount: $checkedConvert('amount', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ExpenseResponseDtoToJson(ExpenseResponseDto instance) =>
    <String, dynamic>{
      'id': ?instance.id,
      'gmailMessageId': ?instance.gmailMessageId,
      'date': ?instance.date?.toJson(),
      'detail': ?instance.detail?.toJson(),
      'currency': ?instance.currency?.toJson(),
      'amount': ?instance.amount,
    };
