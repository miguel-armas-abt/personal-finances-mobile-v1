//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'refresh_token_request_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class RefreshTokenRequestDto {
  /// Returns a new [RefreshTokenRequestDto] instance.
  RefreshTokenRequestDto({required this.refreshToken});

  /// Refresh token vigente de la sesion.
  @JsonKey(name: r'refreshToken', required: true, includeIfNull: false)
  final String refreshToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is RefreshTokenRequestDto && other.refreshToken == refreshToken;

  @override
  int get hashCode => refreshToken.hashCode;

  factory RefreshTokenRequestDto.fromJson(Map<String, dynamic> json) =>
      _$RefreshTokenRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$RefreshTokenRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
