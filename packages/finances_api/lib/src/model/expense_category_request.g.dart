// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryRequestCWProxy {
  ExpenseCategoryRequest name(String name);

  ExpenseCategoryRequest limit(String limit);

  ExpenseCategoryRequest recipientPatterns(
    List<ExpenseCategoryRecipientPatternRequest>? recipientPatterns,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRequest call({
    String name,
    String limit,
    List<ExpenseCategoryRecipientPatternRequest>? recipientPatterns,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryRequest.copyWith.fieldName(...)`
class _$ExpenseCategoryRequestCWProxyImpl
    implements _$ExpenseCategoryRequestCWProxy {
  const _$ExpenseCategoryRequestCWProxyImpl(this._value);

  final ExpenseCategoryRequest _value;

  @override
  ExpenseCategoryRequest name(String name) => this(name: name);

  @override
  ExpenseCategoryRequest limit(String limit) => this(limit: limit);

  @override
  ExpenseCategoryRequest recipientPatterns(
    List<ExpenseCategoryRecipientPatternRequest>? recipientPatterns,
  ) => this(recipientPatterns: recipientPatterns);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRequest call({
    Object? name = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? recipientPatterns = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryRequest(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as String,
      recipientPatterns: recipientPatterns == const $CopyWithPlaceholder()
          ? _value.recipientPatterns
          // ignore: cast_nullable_to_non_nullable
          : recipientPatterns as List<ExpenseCategoryRecipientPatternRequest>?,
    );
  }
}

extension $ExpenseCategoryRequestCopyWith on ExpenseCategoryRequest {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryRequest.copyWith(...)` or like so:`instanceOfExpenseCategoryRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryRequestCWProxy get copyWith =>
      _$ExpenseCategoryRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryRequest _$ExpenseCategoryRequestFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseCategoryRequest', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['name', 'limit']);
  final val = ExpenseCategoryRequest(
    name: $checkedConvert('name', (v) => v as String),
    limit: $checkedConvert('limit', (v) => v as String),
    recipientPatterns: $checkedConvert(
      'recipientPatterns',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => ExpenseCategoryRecipientPatternRequest.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExpenseCategoryRequestToJson(
  ExpenseCategoryRequest instance,
) => <String, dynamic>{
  'name': instance.name,
  'limit': instance.limit,
  'recipientPatterns': ?instance.recipientPatterns
      ?.map((e) => e.toJson())
      .toList(),
};
