// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_response_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseResponseDetailCWProxy {
  ExpenseResponseDetail category(String? category);

  ExpenseResponseDetail comments(String? comments);

  ExpenseResponseDetail recipient(String? recipient);

  ExpenseResponseDetail source_(String? source_);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseDetail call({
    String? category,
    String? comments,
    String? recipient,
    String? source_,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseResponseDetail.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseResponseDetail.copyWith.fieldName(...)`
class _$ExpenseResponseDetailCWProxyImpl
    implements _$ExpenseResponseDetailCWProxy {
  const _$ExpenseResponseDetailCWProxyImpl(this._value);

  final ExpenseResponseDetail _value;

  @override
  ExpenseResponseDetail category(String? category) => this(category: category);

  @override
  ExpenseResponseDetail comments(String? comments) => this(comments: comments);

  @override
  ExpenseResponseDetail recipient(String? recipient) =>
      this(recipient: recipient);

  @override
  ExpenseResponseDetail source_(String? source_) => this(source_: source_);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseResponseDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseResponseDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseResponseDetail call({
    Object? category = const $CopyWithPlaceholder(),
    Object? comments = const $CopyWithPlaceholder(),
    Object? recipient = const $CopyWithPlaceholder(),
    Object? source_ = const $CopyWithPlaceholder(),
  }) {
    return ExpenseResponseDetail(
      category: category == const $CopyWithPlaceholder()
          ? _value.category
          // ignore: cast_nullable_to_non_nullable
          : category as String?,
      comments: comments == const $CopyWithPlaceholder()
          ? _value.comments
          // ignore: cast_nullable_to_non_nullable
          : comments as String?,
      recipient: recipient == const $CopyWithPlaceholder()
          ? _value.recipient
          // ignore: cast_nullable_to_non_nullable
          : recipient as String?,
      source_: source_ == const $CopyWithPlaceholder()
          ? _value.source_
          // ignore: cast_nullable_to_non_nullable
          : source_ as String?,
    );
  }
}

extension $ExpenseResponseDetailCopyWith on ExpenseResponseDetail {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseResponseDetail.copyWith(...)` or like so:`instanceOfExpenseResponseDetail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseResponseDetailCWProxy get copyWith =>
      _$ExpenseResponseDetailCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseResponseDetail _$ExpenseResponseDetailFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('ExpenseResponseDetail', json, ($checkedConvert) {
  final val = ExpenseResponseDetail(
    category: $checkedConvert('category', (v) => v as String?),
    comments: $checkedConvert('comments', (v) => v as String?),
    recipient: $checkedConvert('recipient', (v) => v as String?),
    source_: $checkedConvert('source', (v) => v as String?),
  );
  return val;
}, fieldKeyMap: const {'source_': 'source'});

Map<String, dynamic> _$ExpenseResponseDetailToJson(
  ExpenseResponseDetail instance,
) => <String, dynamic>{
  'category': ?instance.category,
  'comments': ?instance.comments,
  'recipient': ?instance.recipient,
  'source': ?instance.source_,
};
