//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_updated_response_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseUpdatedResponseDto {
  /// Returns a new [ExpenseUpdatedResponseDto] instance.
  ExpenseUpdatedResponseDto({this.ids});

  /// Lista de identificadores de gastos actualizados.
  @JsonKey(name: r'ids', required: false, includeIfNull: false)
  final List<String>? ids;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseUpdatedResponseDto && other.ids == ids;

  @override
  int get hashCode => ids.hashCode;

  factory ExpenseUpdatedResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseUpdatedResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseUpdatedResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
