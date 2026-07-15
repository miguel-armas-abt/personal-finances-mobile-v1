// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_recipient_pattern_response.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryRecipientPatternResponseCWProxy {
  ExpenseCategoryRecipientPatternResponse code(String? code);

  ExpenseCategoryRecipientPatternResponse value(String? value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRecipientPatternResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRecipientPatternResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRecipientPatternResponse call({String? code, String? value});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryRecipientPatternResponse.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryRecipientPatternResponse.copyWith.fieldName(...)`
class _$ExpenseCategoryRecipientPatternResponseCWProxyImpl
    implements _$ExpenseCategoryRecipientPatternResponseCWProxy {
  const _$ExpenseCategoryRecipientPatternResponseCWProxyImpl(this._value);

  final ExpenseCategoryRecipientPatternResponse _value;

  @override
  ExpenseCategoryRecipientPatternResponse code(String? code) =>
      this(code: code);

  @override
  ExpenseCategoryRecipientPatternResponse value(String? value) =>
      this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRecipientPatternResponse(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRecipientPatternResponse(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRecipientPatternResponse call({
    Object? code = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryRecipientPatternResponse(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String?,
    );
  }
}

extension $ExpenseCategoryRecipientPatternResponseCopyWith
    on ExpenseCategoryRecipientPatternResponse {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryRecipientPatternResponse.copyWith(...)` or like so:`instanceOfExpenseCategoryRecipientPatternResponse.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryRecipientPatternResponseCWProxy get copyWith =>
      _$ExpenseCategoryRecipientPatternResponseCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryRecipientPatternResponse
_$ExpenseCategoryRecipientPatternResponseFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExpenseCategoryRecipientPatternResponse', json, (
      $checkedConvert,
    ) {
      final val = ExpenseCategoryRecipientPatternResponse(
        code: $checkedConvert('code', (v) => v as String?),
        value: $checkedConvert('value', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ExpenseCategoryRecipientPatternResponseToJson(
  ExpenseCategoryRecipientPatternResponse instance,
) => <String, dynamic>{'code': ?instance.code, 'value': ?instance.value};
