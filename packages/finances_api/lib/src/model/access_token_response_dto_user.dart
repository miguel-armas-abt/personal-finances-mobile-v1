//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'access_token_response_dto_user.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class AccessTokenResponseDtoUser {
  /// Returns a new [AccessTokenResponseDtoUser] instance.
  AccessTokenResponseDtoUser({
    this.id,

    this.email,

    this.fullName,

    this.pictureUrl,

    this.plan,

    this.gmailConnected,
  });

  /// ID de usuario en base de datos.
  @JsonKey(name: r'id', required: false, includeIfNull: false)
  final String? id;

  /// Dirección de correo electrónico Gmail.
  @JsonKey(name: r'email', required: false, includeIfNull: false)
  final String? email;

  /// Nombre de usuario.
  @JsonKey(name: r'fullName', required: false, includeIfNull: false)
  final String? fullName;

  /// URL de imagen de usuario.
  @JsonKey(name: r'pictureUrl', required: false, includeIfNull: false)
  final String? pictureUrl;

  /// Tipo de plan adquirido por el usuario.
  @JsonKey(name: r'plan', required: false, includeIfNull: false)
  final String? plan;

  /// Flag que indica si el usuario se ha conectado mediante OpenID Connect.
  @JsonKey(name: r'gmailConnected', required: false, includeIfNull: false)
  final bool? gmailConnected;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is AccessTokenResponseDtoUser &&
          other.id == id &&
          other.email == email &&
          other.fullName == fullName &&
          other.pictureUrl == pictureUrl &&
          other.plan == plan &&
          other.gmailConnected == gmailConnected;

  @override
  int get hashCode =>
      id.hashCode +
      email.hashCode +
      fullName.hashCode +
      pictureUrl.hashCode +
      plan.hashCode +
      gmailConnected.hashCode;

  factory AccessTokenResponseDtoUser.fromJson(Map<String, dynamic> json) =>
      _$AccessTokenResponseDtoUserFromJson(json);

  Map<String, dynamic> toJson() => _$AccessTokenResponseDtoUserToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
