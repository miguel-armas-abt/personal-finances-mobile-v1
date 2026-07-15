// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryResponseDtoCWProxy {
  ExpenseCategoryResponseDto currency(ExpenseCategoryCurrency? currency);

  ExpenseCategoryResponseDto categories(
    List<ExpenseCategoryResponse>? categories,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryResponseDto call({
    ExpenseCategoryCurrency? currency,
    List<ExpenseCategoryResponse>? categories,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryResponseDto.copyWith.fieldName(...)`
class _$ExpenseCategoryResponseDtoCWProxyImpl
    implements _$ExpenseCategoryResponseDtoCWProxy {
  const _$ExpenseCategoryResponseDtoCWProxyImpl(this._value);

  final ExpenseCategoryResponseDto _value;

  @override
  ExpenseCategoryResponseDto currency(ExpenseCategoryCurrency? currency) =>
      this(currency: currency);

  @override
  ExpenseCategoryResponseDto categories(
    List<ExpenseCategoryResponse>? categories,
  ) => this(categories: categories);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryResponseDto call({
    Object? currency = const $CopyWithPlaceholder(),
    Object? categories = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryResponseDto(
      currency: currency == const $CopyWithPlaceholder()
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as ExpenseCategoryCurrency?,
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<ExpenseCategoryResponse>?,
    );
  }
}

extension $ExpenseCategoryResponseDtoCopyWith on ExpenseCategoryResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryResponseDto.copyWith(...)` or like so:`instanceOfExpenseCategoryResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryResponseDtoCWProxy get copyWith =>
      _$ExpenseCategoryResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryResponseDto _$ExpenseCategoryResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseCategoryResponseDto', json, ($checkedConvert) {
  final val = ExpenseCategoryResponseDto(
    currency: $checkedConvert(
      'currency',
      (v) => v == null
          ? null
          : ExpenseCategoryCurrency.fromJson(v as Map<String, dynamic>),
    ),
    categories: $checkedConvert(
      'categories',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => ExpenseCategoryResponse.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExpenseCategoryResponseDtoToJson(
  ExpenseCategoryResponseDto instance,
) => <String, dynamic>{
  'currency': ?instance.currency?.toJson(),
  'categories': ?instance.categories?.map((e) => e.toJson()).toList(),
};
