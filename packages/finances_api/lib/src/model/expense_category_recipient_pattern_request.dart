//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_recipient_pattern_request.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryRecipientPatternRequest {
  /// Returns a new [ExpenseCategoryRecipientPatternRequest] instance.
  ExpenseCategoryRecipientPatternRequest({
    required this.code,

    required this.value,
  });

  /// Tipo de patrón utilizado para identificar destinatarios.
  @JsonKey(name: r'code', required: true, includeIfNull: false)
  final String code;

  /// Texto incluido en el nombre del beneficiario del gasto. Por ejemplo: 'CIBERTEC INSTIT' → 'CIBERTEC'
  @JsonKey(name: r'value', required: true, includeIfNull: false)
  final String value;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryRecipientPatternRequest &&
          other.code == code &&
          other.value == value;

  @override
  int get hashCode => code.hashCode + value.hashCode;

  factory ExpenseCategoryRecipientPatternRequest.fromJson(
    Map<String, dynamic> json,
  ) => _$ExpenseCategoryRecipientPatternRequestFromJson(json);

  Map<String, dynamic> toJson() =>
      _$ExpenseCategoryRecipientPatternRequestToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
