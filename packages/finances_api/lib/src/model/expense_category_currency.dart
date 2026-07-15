//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_currency.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryCurrency {
  /// Returns a new [ExpenseCategoryCurrency] instance.
  ExpenseCategoryCurrency({this.code, this.symbol});

  /// Código de moneda del gasto.
  @JsonKey(name: r'code', required: false, includeIfNull: false)
  final String? code;

  @JsonKey(name: r'symbol', required: false, includeIfNull: false)
  final String? symbol;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryCurrency &&
          other.code == code &&
          other.symbol == symbol;

  @override
  int get hashCode => code.hashCode + symbol.hashCode;

  factory ExpenseCategoryCurrency.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryCurrencyToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
