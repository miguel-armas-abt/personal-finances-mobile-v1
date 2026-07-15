//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_category_limit.dart';
import 'package:finances_api/src/model/expense_category_recipient_pattern_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryResponse {
  /// Returns a new [ExpenseCategoryResponse] instance.
  ExpenseCategoryResponse({this.name, this.limit, this.recipientPatterns});

  /// Categoría principal del gasto.
  @JsonKey(name: r'name', required: false, includeIfNull: false)
  final String? name;

  @JsonKey(name: r'limit', required: false, includeIfNull: false)
  final ExpenseCategoryLimit? limit;

  @JsonKey(name: r'recipientPatterns', required: false, includeIfNull: false)
  final List<ExpenseCategoryRecipientPatternResponse>? recipientPatterns;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryResponse &&
          other.name == name &&
          other.limit == limit &&
          other.recipientPatterns == recipientPatterns;

  @override
  int get hashCode =>
      name.hashCode + limit.hashCode + recipientPatterns.hashCode;

  factory ExpenseCategoryResponse.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
