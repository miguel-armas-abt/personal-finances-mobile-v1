//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/expense_category_request.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'expense_category_request_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ExpenseCategoryRequestDto {
  /// Returns a new [ExpenseCategoryRequestDto] instance.
  ExpenseCategoryRequestDto({this.currency, this.categories});

  /// Código de moneda del gasto.
  @JsonKey(name: r'currency', required: false, includeIfNull: false)
  final String? currency;

  @JsonKey(name: r'categories', required: false, includeIfNull: false)
  final List<ExpenseCategoryRequest>? categories;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ExpenseCategoryRequestDto &&
          other.currency == currency &&
          other.categories == categories;

  @override
  int get hashCode => currency.hashCode + categories.hashCode;

  factory ExpenseCategoryRequestDto.fromJson(Map<String, dynamic> json) =>
      _$ExpenseCategoryRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ExpenseCategoryRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
