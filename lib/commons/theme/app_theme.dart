import 'package:flutter/material.dart';

class AppTheme {
  const AppTheme._();

  static const ink = Color(0xFF161A35);
  static const muted = Color(0xFF535E7B);
  static const background = Color(0xFFF2F4FB);
  static const primary = Color(0xFF3730B4);
  static const navy = Color(0xFF222054);
  static const lavender = Color(0xFFEBE9FF);
  static const mint = Color(0xFFDCF7EB);
  static const green = Color(0xFF086348);
  static const pink = Color(0xFFFCE4E7);
  static const red = Color(0xFF9B2443);
  static const sky = Color(0xFFDDEEFF);
  static const blue = Color(0xFF275D9A);
  static const sand = Color(0xFFFFF0D5);
  static const amber = Color(0xFF80520F);
  static const line = Color(0xFFDDE2F0);
  static const night = Color(0xFF090817);
  static const nightSurface = Color(0xFF171625);
  static const nightRaised = Color(0xFF222132);
  static const nightMuted = Color(0xFFA6A4BA);
  static const nightAccent = Color(0xFF635BFF);
  static const nightBlue = Color(0xFF4D79FF);
  static const expenseAccent = Color(0xFFFF6B70);
  static const categoryGold = Color(0xFFEDC65A);
  static const categoryMint = Color(0xFF53D9AC);

  static const pagePadding = EdgeInsets.symmetric(horizontal: 24);
  static const cardRadius = BorderRadius.all(Radius.circular(20));
  static const controlRadius = BorderRadius.all(Radius.circular(14));

  static ThemeData light() => _base(
    ColorScheme.fromSeed(seedColor: primary).copyWith(
      primary: primary,
      onPrimary: Colors.white,
      primaryContainer: lavender,
      onPrimaryContainer: primary,
      secondaryContainer: mint,
      onSecondaryContainer: green,
      surface: Colors.white,
      onSurface: ink,
      onSurfaceVariant: muted,
      error: red,
      errorContainer: pink,
      onErrorContainer: red,
      outlineVariant: line,
    ),
    background,
  );

  static ThemeData dark() => _base(
    ColorScheme.fromSeed(
      seedColor: nightAccent,
      brightness: Brightness.dark,
    ).copyWith(
      primary: nightAccent,
      onPrimary: Colors.white,
      primaryContainer: const Color(0xFF29264E),
      onPrimaryContainer: const Color(0xFFC4C1FF),
      secondary: categoryMint,
      surface: nightSurface,
      onSurface: const Color(0xFFF7F6FC),
      onSurfaceVariant: nightMuted,
      outlineVariant: const Color(0xFF343249),
      error: expenseAccent,
    ),
    night,
  );

  static ThemeData _base(ColorScheme colors, Color canvas) {
    final theme = ThemeData(
      colorScheme: colors,
      scaffoldBackgroundColor: canvas,
      fontFamily: 'Inter',
      useMaterial3: true,
    );
    final text = theme.textTheme
        .copyWith(
          headlineLarge: TextStyle(
            color: colors.onSurface,
            fontSize: 39,
            fontWeight: FontWeight.w800,
            height: 1.15,
          ),
          headlineSmall: TextStyle(
            color: colors.onSurface,
            fontSize: 27,
            fontWeight: FontWeight.w800,
            height: 1.2,
          ),
          titleLarge: TextStyle(
            color: colors.onSurface,
            fontSize: 20,
            fontWeight: FontWeight.w800,
          ),
          titleMedium: TextStyle(
            color: colors.onSurface,
            fontSize: 14,
            fontWeight: FontWeight.w700,
          ),
          bodyMedium: TextStyle(
            fontSize: 13,
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
          bodySmall: TextStyle(
            fontSize: 11,
            color: colors.onSurfaceVariant,
            fontWeight: FontWeight.w500,
          ),
        )
        .apply(fontFamily: 'Inter');
    const shape = RoundedRectangleBorder(borderRadius: controlRadius);
    final buttonStyle = ButtonStyle(
      alignment: Alignment.centerLeft,
      minimumSize: const WidgetStatePropertyAll(Size(0, 48)),
      shape: const WidgetStatePropertyAll(shape),
      textStyle: const WidgetStatePropertyAll(
        TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
      ),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      ),
    );
    final border = OutlineInputBorder(
      borderRadius: controlRadius,
      borderSide: BorderSide.none,
    );

    return theme.copyWith(
      textTheme: text,
      appBarTheme: AppBarTheme(
        centerTitle: false,
        backgroundColor: canvas,
        surfaceTintColor: Colors.transparent,
        scrolledUnderElevation: 0,
        titleSpacing: 24,
        titleTextStyle: text.headlineSmall?.copyWith(color: colors.onSurface),
      ),
      cardTheme: CardThemeData(
        color: colors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: const RoundedRectangleBorder(borderRadius: cardRadius),
        clipBehavior: Clip.antiAlias,
      ),
      filledButtonTheme: FilledButtonThemeData(style: buttonStyle),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: buttonStyle.copyWith(
          backgroundColor: WidgetStatePropertyAll(colors.surface),
          side: const WidgetStatePropertyAll(BorderSide.none),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: colors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 14,
          vertical: 18,
        ),
        border: border,
        enabledBorder: border,
        focusedBorder: border.copyWith(
          borderSide: BorderSide(color: colors.primary, width: 2),
        ),
        errorBorder: border.copyWith(
          borderSide: BorderSide(color: colors.error),
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: colors.surface,
        shape: const RoundedRectangleBorder(borderRadius: cardRadius),
      ),
    );
  }
}
