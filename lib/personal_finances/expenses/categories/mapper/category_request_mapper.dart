import 'package:finances_api/finances_api.dart';
import 'package:personal_finances_mobile_v1/commons/network/api_client.dart';
import 'package:personal_finances_mobile_v1/commons/utils/decimal_amount.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/money.dart';
import 'package:personal_finances_mobile_v1/personal_finances/expenses/categories/model/expense_category.dart';

ExpenseCategoryRequestDto toCategorySettingsDto(
  ExpenseCategorySettings settings,
) => ExpenseCategoryRequestDto(
  currency: settings.currency.code,
  categories: settings.categories
      .map(
        (category) => ExpenseCategoryRequest(
          name: category.name.trim(),
          limit: formatMinorUnits(category.limit.amount),
          recipientPatterns: category.recipientPatterns
              .map(
                (pattern) => ExpenseCategoryRecipientPatternRequest(
                  code: pattern.code.code,
                  value: pattern.value.trim(),
                ),
              )
              .toList(growable: false),
        ),
      )
      .toList(growable: false),
);

ExpenseCategorySettings mapCategorySettings(
  ExpenseCategoryResponseDto dto,
) => ExpenseCategorySettings(
  currency: CurrencyCode.fromCode(requireValue(dto.currency?.code, 'currency')),
  categories: List.unmodifiable(
    requireValue(dto.categories, 'categories').map((category) {
      final limit = requireValue(category.limit, 'limit');
      return ExpenseCategory(
        name: requireValue(category.name, 'category name'),
        limit: CategoryLimit(
          amount: parseMinorUnits(requireValue(limit.amount, 'limit amount')),
          isExceeded: requireValue(limit.isExceeded, 'limit status'),
          balance: parseMinorUnits(
            requireValue(limit.balance, 'limit balance'),
          ),
        ),
        recipientPatterns: List.unmodifiable(
          (category.recipientPatterns ?? const []).map(
            (pattern) => RecipientPattern(
              code: RecipientPatternCode.fromCode(
                requireValue(pattern.code, 'pattern code'),
              ),
              value: requireValue(pattern.value, 'pattern value'),
            ),
          ),
        ),
      );
    }),
  ),
);
