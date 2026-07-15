// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'refresh_token_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$RefreshTokenRequestDtoCWProxy {
  RefreshTokenRequestDto refreshToken(String refreshToken);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefreshTokenRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefreshTokenRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  RefreshTokenRequestDto call({String refreshToken});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfRefreshTokenRequestDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfRefreshTokenRequestDto.copyWith.fieldName(...)`
class _$RefreshTokenRequestDtoCWProxyImpl
    implements _$RefreshTokenRequestDtoCWProxy {
  const _$RefreshTokenRequestDtoCWProxyImpl(this._value);

  final RefreshTokenRequestDto _value;

  @override
  RefreshTokenRequestDto refreshToken(String refreshToken) =>
      this(refreshToken: refreshToken);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `RefreshTokenRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// RefreshTokenRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  RefreshTokenRequestDto call({
    Object? refreshToken = const $CopyWithPlaceholder(),
  }) {
    return RefreshTokenRequestDto(
      refreshToken: refreshToken == const $CopyWithPlaceholder()
          ? _value.refreshToken
          // ignore: cast_nullable_to_non_nullable
          : refreshToken as String,
    );
  }
}

extension $RefreshTokenRequestDtoCopyWith on RefreshTokenRequestDto {
  /// Returns a callable class that can be used as follows: `instanceOfRefreshTokenRequestDto.copyWith(...)` or like so:`instanceOfRefreshTokenRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$RefreshTokenRequestDtoCWProxy get copyWith =>
      _$RefreshTokenRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RefreshTokenRequestDto _$RefreshTokenRequestDtoFromJson(
  Map<String, dynamic> json,
) => $checkedCreate('RefreshTokenRequestDto', json, ($checkedConvert) {
  $checkKeys(json, requiredKeys: const ['refreshToken']);
  final val = RefreshTokenRequestDto(
    refreshToken: $checkedConvert('refreshToken', (v) => v as String),
  );
  return val;
});

Map<String, dynamic> _$RefreshTokenRequestDtoToJson(
  RefreshTokenRequestDto instance,
) => <String, dynamic>{'refreshToken': instance.refreshToken};
