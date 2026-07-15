//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:finances_api/src/model/access_token_response_dto_user.dart';
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'access_token_response_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccessTokenResponseDto {
  /// Returns a new [AccessTokenResponseDto] instance.
  AccessTokenResponseDto({
    this.accessToken,

    this.refreshToken,

    this.expiresIn,

    this.user,
  });

  @JsonKey(name: r'accessToken', required: false, includeIfNull: false)
  final String? accessToken;

  @JsonKey(name: r'refreshToken', required: false, includeIfNull: false)
  final String? refreshToken;

  @JsonKey(name: r'expiresIn', required: false, includeIfNull: false)
  final num? expiresIn;

  @JsonKey(name: r'user', required: false, includeIfNull: false)
  final AccessTokenResponseDtoUser? user;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessTokenResponseDto &&
          other.accessToken == accessToken &&
          other.refreshToken == refreshToken &&
          other.expiresIn == expiresIn &&
          other.user == user;

  @override
  int get hashCode =>
      accessToken.hashCode +
      refreshToken.hashCode +
      expiresIn.hashCode +
      user.hashCode;

  factory AccessTokenResponseDto.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenResponseDtoFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenResponseDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
