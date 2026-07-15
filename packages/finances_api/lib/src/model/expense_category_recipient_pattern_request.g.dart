// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_category_recipient_pattern_request.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseCategoryRecipientPatternRequestCWProxy {
  ExpenseCategoryRecipientPatternRequest code(String code);

  ExpenseCategoryRecipientPatternRequest value(String value);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRecipientPatternRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRecipientPatternRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRecipientPatternRequest call({String code, String value});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseCategoryRecipientPatternRequest.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseCategoryRecipientPatternRequest.copyWith.fieldName(...)`
class _$ExpenseCategoryRecipientPatternRequestCWProxyImpl
    implements _$ExpenseCategoryRecipientPatternRequestCWProxy {
  const _$ExpenseCategoryRecipientPatternRequestCWProxyImpl(this._value);

  final ExpenseCategoryRecipientPatternRequest _value;

  @override
  ExpenseCategoryRecipientPatternRequest code(String code) => this(code: code);

  @override
  ExpenseCategoryRecipientPatternRequest value(String value) =>
      this(value: value);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseCategoryRecipientPatternRequest(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseCategoryRecipientPatternRequest(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseCategoryRecipientPatternRequest call({
    Object? code = const $CopyWithPlaceholder(),
    Object? value = const $CopyWithPlaceholder(),
  }) {
    return ExpenseCategoryRecipientPatternRequest(
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String,
      value: value == const $CopyWithPlaceholder()
          ? _value.value
          // ignore: cast_nullable_to_non_nullable
          : value as String,
    );
  }
}

extension $ExpenseCategoryRecipientPatternRequestCopyWith
    on ExpenseCategoryRecipientPatternRequest {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseCategoryRecipientPatternRequest.copyWith(...)` or like so:`instanceOfExpenseCategoryRecipientPatternRequest.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseCategoryRecipientPatternRequestCWProxy get copyWith =>
      _$ExpenseCategoryRecipientPatternRequestCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseCategoryRecipientPatternRequest
_$ExpenseCategoryRecipientPatternRequestFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExpenseCategoryRecipientPatternRequest', json, (
      $checkedConvert,
    ) {
      $checkKeys(json, requiredKeys: const ['code', 'value']);
      final val = ExpenseCategoryRecipientPatternRequest(
        code: $checkedConvert('code', (v) => v as String),
        value: $checkedConvert('value', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$ExpenseCategoryRecipientPatternRequestToJson(
  ExpenseCategoryRecipientPatternRequest instance,
) => <String, dynamic>{'code': instance.code, 'value': instance.value};
