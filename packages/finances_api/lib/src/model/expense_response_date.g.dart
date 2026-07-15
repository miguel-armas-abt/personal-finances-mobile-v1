// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_response_date.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseResponseDateCWProxy {
  ExpenseResponseDate utc(DateTime? utc);

  ExpenseResponseDate formatted(String? formatted);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseDate(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseDate(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseDate call({DateTime? utc, String? formatted});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseResponseDate.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseResponseDate.copyWith.fieldName(...)`
class _$ExpenseResponseDateCWProxyImpl implements _$ExpenseResponseDateCWProxy {
  const _$ExpenseResponseDateCWProxyImpl(this._value);

  final ExpenseResponseDate _value;

  @override
  ExpenseResponseDate utc(DateTime? utc) => this(utc: utc);

  @override
  ExpenseResponseDate formatted(String? formatted) =>
      this(formatted: formatted);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseDate(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseDate(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseDate call({
    Object? utc = const $CopyWithPlaceholder(),
    Object? formatted = const $CopyWithPlaceholder(),
  }) {
    return ExpenseResponseDate(
      utc: utc == const $CopyWithPlaceholder()
          ? _value.utc
          // ignore: cast_nullable_to_non_nullable
          : utc as DateTime?,
      formatted: formatted == const $CopyWithPlaceholder()
          ? _value.formatted
          // ignore: cast_nullable_to_non_nullable
          : formatted as String?,
    );
  }
}

extension $ExpenseResponseDateCopyWith on ExpenseResponseDate {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseResponseDate.copyWith(...)` or like so:`instanceOfExpenseResponseDate.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseResponseDateCWProxy get copyWith =>
      _$ExpenseResponseDateCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseResponseDate _$ExpenseResponseDateFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExpenseResponseDate', json, ($checkedConvert) {
      final val = ExpenseResponseDate(
        utc: $checkedConvert(
          'utc',
          (v) => v == null ? null : DateTime.parse(v as String),
        ),
        formatted: $checkedConvert('formatted', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ExpenseResponseDateToJson(
  ExpenseResponseDate instance,
) => <String, dynamic>{
  'utc': ?instance.utc?.toIso8601String(),
  'formatted': ?instance.formatted,
};
