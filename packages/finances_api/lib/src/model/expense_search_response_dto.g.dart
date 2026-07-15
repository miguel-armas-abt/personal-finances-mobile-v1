// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_search_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseSearchResponseDtoCWProxy {
  ExpenseSearchResponseDto expenses(List<ExpenseResponseDto>? expenses);

  ExpenseSearchResponseDto nextCursor(String? nextCursor);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSearchResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSearchResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSearchResponseDto call({
    List<ExpenseResponseDto>? expenses,
    String? nextCursor,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseSearchResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseSearchResponseDto.copyWith.fieldName(...)`
class _$ExpenseSearchResponseDtoCWProxyImpl
    implements _$ExpenseSearchResponseDtoCWProxy {
  const _$ExpenseSearchResponseDtoCWProxyImpl(this._value);

  final ExpenseSearchResponseDto _value;

  @override
  ExpenseSearchResponseDto expenses(List<ExpenseResponseDto>? expenses) =>
      this(expenses: expenses);

  @override
  ExpenseSearchResponseDto nextCursor(String? nextCursor) =>
      this(nextCursor: nextCursor);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSearchResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSearchResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSearchResponseDto call({
    Object? expenses = const $CopyWithPlaceholder(),
    Object? nextCursor = const $CopyWithPlaceholder(),
  }) {
    return ExpenseSearchResponseDto(
      expenses: expenses == const $CopyWithPlaceholder()
          ? _value.expenses
          // ignore: cast_nullable_to_non_nullable
          : expenses as List<ExpenseResponseDto>?,
      nextCursor: nextCursor == const $CopyWithPlaceholder()
          ? _value.nextCursor
          // ignore: cast_nullable_to_non_nullable
          : nextCursor as String?,
    );
  }
}

extension $ExpenseSearchResponseDtoCopyWith on ExpenseSearchResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseSearchResponseDto.copyWith(...)` or like so:`instanceOfExpenseSearchResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseSearchResponseDtoCWProxy get copyWith =>
      _$ExpenseSearchResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseSearchResponseDto _$ExpenseSearchResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseSearchResponseDto', json, ($checkedConvert) {
  final val = ExpenseSearchResponseDto(
    expenses: $checkedConvert(
      'expenses',
      (v) => (v as List<dynamic>?)
          ?.map((e) => ExpenseResponseDto.fromJson(e as Map<String, dynamic>))
          .toList(),
    ),
    nextCursor: $checkedConvert('nextCursor', (v) => v as String?),
  );
  return val;
});

Map<String, dynamic> _$ExpenseSearchResponseDtoToJson(
  ExpenseSearchResponseDto instance,
) => <String, dynamic>{
  'expenses': ?instance.expenses?.map((e) => e.toJson()).toList(),
  'nextCursor': ?instance.nextCursor,
};
