//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_response_date.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseResponseDate {
  /// Returns a new [ExpenseResponseDate] instance.
  ExpenseResponseDate({this.utc, this.formatted});

  /// Fecha y hora en UTC.
  @JsonKey(name: r'utc', required: false, includeIfNull: false)
  final DateTime? utc;

  /// Fecha formateada para visualización.
  @JsonKey(name: r'formatted', required: false, includeIfNull: false)
  final String? formatted;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseResponseDate &&
          other.utc == utc &&
          other.formatted == formatted;

  @override
  int get hashCode => utc.hashCode + formatted.hashCode;

  factory ExpenseResponseDate.fromJson(Map<String, dynamic> json) =>
      _$ExpenseResponseDateFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseResponseDateToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
