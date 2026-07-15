//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/error_origin.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'error_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class ErrorDto {
  /// Returns a new [ErrorDto] instance.
  ErrorDto({this.origin, this.code, this.message});

  @JsonKey(name: r'origin', required: false, includeIfNull: false)
  final ErrorOrigin? origin;

  /// Código funcional o técnico del error.
  @JsonKey(name: r'code', required: false, includeIfNull: false)
  final String? code;

  /// Descripción del error.
  @JsonKey(name: r'message', required: false, includeIfNull: false)
  final String? message;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is ErrorDto &&
          other.origin == origin &&
          other.code == code &&
          other.message == message;

  @override
  int get hashCode => origin.hashCode + code.hashCode + message.hashCode;

  factory ErrorDto.fromJson(Map<String, dynamic> json) =>
      _$ErrorDtoFromJson(json);

  Map<String, dynamic> toJson() => _$ErrorDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
