//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_save_response_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseSaveResponseDto {
  /// Returns a new [ExpenseSaveResponseDto] instance.
  ExpenseSaveResponseDto({this.expenseId});

  /// Identificador único del gasto.
  @JsonKey(name: r'expenseId', required: false, includeIfNull: false)
  final String? expenseId;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSaveResponseDto && other.expenseId == expenseId;

  @override
  int get hashCode => expenseId.hashCode;

  factory ExpenseSaveResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSaveResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseSaveResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
