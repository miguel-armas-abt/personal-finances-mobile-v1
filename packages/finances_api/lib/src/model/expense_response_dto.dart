//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_response_detail.dart';
import 'package:finances_api/src/model/expense_response_date.dart';
import 'package:finances_api/src/model/expense_response_currency.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_response_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseResponseDto {
  /// Returns a new [ExpenseResponseDto] instance.
  ExpenseResponseDto({
    this.id,

    this.gmailMessageId,

    this.date,

    this.detail,

    this.currency,

    this.amount,
  });

  /// Identificador único del gasto.
  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final String? id;

  /// Identificador del mensaje de Gmail asociado al gasto, si existe.
  @JsonKey(name: r'gmailMessageId', required: false, includeIfNull: false)
  final String? gmailMessageId;

  @JsonKey(name: r'date', required: false, includeIfNull: false)
  final ExpenseResponseDate? date;

  @JsonKey(name: r'detail', required: false, includeIfNull: false)
  final ExpenseResponseDetail? detail;

  @JsonKey(name: r'currency', required: false, includeIfNull: false)
  final ExpenseResponseCurrency? currency;

  /// Monto del gasto. Debe ser mayor a cero.
  @JsonKey(name: r'amount', required: false, includeIfNull: false)
  final String? amount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseResponseDto &&
          other.id == id &&
          other.gmailMessageId == gmailMessageId &&
          other.date == date &&
          other.detail == detail &&
          other.currency == currency &&
          other.amount == amount;

  @override
  int get hashCode =>
      id.hashCode +
      gmailMessageId.hashCode +
      date.hashCode +
      detail.hashCode +
      currency.hashCode +
      amount.hashCode;

  factory ExpenseResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
