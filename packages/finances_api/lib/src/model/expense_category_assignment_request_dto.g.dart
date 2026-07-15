// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_assignment_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryAssignmentRequestDtoCWProxy {
  ExpenseCategoryAssignmentRequestDto overwriteExistingCategories(
    bool? overwriteExistingCategories,
  );

  ExpenseCategoryAssignmentRequestDto from(DateTime from);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryAssignmentRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryAssignmentRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryAssignmentRequestDto call({
    bool? overwriteExistingCategories,
    DateTime from,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryAssignmentRequestDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryAssignmentRequestDto.copyWith.fieldName(...)`
class _$ExpenseCategoryAssignmentRequestDtoCWProxyImpl
    implements _$ExpenseCategoryAssignmentRequestDtoCWProxy {
  const _$ExpenseCategoryAssignmentRequestDtoCWProxyImpl(this._value);

  final ExpenseCategoryAssignmentRequestDto _value;

  @override
  ExpenseCategoryAssignmentRequestDto overwriteExistingCategories(
    bool? overwriteExistingCategories,
  ) => this(overwriteExistingCategories: overwriteExistingCategories);

  @override
  ExpenseCategoryAssignmentRequestDto from(DateTime from) => this(from: from);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryAssignmentRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryAssignmentRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryAssignmentRequestDto call({
    Object? overwriteExistingCategories = const $CopyWithPlaceholder(),
    Object? from = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryAssignmentRequestDto(
      overwriteExistingCategories:
          overwriteExistingCategories == const $CopyWithPlaceholder()
          ? _value.overwriteExistingCategories
          // ignore: cast_nullable_to_non_nullable
          : overwriteExistingCategories as bool?,
      from: from == const $CopyWithPlaceholder()
          ? _value.from
          // ignore: cast_nullable_to_non_nullable
          : from as DateTime,
    );
  }
}

extension $ExpenseCategoryAssignmentRequestDtoCopyWith
    on ExpenseCategoryAssignmentRequestDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryAssignmentRequestDto.copyWith(...)` or like so:`instanceOfExpenseCategoryAssignmentRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryAssignmentRequestDtoCWProxy get copyWith =>
      _$ExpenseCategoryAssignmentRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryAssignmentRequestDto
_$ExpenseCategoryAssignmentRequestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExpenseCategoryAssignmentRequestDto', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['from']);
      final val = ExpenseCategoryAssignmentRequestDto(
        overwriteExistingCategories: $checkedConvert(
          'overwriteExistingCategories',
          (v) => v as bool? ?? false,
        ),
        from: $checkedConvert('from', (v) => DateTime.parse(v as String)),
      );
      return val;
    });

Map<String, dynamic> _$ExpenseCategoryAssignmentRequestDtoToJson(
  ExpenseCategoryAssignmentRequestDto instance,
) => <String, dynamic>{
  'overwriteExistingCategories': ?instance.overwriteExistingCategories,
  'from': instance.from.toIso8601String(),
};
