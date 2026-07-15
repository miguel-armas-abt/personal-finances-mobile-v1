// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_refresh_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseRefreshResponseDtoCWProxy {
  ExpenseRefreshResponseDto gmailMessageIds(List<String>? gmailMessageIds);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseRefreshResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseRefreshResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseRefreshResponseDto call({List<String>? gmailMessageIds});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseRefreshResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseRefreshResponseDto.copyWith.fieldName(...)`
class _$ExpenseRefreshResponseDtoCWProxyImpl
    implements _$ExpenseRefreshResponseDtoCWProxy {
  const _$ExpenseRefreshResponseDtoCWProxyImpl(this._value);

  final ExpenseRefreshResponseDto _value;

  @override
  ExpenseRefreshResponseDto gmailMessageIds(List<String>? gmailMessageIds) =>
      this(gmailMessageIds: gmailMessageIds);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseRefreshResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseRefreshResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseRefreshResponseDto call({
    Object? gmailMessageIds = const $CopyWithPlaceholder(),
  }) {
    return ExpenseRefreshResponseDto(
      gmailMessageIds: gmailMessageIds == const $CopyWithPlaceholder()
          ? _value.gmailMessageIds
          // ignore: cast_nullable_to_non_nullable
          : gmailMessageIds as List<String>?,
    );
  }
}

extension $ExpenseRefreshResponseDtoCopyWith on ExpenseRefreshResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseRefreshResponseDto.copyWith(...)` or like so:`instanceOfExpenseRefreshResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseRefreshResponseDtoCWProxy get copyWith =>
      _$ExpenseRefreshResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseRefreshResponseDto _$ExpenseRefreshResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseRefreshResponseDto', json, ($checkedConvert) {
  final val = ExpenseRefreshResponseDto(
    gmailMessageIds: $checkedConvert(
      'gmailMessageIds',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExpenseRefreshResponseDtoToJson(
  ExpenseRefreshResponseDto instance,
) => <String, dynamic>{'gmailMessageIds': ?instance.gmailMessageIds};
