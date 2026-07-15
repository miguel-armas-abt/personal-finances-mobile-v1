// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_response_dto_user.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccessTokenResponseDtoUserCWProxy {
  AccessTokenResponseDtoUser id(String? id);

  AccessTokenResponseDtoUser email(String? email);

  AccessTokenResponseDtoUser fullName(String? fullName);

  AccessTokenResponseDtoUser pictureUrl(String? pictureUrl);

  AccessTokenResponseDtoUser plan(String? plan);

  AccessTokenResponseDtoUser gmailConnected(bool? gmailConnected);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccessTokenResponseDtoUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccessTokenResponseDtoUser(...).copyWith(id: 12, name: "My name")
  /// ````
  AccessTokenResponseDtoUser call({
    String? id,
    String? email,
    String? fullName,
    String? pictureUrl,
    String? plan,
    bool? gmailConnected,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAccessTokenResponseDtoUser.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAccessTokenResponseDtoUser.copyWith.fieldName(...)`
class _$AccessTokenResponseDtoUserCWProxyImpl
    implements _$AccessTokenResponseDtoUserCWProxy {
  const _$AccessTokenResponseDtoUserCWProxyImpl(this._value);

  final AccessTokenResponseDtoUser _value;

  @override
  AccessTokenResponseDtoUser id(String? id) => this(id: id);

  @override
  AccessTokenResponseDtoUser email(String? email) => this(email: email);

  @override
  AccessTokenResponseDtoUser fullName(String? fullName) =>
      this(fullName: fullName);

  @override
  AccessTokenResponseDtoUser pictureUrl(String? pictureUrl) =>
      this(pictureUrl: pictureUrl);

  @override
  AccessTokenResponseDtoUser plan(String? plan) => this(plan: plan);

  @override
  AccessTokenResponseDtoUser gmailConnected(bool? gmailConnected) =>
      this(gmailConnected: gmailConnected);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccessTokenResponseDtoUser(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccessTokenResponseDtoUser(...).copyWith(id: 12, name: "My name")
  /// ````
  AccessTokenResponseDtoUser call({
    Object? id = const $CopyWithPlaceholder(),
    Object? email = const $CopyWithPlaceholder(),
    Object? fullName = const $CopyWithPlaceholder(),
    Object? pictureUrl = const $CopyWithPlaceholder(),
    Object? plan = const $CopyWithPlaceholder(),
    Object? gmailConnected = const $CopyWithPlaceholder(),
  }) {
    return AccessTokenResponseDtoUser(
      id: id == const $CopyWithPlaceholder()
          ? _value.id
          // ignore: cast_nullable_to_non_nullable
          : id as String?,
      email: email == const $CopyWithPlaceholder()
          ? _value.email
          // ignore: cast_nullable_to_non_nullable
          : email as String?,
      fullName: fullName == const $CopyWithPlaceholder()
          ? _value.fullName
          // ignore: cast_nullable_to_non_nullable
          : fullName as String?,
      pictureUrl: pictureUrl == const $CopyWithPlaceholder()
          ? _value.pictureUrl
          // ignore: cast_nullable_to_non_nullable
          : pictureUrl as String?,
      plan: plan == const $CopyWithPlaceholder()
          ? _value.plan
          // ignore: cast_nullable_to_non_nullable
          : plan as String?,
      gmailConnected: gmailConnected == const $CopyWithPlaceholder()
          ? _value.gmailConnected
          // ignore: cast_nullable_to_non_nullable
          : gmailConnected as bool?,
    );
  }
}

extension $AccessTokenResponseDtoUserCopyWith on AccessTokenResponseDtoUser {
  /// Returns a callable class that can be used as follows: `instanceOfAccessTokenResponseDtoUser.copyWith(...)` or like so:`instanceOfAccessTokenResponseDtoUser.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccessTokenResponseDtoUserCWProxy get copyWith =>
      _$AccessTokenResponseDtoUserCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenResponseDtoUser _$AccessTokenResponseDtoUserFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AccessTokenResponseDtoUser', json, ($checkedConvert) {
  final val = AccessTokenResponseDtoUser(
    id: $checkedConvert('id', (v) => v as String?),
    email: $checkedConvert('email', (v) => v as String?),
    fullName: $checkedConvert('fullName', (v) => v as String?),
    pictureUrl: $checkedConvert('pictureUrl', (v) => v as String?),
    plan: $checkedConvert('plan', (v) => v as String?),
    gmailConnected: $checkedConvert('gmailConnected', (v) => v as bool?),
  );
  return val;
});

Map<String, dynamic> _$AccessTokenResponseDtoUserToJson(
  AccessTokenResponseDtoUser instance,
) => <String, dynamic>{
  'id': ?instance.id,
  'email': ?instance.email,
  'fullName': ?instance.fullName,
  'pictureUrl': ?instance.pictureUrl,
  'plan': ?instance.plan,
  'gmailConnected': ?instance.gmailConnected,
};
