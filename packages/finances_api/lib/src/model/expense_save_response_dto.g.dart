// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_save_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseSaveResponseDtoCWProxy {
  ExpenseSaveResponseDto expenseId(String? expenseId);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSaveResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSaveResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSaveResponseDto call({String? expenseId});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseSaveResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseSaveResponseDto.copyWith.fieldName(...)`
class _$ExpenseSaveResponseDtoCWProxyImpl
    implements _$ExpenseSaveResponseDtoCWProxy {
  const _$ExpenseSaveResponseDtoCWProxyImpl(this._value);

  final ExpenseSaveResponseDto _value;

  @override
  ExpenseSaveResponseDto expenseId(String? expenseId) =>
      this(expenseId: expenseId);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSaveResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSaveResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSaveResponseDto call({
    Object? expenseId = const $CopyWithPlaceholder(),
  }) {
    return ExpenseSaveResponseDto(
      expenseId: expenseId == const $CopyWithPlaceholder()
          ? _value.expenseId
          // ignore: cast_nullable_to_non_nullable
          : expenseId as String?,
    );
  }
}

extension $ExpenseSaveResponseDtoCopyWith on ExpenseSaveResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseSaveResponseDto.copyWith(...)` or like so:`instanceOfExpenseSaveResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseSaveResponseDtoCWProxy get copyWith =>
      _$ExpenseSaveResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseSaveResponseDto _$ExpenseSaveResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseSaveResponseDto', json, ($checkedConvert) {
  final val = ExpenseSaveResponseDto(
    expenseId: $checkedConvert('expenseId', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ExpenseSaveResponseDtoToJson(
  ExpenseSaveResponseDto instance,
) => <String, dynamic>{'expenseId': ?instance.expenseId};
