// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_update_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseUpdateDetailCWProxy {
  ExpenseUpdateDetail category(String category);

  ExpenseUpdateDetail comments(String comments);

  ExpenseUpdateDetail recipient(String? recipient);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseUpdateDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseUpdateDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseUpdateDetail call({
    String category,
    String comments,
    String? recipient,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseUpdateDetail.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseUpdateDetail.copyWith.fieldName(...)`
class _$ExpenseUpdateDetailCWProxyImpl implements _$ExpenseUpdateDetailCWProxy {
  const _$ExpenseUpdateDetailCWProxyImpl(this._value);

  final ExpenseUpdateDetail _value;

  @override
  ExpenseUpdateDetail category(String category) => this(category: category);

  @override
  ExpenseUpdateDetail comments(String comments) => this(comments: comments);

  @override
  ExpenseUpdateDetail recipient(String? recipient) =>
      this(recipient: recipient);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseUpdateDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseUpdateDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseUpdateDetail call({
    Object? category = const $CopyWithPlaceholder(),
    Object? comments = const $CopyWithPlaceholder(),
    Object? recipient = const $CopyWithPlaceholder(),
  }) {
    return ExpenseUpdateDetail(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String,
      comments: comments == const $CopyWithPlaceholder()
          ? _value.comments
          // ignore: cast_nullable_to_non_nullable
          : comments as String,
      recipient: recipient == const $CopyWithPlaceholder()
          ? _value.recipient
          // ignore: cast_nullable_to_non_nullable
          : recipient as String?,
    );
  }
}

extension $ExpenseUpdateDetailCopyWith on ExpenseUpdateDetail {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseUpdateDetail.copyWith(...)` or like so:`instanceOfExpenseUpdateDetail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseUpdateDetailCWProxy get copyWith =>
      _$ExpenseUpdateDetailCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseUpdateDetail _$ExpenseUpdateDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExpenseUpdateDetail', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['category', 'comments']);
      final val = ExpenseUpdateDetail(
        category: $checkedConvert('category', (v) => v as String),
        comments: $checkedConvert('comments', (v) => v as String),
        recipient: $checkedConvert('recipient', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ExpenseUpdateDetailToJson(
  ExpenseUpdateDetail instance,
) => <String, dynamic>{
  'category': instance.category,
  'comments': instance.comments,
  'recipient': ?instance.recipient,
};
