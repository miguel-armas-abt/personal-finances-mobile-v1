// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'error_dto.dart';

// **************************************************************************
// CopyWithGenerator
// **************************************************************************

abstract class _$ErrorDtoCWProxy {
  ErrorDto origin(ErrorOrigin? origin);

  ErrorDto code(String? code);

  ErrorDto message(String? message);

  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ErrorDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ErrorDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ErrorDto call({ErrorOrigin? origin, String? code, String? message});
}

/// Proxy class for `copyWith` functionality. This is a callable class and can be used as follows: `instanceOfErrorDto.copyWith(...)`. Additionally contains functions for specific fields e.g. `instanceOfErrorDto.copyWith.fieldName(...)`
class _$ErrorDtoCWProxyImpl implements _$ErrorDtoCWProxy {
  const _$ErrorDtoCWProxyImpl(this._value);

  final ErrorDto _value;

  @override
  ErrorDto origin(ErrorOrigin? origin) => this(origin: origin);

  @override
  ErrorDto code(String? code) => this(code: code);

  @override
  ErrorDto message(String? message) => this(message: message);

  @override
  /// This function **does support** nullification of nullable fields. All `null` values passed to `non-nullable` fields will be ignored. You can also use `ErrorDto(...).copyWith.fieldName(...)` to override fields one at a time with nullification support.
  ///
  /// Usage
  /// ```dart
  /// ErrorDto(...).copyWith(id: 12, name: "My name")
  /// ````
  ErrorDto call({
    Object? origin = const $CopyWithPlaceholder(),
    Object? code = const $CopyWithPlaceholder(),
    Object? message = const $CopyWithPlaceholder(),
  }) {
    return ErrorDto(
      origin: origin == const $CopyWithPlaceholder()
          ? _value.origin
          // ignore: cast_nullable_to_non_nullable
          : origin as ErrorOrigin?,
      code: code == const $CopyWithPlaceholder()
          ? _value.code
          // ignore: cast_nullable_to_non_nullable
          : code as String?,
      message: message == const $CopyWithPlaceholder()
          ? _value.message
          // ignore: cast_nullable_to_non_nullable
          : message as String?,
    );
  }
}

extension $ErrorDtoCopyWith on ErrorDto {
  /// Returns a callable class that can be used as follows: `instanceOfErrorDto.copyWith(...)` or like so:`instanceOfErrorDto.copyWith.fieldName(...)`.
  // ignore: library_private_types_in_public_api
  _$ErrorDtoCWProxy get copyWith => _$ErrorDtoCWProxyImpl(this);
}

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ErrorDto _$ErrorDtoFromJson(Map<String, dynamic> json) =>
    $checkedCreate('ErrorDto', json, ($checkedConvert) {
      final val = ErrorDto(
        origin: $checkedConvert(
          'origin',
          (v) => $enumDecodeNullable(_$ErrorOriginEnumMap, v),
        ),
        code: $checkedConvert('code', (v) => v as String?),
        message: $checkedConvert('message', (v) => v as String?),
      );
      return val;
    });

Map<String, dynamic> _$ErrorDtoToJson(ErrorDto instance) => <String, dynamic>{
  'origin': ?_$ErrorOriginEnumMap[instance.origin],
  'code': ?instance.code,
  'message': ?instance.message,
};

const _$ErrorOriginEnumMap = {
  ErrorOrigin.OWN: 'OWN',
  ErrorOrigin.PARTNER: 'PARTNER',
  ErrorOrigin.THIRD_PARTY: 'THIRD_PARTY',
};
