//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:copy_with_extension/copy_with_extension.dart';
import 'package:json_annotation/json_annotation.dart';

part 'sign_in_request_dto.g.dart';

@CopyWith()
@JsonSerializable(
  checked: true,
  createToJson: true,
  disallowUnrecognizedKeys: false,
  explicitToJson: true,
)
class SignInRequestDto {
  /// Returns a new [SignInRequestDto] instance.
  SignInRequestDto({required this.idToken});

  /// idToken generado durante la autenticación OpenId Connect.
  @JsonKey(name: r'idToken', required: true, includeIfNull: false)
  final String idToken;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SignInRequestDto && other.idToken == idToken;

  @override
  int get hashCode => idToken.hashCode;

  factory SignInRequestDto.fromJson(Map<String, dynamic> json) =>
      _$SignInRequestDtoFromJson(json);

  Map<String, dynamic> toJson() => _$SignInRequestDtoToJson(this);

  @override
  String toString() {
    return toJson().toString();
  }
}
