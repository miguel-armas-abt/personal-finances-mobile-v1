//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_save_detail.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_save_request_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseSaveRequestDto {
  /// Returns a new [ExpenseSaveRequestDto] instance.
  ExpenseSaveRequestDto({
    required this.userEmail,

    this.gmailMessageId,

    required this.date,

    required this.detail,

    required this.currency,

    required this.amount,
  });

  /// Identificador del usuario en formato de correo electrónico.
  @JsonKey(name: r'userEmail', required: true, includeIfNull: false)
  final String userEmail;

  /// Identificador del mensaje de Gmail asociado al gasto, si existe.
  @JsonKey(name: r'gmailMessageId', required: false, includeIfNull: false)
  final String? gmailMessageId;

  /// Fecha en formato ISO-8601.
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'detail', required: true, includeIfNull: false)
  final ExpenseSaveDetail detail;

  /// Código de moneda del gasto.
  @JsonKey(name: r'currency', required: true, includeIfNull: false)
  final String currency;

  /// Monto del gasto. Debe ser mayor a cero.
  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final String amount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSaveRequestDto &&
          other.userEmail == userEmail &&
          other.gmailMessageId == gmailMessageId &&
          other.date == date &&
          other.detail == detail &&
          other.currency == currency &&
          other.amount == amount;

  @override
  int get hashCode =>
      userEmail.hashCode +
      gmailMessageId.hashCode +
      date.hashCode +
      detail.hashCode +
      currency.hashCode +
      amount.hashCode;

  factory ExpenseSaveRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSaveRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseSaveRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
