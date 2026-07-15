// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_updated_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseUpdatedResponseDtoCWProxy {
  ExpenseUpdatedResponseDto ids(List<String>? ids);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseUpdatedResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseUpdatedResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseUpdatedResponseDto call({List<String>? ids});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseUpdatedResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseUpdatedResponseDto.copyWith.fieldName(...)`
class _$ExpenseUpdatedResponseDtoCWProxyImpl
    implements _$ExpenseUpdatedResponseDtoCWProxy {
  const _$ExpenseUpdatedResponseDtoCWProxyImpl(this._value);

  final ExpenseUpdatedResponseDto _value;

  @override
  ExpenseUpdatedResponseDto ids(List<String>? ids) => this(ids: ids);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseUpdatedResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseUpdatedResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseUpdatedResponseDto call({Object? ids = const $CopyWithPlaceholder()}) {
    return ExpenseUpdatedResponseDto(
      ids: ids == const $CopyWithPlaceholder()
          ? _value.ids
          // ignore: cast_nullable_to_non_nullable
          : ids as List<String>?,
    );
  }
}

extension $ExpenseUpdatedResponseDtoCopyWith on ExpenseUpdatedResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseUpdatedResponseDto.copyWith(...)` or like so:`instanceOfExpenseUpdatedResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseUpdatedResponseDtoCWProxy get copyWith =>
      _$ExpenseUpdatedResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseUpdatedResponseDto _$ExpenseUpdatedResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseUpdatedResponseDto', json, ($checkedConvert) {
  final val = ExpenseUpdatedResponseDto(
    ids: $checkedConvert(
      'ids',
      (v) => (v as List<dynamic>?)?.map((e) => e as String).toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExpenseUpdatedResponseDtoToJson(
  ExpenseUpdatedResponseDto instance,
) => <String, dynamic>{'ids': ?instance.ids};
