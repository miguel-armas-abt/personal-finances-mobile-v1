//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_update_detail.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_update_request_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseUpdateRequestDto {
  /// Returns a new [ExpenseUpdateRequestDto] instance.
  ExpenseUpdateRequestDto({
    required this.date,

    required this.detail,

    required this.currency,

    required this.amount,
  });

  /// Fecha en formato ISO-8601.
  @JsonKey(name: r'date', required: true, includeIfNull: false)
  final String date;

  @JsonKey(name: r'detail', required: true, includeIfNull: false)
  final ExpenseUpdateDetail detail;

  /// Código de moneda del gasto.
  @JsonKey(name: r'currency', required: true, includeIfNull: false)
  final String currency;

  /// Monto del gasto. Debe ser mayor a cero.
  @JsonKey(name: r'amount', required: true, includeIfNull: false)
  final String amount;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseUpdateRequestDto &&
          other.date == date &&
          other.detail == detail &&
          other.currency == currency &&
          other.amount == amount;

  @override
  int get hashCode =>
      date.hashCode + detail.hashCode + currency.hashCode + amount.hashCode;

  factory ExpenseUpdateRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseUpdateRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseUpdateRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
