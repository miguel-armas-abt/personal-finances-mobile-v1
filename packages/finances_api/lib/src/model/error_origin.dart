//
// AUTO-GENERATED FILE, DO NOT MODIFY!
//

// ignore_for_file: unused_element
import 'package:json_annotation/json_annotation.dart';

/// Origen del error.
enum ErrorOrigin {
  /// Origen del error.
  @JsonValue(r'OWN')
  OWN(r'OWN'),

  /// Origen del error.
  @JsonValue(r'PARTNER')
  PARTNER(r'PARTNER'),

  /// Origen del error.
  @JsonValue(r'THIRD_PARTY')
  THIRD_PARTY(r'THIRD_PARTY');

  const ErrorOrigin(this.value);

  final String value;

  @override
  String toString() => value;
}
