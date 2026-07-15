//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_response_dto.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_search_response_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseSearchResponseDto {
  /// Returns a new [ExpenseSearchResponseDto] instance.
  ExpenseSearchResponseDto({this.expenses, this.nextCursor});

  /// Lista de gastos encontrados.
  @JsonKey(name: r'expenses', required: false, includeIfNull: false)
  final List<ExpenseResponseDto>? expenses;

  /// Cursor codificado para continuar la paginación.
  @JsonKey(name: r'nextCursor', required: false, includeIfNull: false)
  final String? nextCursor;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSearchResponseDto &&
          other.expenses == expenses &&
          other.nextCursor == nextCursor;

  @override
  int get hashCode => expenses.hashCode + nextCursor.hashCode;

  factory ExpenseSearchResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSearchResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseSearchResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
