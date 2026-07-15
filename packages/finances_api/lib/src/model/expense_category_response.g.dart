// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryResponseCWProxy {
  ExpenseCategoryResponse name(String? name);

  ExpenseCategoryResponse limit(ExpenseCategoryLimit? limit);

  ExpenseCategoryResponse recipientPatterns(
    List<ExpenseCategoryRecipientPatternResponse>? recipientPatterns,
  );

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryResponse call({
    String? name,
    ExpenseCategoryLimit? limit,
    List<ExpenseCategoryRecipientPatternResponse>? recipientPatterns,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryResponse.copyWith.fieldName(...)`
class _$ExpenseCategoryResponseCWProxyImpl
    implements _$ExpenseCategoryResponseCWProxy {
  const _$ExpenseCategoryResponseCWProxyImpl(this._value);

  final ExpenseCategoryResponse _value;

  @override
  ExpenseCategoryResponse name(String? name) => this(name: name);

  @override
  ExpenseCategoryResponse limit(ExpenseCategoryLimit? limit) =>
      this(limit: limit);

  @override
  ExpenseCategoryResponse recipientPatterns(
    List<ExpenseCategoryRecipientPatternResponse>? recipientPatterns,
  ) => this(recipientPatterns: recipientPatterns);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryResponse call({
    Object? name = const $CopyWithPlaceholder(),
    Object? limit = const $CopyWithPlaceholder(),
    Object? recipientPatterns = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryResponse(
      name: name == const $CopyWithPlaceholder()
          ? _value.name
          // ignore: cast_nullable_to_non_nullable
          : name as String?,
      limit: limit == const $CopyWithPlaceholder()
          ? _value.limit
          // ignore: cast_nullable_to_non_nullable
          : limit as ExpenseCategoryLimit?,
      recipientPatterns: recipientPatterns == const $CopyWithPlaceholder()
          ? _value.recipientPatterns
          // ignore: cast_nullable_to_non_nullable
          : recipientPatterns as List<ExpenseCategoryRecipientPatternResponse>?,
    );
  }
}

extension $ExpenseCategoryResponseCopyWith on ExpenseCategoryResponse {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryResponse.copyWith(...)` or like so:`instanceOfExpenseCategoryResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryResponseCWProxy get copyWith =>
      _$ExpenseCategoryResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryResponse _$ExpenseCategoryResponseFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseCategoryResponse', json, ($checkedConvert) {
  final val = ExpenseCategoryResponse(
    name: $checkedConvert('name', (v) => v as String?),
    limit: $checkedConvert(
      'limit',
      (v) => v == null
          ? null
          : ExpenseCategoryLimit.fromJson(v as Map<String, dynamic>),
    ),
    recipientPatterns: $checkedConvert(
      'recipientPatterns',
      (v) => (v as List<dynamic>?)
          ?.map(
            (e) => ExpenseCategoryRecipientPatternResponse.fromJson(
              e as Map<String, dynamic>,
            ),
          )
          .toList(),
    ),
  );
  return val;
});

Map<String, dynamic> _$ExpenseCategoryResponseToJson(
  ExpenseCategoryResponse instance,
) => <String, dynamic>{
  'name': ?instance.name,
  'limit': ?instance.limit?.toJson(),
  'recipientPatterns': ?instance.recipientPatterns
      ?.map((e) => e.toJson())
      .toList(),
};
