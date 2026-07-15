//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_refresh_response_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseRefreshResponseDto {
  /// Returns a new [ExpenseRefreshResponseDto] instance.
  ExpenseRefreshResponseDto({this.gmailMessageIds});

  /// Lista de identificadores de mensajes Gmail asociados a los gastos guardados durante el proceso de refresco.
  @JsonKey(name: r'gmailMessageIds', required: false, includeIfNull: false)
  final List<String>? gmailMessageIds;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseRefreshResponseDto &&
          other.gmailMessageIds == gmailMessageIds;

  @override
  int get hashCode => gmailMessageIds.hashCode;

  factory ExpenseRefreshResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseRefreshResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseRefreshResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
