//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_recipient_pattern_response.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryRecipientPatternResponse {
  /// Returns a new [ExpenseCategoryRecipientPatternResponse] instance.
  ExpenseCategoryRecipientPatternResponse({this.code, this.value});

  /// Tipo de patrón utilizado para identificar destinatarios.
  @JsonKey(name: r'code', required: false, includeIfNull: false)
  final String? code;

  /// Texto incluido en el nombre del beneficiario del gasto. Por ejemplo: 'CIBERTEC INSTIT' → 'CIBERTEC'
  @JsonKey(name: r'value', required: false, includeIfNull: false)
  final String? value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryRecipientPatternResponse &&
          other.code == code &&
          other.value == value;

  @override
  int get hashCode => code.hashCode + value.hashCode;

  factory ExpenseCategoryRecipientPatternResponse.fromJson(
    Map<String, dynamic> json,
  ) => _$ExpenseCategoryRecipientPatternResponseFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ExpenseCategoryRecipientPatternResponseToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
