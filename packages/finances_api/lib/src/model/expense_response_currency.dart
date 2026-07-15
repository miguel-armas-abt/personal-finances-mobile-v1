//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_response_currency.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseResponseCurrency {
  /// Returns a new [ExpenseResponseCurrency] instance.
  ExpenseResponseCurrency({this.code, this.symbol});

  /// Código de la moneda.
  @JsonKey(name: r'code', required: false, includeIfNull: false)
  final String? code;

  /// Símbolo de la moneda.
  @JsonKey(name: r'symbol', required: false, includeIfNull: false)
  final String? symbol;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseResponseCurrency &&
          other.code == code &&
          other.symbol == symbol;

  @override
  int get hashCode => code.hashCode + symbol.hashCode;

  factory ExpenseResponseCurrency.fromJson(Map<String, dynamic> json) =>
      _$ExpenseResponseCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseResponseCurrencyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
