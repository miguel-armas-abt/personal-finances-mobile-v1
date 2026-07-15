// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_request_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$SignInRequestDtoCWProxy {
  SignInRequestDto idToken(String idToken);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInRequestDto call({String idToken});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfSignInRequestDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfSignInRequestDto.copyWith.fieldName(...)`
class _$SignInRequestDtoCWProxyImpl implements _$SignInRequestDtoCWProxy {
  const _$SignInRequestDtoCWProxyImpl(this._value);

  final SignInRequestDto _value;

  @override
  SignInRequestDto idToken(String idToken) => this(idToken: idToken);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `SignInRequestDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// SignInRequestDto(...).copyWith(id: 12, name: "My name")
  /// ````
  SignInRequestDto call({Object? idToken = const $CopyWithPlaceholder()}) {
    return SignInRequestDto(
      idToken: idToken == const $CopyWithPlaceholder()
          ? _value.idToken
          // ignore: cast_nullable_to_non_nullable
          : idToken as String,
    );
  }
}

extension $SignInRequestDtoCopyWith on SignInRequestDto {
  /// Returns a callable class that can be used as follows: `instanceOfSignInRequestDto.copyWith(...)` or like so:`instanceOfSignInRequestDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$SignInRequestDtoCWProxy get copyWith => _$SignInRequestDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInRequestDto _$SignInRequestDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('SignInRequestDto', json, ($checkedConvert) {
      $checkKeys(json, requiredKeys: const ['idToken']);
      final val = SignInRequestDto(
        idToken: $checkedConvert('idToken', (v) => v as String),
      );
      return val;
    });

Map<String, dynamic> _$SignInRequestDtoToJson(SignInRequestDto instance) =>
    <String, dynamic>{'idToken': instance.idToken};
