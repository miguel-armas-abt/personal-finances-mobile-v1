//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_update_detail.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseUpdateDetail {
  /// Returns a new [ExpenseUpdateDetail] instance.
  ExpenseUpdateDetail({
    required this.category,

    required this.comments,

    this.recipient,
  });

  /// Categoría principal del gasto.
  @JsonKey(name: r'category', required: true, includeIfNull: false)
  final String category;

  /// Comentario asociado al gasto.
  @JsonKey(name: r'comments', required: true, includeIfNull: false)
  final String comments;

  /// Texto contenido en destinatario del gasto.
  @JsonKey(name: r'recipient', required: false, includeIfNull: false)
  final String? recipient;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseUpdateDetail &&
          other.category == category &&
          other.comments == comments &&
          other.recipient == recipient;

  @override
  int get hashCode =>
      category.hashCode + comments.hashCode + recipient.hashCode;

  factory ExpenseUpdateDetail.fromJson(Map<String, dynamic> json) =>
      _$ExpenseUpdateDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseUpdateDetailToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
