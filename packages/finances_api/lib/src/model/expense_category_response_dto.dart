//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_category_currency.dart';
import 'package:finances_api/src/model/expense_category_response.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_response_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryResponseDto {
  /// Returns a new [ExpenseCategoryResponseDto] instance.
  ExpenseCategoryResponseDto({this.currency, this.categories});

  @JsonKey(name: r'currency', required: false, includeIfNull: false)
  final ExpenseCategoryCurrency? currency;

  @JsonKey(name: r'categories', required: false, includeIfNull: false)
  final List<ExpenseCategoryResponse>? categories;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryResponseDto &&
          other.currency == currency &&
          other.categories == categories;

  @override
  int get hashCode => currency.hashCode + categories.hashCode;

  factory ExpenseCategoryResponseDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
