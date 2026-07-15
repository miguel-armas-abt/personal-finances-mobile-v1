// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryRequestDtoCWProxy {
  ExpenseCategoryRequestDto currency(String? currency);

  ExpenseCategoryRequestDto categories(
    List<ExpenseCategoryRequest>? categories,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRequestDto call({
    String? currency,
    List<ExpenseCategoryRequest>? categories,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryRequestDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryRequestDto.copyWith.fieldName(...)`
class _$ExpenseCategoryRequestDtoCWProxyImpl
    implements _$ExpenseCategoryRequestDtoCWProxy {
  const _$ExpenseCategoryRequestDtoCWProxyImpl(this._value);

  final ExpenseCategoryRequestDto _value;

  @override
  ExpenseCategoryRequestDto currency(String? currency) =>
      this(currency: currency);

  @override
  ExpenseCategoryRequestDto categories(
    List<ExpenseCategoryRequest>? categories,
  ) => this(categories: categories);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRequestDto call({
    Object? currency = const $CopyWithPlaceholder(),
    Object? categories = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryRequestDto(
      currency: currency == const $CopyWithPlaceholder()
          ? _value.currency
          // ignore: cast_nullable_to_non_nullable
          : currency as String?,
      categories: categories == const $CopyWithPlaceholder()
          ? _value.categories
          // ignore: cast_nullable_to_non_nullable
          : categories as List<ExpenseCategoryRequest>?,
    );
  }
}

extension $ExpenseCategoryRequestDtoCopyWith on ExpenseCategoryRequestDto {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryRequestDto.copyWith(...)` or like so:`instanceOfExpenseCategoryRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryRequestDtoCWProxy get copyWith =>
      _$ExpenseCategoryRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryRequestDto _$ExpenseCategoryRequestDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseCategoryRequestDto', json, ($checkedConvert) {
  final val = ExpenseCategoryRequestDto(
    currency: $checkedConvert('currency', (v) => v as String?),
    categories: $checkedConvert(
      'categories',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => ExpenseCategoryRequest.fromJson(e as Map<String, dynamic>),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExpenseCategoryRequestDtoToJson(
  ExpenseCategoryRequestDto instance,
) => <String, dynamic>{
  'currency': ?instance.currency,
  'categories': ?instance.categories?.map((e) => e.toJson()).toList(),
};
