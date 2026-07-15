// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'expense_save_detail.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ExpenseSaveDetailCWProxy {
  ExpenseSaveDetail category(String? category);

  ExpenseSaveDetail comments(String? comments);

  ExpenseSaveDetail recipient(String? recipient);

  ExpenseSaveDetail source_(String source_);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSaveDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSaveDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSaveDetail call({
    String? category,
    String? comments,
    String? recipient,
    String source_,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfExpenseSaveDetail.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfExpenseSaveDetail.copyWith.fieldName(...)`
class _$ExpenseSaveDetailCWProxyImpl implements _$ExpenseSaveDetailCWProxy {
  const _$ExpenseSaveDetailCWProxyImpl(this._value);

  final ExpenseSaveDetail _value;

  @override
  ExpenseSaveDetail category(String? category) => this(category: category);

  @override
  ExpenseSaveDetail comments(String? comments) => this(comments: comments);

  @override
  ExpenseSaveDetail recipient(String? recipient) => this(recipient: recipient);

  @override
  ExpenseSaveDetail source_(String source_) => this(source_: source_);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ExpenseSaveDetail(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ExpenseSaveDetail(...).copyWith(id: 12, name: "My name")
  /// ````
  ExpenseSaveDetail call({
    Object? category = const $CopyWithPlaceholder(),
    Object? comments = const $CopyWithPlaceholder(),
    Object? recipient = const $CopyWithPlaceholder(),
    Object? source_ = const $CopyWithPlaceholder(),
  }) {
    return ExpenseSaveDetail(
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
          : source_ as String,
    );
  }
}

extension $ExpenseSaveDetailCopyWith on ExpenseSaveDetail {
  /// Returns a callable class that can be used as follows: `instanceOfExpenseSaveDetail.copyWith(...)` or like so:`instanceOfExpenseSaveDetail.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ExpenseSaveDetailCWProxy get copyWith =>
      _$ExpenseSaveDetailCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ExpenseSaveDetail _$ExpenseSaveDetailFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ExpenseSaveDetail', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['source']);
      final val = ExpenseSaveDetail(
        category: $checkedConvert('category', (v) => v as String?),
        comments: $checkedConvert('comments', (v) => v as String?),
        recipient: $checkedConvert('recipient', (v) => v as String?),
        source_: $checkedConvert('source', (v) => v as String),
      );
      return val;
    }, fieldKeyMap: const {'source_': 'source'});

Map<String, dynamic> _$ExpenseSaveDetailToJson(ExpenseSaveDetail instance) =>
    <String, dynamic>{
      'category': ?instance.category,
      'comments': ?instance.comments,
      'recipient': ?instance.recipient,
      'source': instance.source_,
    };
