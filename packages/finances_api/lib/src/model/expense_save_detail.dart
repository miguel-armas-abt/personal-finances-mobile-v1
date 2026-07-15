//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_save_detail.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseSaveDetail {
  /// Returns a new [ExpenseSaveDetail] instance.
  ExpenseSaveDetail({
    this.category,

    this.comments,

    this.recipient,

    required this.source_,
  });

  /// Categoría principal del gasto.
  @JsonKey(name: r'category', required: false, includeIfNull: false)
  final String? category;

  /// Comentario asociado al gasto.
  @JsonKey(name: r'comments', required: false, includeIfNull: false)
  final String? comments;

  /// Texto contenido en destinatario del gasto.
  @JsonKey(name: r'recipient', required: false, includeIfNull: false)
  final String? recipient;

  /// Origen o medio desde el cual se generó el gasto.
  @JsonKey(name: r'source', required: true, includeIfNull: false)
  final String source_;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseSaveDetail &&
          other.category == category &&
          other.comments == comments &&
          other.recipient == recipient &&
          other.source_ == source_;

  @override
  int get hashCode =>
      category.hashCode +
      comments.hashCode +
      recipient.hashCode +
      source_.hashCode;

  factory ExpenseSaveDetail.fromJson(Map<String, dynamic> json) =>
      _$ExpenseSaveDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseSaveDetailToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
