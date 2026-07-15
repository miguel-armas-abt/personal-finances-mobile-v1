// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'access_token_response_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$AccessTokenResponseDtoCWProxy {
  AccessTokenResponseDto accessToken(String? accessToken);

  AccessTokenResponseDto refreshToken(String? refreshToken);

  AccessTokenResponseDto expiresIn(num? expiresIn);

  AccessTokenResponseDto user(AccessTokenResponseDtoUser? user);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccessTokenResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccessTokenResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  AccessTokenResponseDto call({
    String? accessToken,
    String? refreshToken,
    num? expiresIn,
    AccessTokenResponseDtoUser? user,
  });
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfAccessTokenResponseDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfAccessTokenResponseDto.copyWith.fieldName(...)`
class _$AccessTokenResponseDtoCWProxyImpl
    implements _$AccessTokenResponseDtoCWProxy {
  const _$AccessTokenResponseDtoCWProxyImpl(this._value);

  final AccessTokenResponseDto _value;

  @override
  AccessTokenResponseDto accessToken(String? accessToken) =>
      this(accessToken: accessToken);

  @override
  AccessTokenResponseDto refreshToken(String? refreshToken) =>
      this(refreshToken: refreshToken);

  @override
  AccessTokenResponseDto expiresIn(num? expiresIn) =>
      this(expiresIn: expiresIn);

  @override
  AccessTokenResponseDto user(AccessTokenResponseDtoUser? user) =>
      this(user: user);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `AccessTokenResponseDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// AccessTokenResponseDto(...).copyWith(id: 12, name: "My name")
  /// ````
  AccessTokenResponseDto call({
    Object? accessToken = const $CopyWithPlaceholder(),
    Object? refreshToken = const $CopyWithPlaceholder(),
    Object? expiresIn = const $CopyWithPlaceholder(),
    Object? user = const $CopyWithPlaceholder(),
  }) {
    return AccessTokenResponseDto(
      accessToken: accessToken == const $CopyWithPlaceholder()
          ? _value.accessToken
          // ignore: cast_nullable_to_non_nullable
          : accessToken as String?,
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String?,
      expiresIn: expiresIn == const $CopyWithPlaceholder()
          ? _value.expiresIn
          // ignore: cast_nullable_to_non_nullable
          : expiresIn as num?,
      user: user == const $CopyWithPlaceholder()
          ? _value.user
          // ignore: cast_nullable_to_non_nullable
          : user as AccessTokenResponseDtoUser?,
    );
  }
}

extension $AccessTokenResponseDtoCopyWith on AccessTokenResponseDto {
  /// Returns a callable class that can be used as follows: `instanceOfAccessTokenResponseDto.copyWith(...)` or like so:`instanceOfAccessTokenResponseDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$AccessTokenResponseDtoCWProxy get copyWith =>
      _$AccessTokenResponseDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AccessTokenResponseDto _$AccessTokenResponseDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('AccessTokenResponseDto', json, ($checkedConvert) {
  final val = AccessTokenResponseDto(
    accessToken: $checkedConvert('accessToken', (v) => v as String?),
    refreshToken: $checkedConvert('refreshToken', (v) => v as String?),
    expiresIn: $checkedConvert('expiresIn', (v) => v as num?),
    user: $checkedConvert(
      'user',
      (v) => v == null
          ? null
          : AccessTokenResponseDtoUser.fromJson(v as Map<String, dynamic>),
    ),
  );
  return val;
});

Map<String, dynamic> _$AccessTokenResponseDtoToJson(
  AccessTokenResponseDto instance,
) => <String, dynamic>{
  'accessToken': ?instance.accessToken,
  'refreshToken': ?instance.refreshToken,
  'expiresIn': ?instance.expiresIn,
  'user': ?instance.user?.toJson(),
};
