import 'package:finances_api/src/model/access_token_response_dto.dart';
import 'package:finances_api/src/model/access_token_response_dto_user.dart';
import 'package:finances_api/src/model/error_dto.dart';
import 'package:finances_api/src/model/expense_category_assignment_request_dto.dart';
import 'package:finances_api/src/model/expense_category_currency.dart';
import 'package:finances_api/src/model/expense_category_limit.dart';
import 'package:finances_api/src/model/expense_category_recipient_pattern_request.dart';
import 'package:finances_api/src/model/expense_category_recipient_pattern_response.dart';
import 'package:finances_api/src/model/expense_category_request.dart';
import 'package:finances_api/src/model/expense_category_request_dto.dart';
import 'package:finances_api/src/model/expense_category_response.dart';
import 'package:finances_api/src/model/expense_category_response_dto.dart';
import 'package:finances_api/src/model/expense_refresh_response_dto.dart';
import 'package:finances_api/src/model/expense_response_currency.dart';
import 'package:finances_api/src/model/expense_response_date.dart';
import 'package:finances_api/src/model/expense_response_detail.dart';
import 'package:finances_api/src/model/expense_response_dto.dart';
import 'package:finances_api/src/model/expense_save_detail.dart';
import 'package:finances_api/src/model/expense_save_request_dto.dart';
import 'package:finances_api/src/model/expense_save_response_dto.dart';
import 'package:finances_api/src/model/expense_search_response_dto.dart';
import 'package:finances_api/src/model/expense_update_detail.dart';
import 'package:finances_api/src/model/expense_update_request_dto.dart';
import 'package:finances_api/src/model/expense_updated_response_dto.dart';
import 'package:finances_api/src/model/refresh_token_request_dto.dart';
import 'package:finances_api/src/model/sign_in_request_dto.dart';

final _regList = RegExp(r'^List<(.*)>$');
final _regSet = RegExp(r'^Set<(.*)>$');
final _regMap = RegExp(r'^Map<String,(.*)>$');

ReturnType deserialize<ReturnType, BaseType>(
  dynamic value,
  String targetType, {
  bool growable = true,
}) {
  switch (targetType) {
    case 'String':
      return '$value' as ReturnType;
    case 'int':
      return (value is int ? value : int.parse('$value')) as ReturnType;
    case 'bool':
      if (value is bool) {
        return value as ReturnType;
      }
      final valueString = '$value'.toLowerCase();
      return (valueString == 'true' || valueString == '1') as ReturnType;
    case 'double':
      return (value is double ? value : double.parse('$value')) as ReturnType;
    case 'AccessTokenResponseDto':
      return AccessTokenResponseDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'AccessTokenResponseDtoUser':
      return AccessTokenResponseDtoUser.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ErrorDto':
      return ErrorDto.fromJson(value as Map<String, dynamic>) as ReturnType;
    case 'ErrorOrigin':
    case 'ExpenseCategoryAssignmentRequestDto':
      return ExpenseCategoryAssignmentRequestDto.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'ExpenseCategoryCurrency':
      return ExpenseCategoryCurrency.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseCategoryLimit':
      return ExpenseCategoryLimit.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseCategoryRecipientPatternRequest':
      return ExpenseCategoryRecipientPatternRequest.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'ExpenseCategoryRecipientPatternResponse':
      return ExpenseCategoryRecipientPatternResponse.fromJson(
            value as Map<String, dynamic>,
          )
          as ReturnType;
    case 'ExpenseCategoryRequest':
      return ExpenseCategoryRequest.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseCategoryRequestDto':
      return ExpenseCategoryRequestDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseCategoryResponse':
      return ExpenseCategoryResponse.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseCategoryResponseDto':
      return ExpenseCategoryResponseDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseRefreshResponseDto':
      return ExpenseRefreshResponseDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseResponseCurrency':
      return ExpenseResponseCurrency.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseResponseDate':
      return ExpenseResponseDate.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseResponseDetail':
      return ExpenseResponseDetail.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseResponseDto':
      return ExpenseResponseDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseSaveDetail':
      return ExpenseSaveDetail.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseSaveRequestDto':
      return ExpenseSaveRequestDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseSaveResponseDto':
      return ExpenseSaveResponseDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseSearchResponseDto':
      return ExpenseSearchResponseDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseUpdateDetail':
      return ExpenseUpdateDetail.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseUpdateRequestDto':
      return ExpenseUpdateRequestDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'ExpenseUpdatedResponseDto':
      return ExpenseUpdatedResponseDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'RefreshTokenRequestDto':
      return RefreshTokenRequestDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    case 'SignInRequestDto':
      return SignInRequestDto.fromJson(value as Map<String, dynamic>)
          as ReturnType;
    default:
      RegExpMatch? match;

      if (value is List && (match = _regList.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toList(growable: growable)
            as ReturnType;
      }
      if (value is Set && (match = _regSet.firstMatch(targetType)) != null) {
        targetType = match![1]!; // ignore: parameter_assignments
        return value
                .map<BaseType>(
                  (dynamic v) => deserialize<BaseType, BaseType>(
                    v,
                    targetType,
                    growable: growable,
                  ),
                )
                .toSet()
            as ReturnType;
      }
      if (value is Map && (match = _regMap.firstMatch(targetType)) != null) {
        targetType = match![1]!.trim(); // ignore: parameter_assignments
        return Map<String, BaseType>.fromIterables(
              value.keys as Iterable<String>,
              value.values.map(
                (dynamic v) => deserialize<BaseType, BaseType>(
                  v,
                  targetType,
                  growable: growable,
                ),
              ),
            )
            as ReturnType;
      }
      break;
  }
  throw Exception('Cannot deserialize');
}
