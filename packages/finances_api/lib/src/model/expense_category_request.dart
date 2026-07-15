//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_category_recipient_pattern_request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryRequest {
  /// Returns a new [ExpenseCategoryRequest] instance.
  ExpenseCategoryRequest({
    required this.name,

    required this.limit,

    this.recipientPatterns,
  });

  /// Categoría principal del gasto.
  @JsonKey(name: r'name', required: true, includeIfNull: false)
  final String name;

  /// Monto del gasto. Debe ser mayor a cero.
  @JsonKey(name: r'limit', required: true, includeIfNull: false)
  final String limit;

  @JsonKey(name: r'recipientPatterns', required: false, includeIfNull: false)
  final List<ExpenseCategoryRecipientPatternRequest>? recipientPatterns;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryRequest &&
          other.name == name &&
          other.limit == limit &&
          other.recipientPatterns == recipientPatterns;

  @override
  int get hashCode =>
      name.hashCode + limit.hashCode + recipientPatterns.hashCode;

  factory ExpenseCategoryRequest.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryRequestFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
