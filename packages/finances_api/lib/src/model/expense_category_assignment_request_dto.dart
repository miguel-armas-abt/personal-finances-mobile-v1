//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_assignment_request_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryAssignmentRequestDto {
  /// Returns a new [ExpenseCategoryAssignmentRequestDto] instance.
  ExpenseCategoryAssignmentRequestDto({
    this.overwriteExistingCategories = false,

    required this.from,
  });

  /// Indica si se deben recalcular y reemplazar los gastos que ya tienen una categoría asignada.
  @JsonKey(
    defaultValue: false,
    name: r'overwriteExistingCategories',
    required: false,
    includeIfNull: false,
  )
  final bool? overwriteExistingCategories;

  /// Fecha mínima desde la cual se aplicará la actualización de categorías.
  @JsonKey(name: r'from', required: true, includeIfNull: false)
  final DateTime from;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryAssignmentRequestDto &&
          other.overwriteExistingCategories == overwriteExistingCategories &&
          other.from == from;

  @override
  int get hashCode => overwriteExistingCategories.hashCode + from.hashCode;

  factory ExpenseCategoryAssignmentRequestDto.fromJson(
    Map<String, dynamic> json,
  ) => _$ExpenseCategoryAssignmentRequestDtoFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ExpenseCategoryAssignmentRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
