//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_limit.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryLimit {
  /// Returns a new [ExpenseCategoryLimit] instance.
  ExpenseCategoryLimit({this.amount, this.isExceeded, this.balance});

  /// Monto del gasto. Debe ser mayor a cero.
  @JsonKey(name: r'amount', required: false, includeIfNull: false)
  final String? amount;

  /// Indica si el límite fue excedido.
  @JsonKey(name: r'isExceeded', required: false, includeIfNull: false)
  final bool? isExceeded;

  /// Monto decimal.
  @JsonKey(name: r'balance', required: false, includeIfNull: false)
  final String? balance;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryLimit &&
          other.amount == amount &&
          other.isExceeded == isExceeded &&
          other.balance == balance;

  @override
  int get hashCode => amount.hashCode + isExceeded.hashCode + balance.hashCode;

  factory ExpenseCategoryLimit.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryLimitFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryLimitToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
