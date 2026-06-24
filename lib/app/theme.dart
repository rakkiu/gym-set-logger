import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppColors {
  static const background = Color(0xFF0F0F0F);
  static const surface = Color(0xFF1A1A1A);
  static const surfacePlus = Color(0xFF252525);
  static const primary = Color(0xFFC8FF00);
  static const primaryDim = Color(0xFF8FB800);
  static const danger = Color(0xFFFF4444);
  static const success = Color(0xFF00E676);
  static const text = Color(0xFFF0F0F0);
  static const textMuted = Color(0xFF888888);
}

class AppTheme {
  static ThemeData get darkTheme {
    final bebas = GoogleFonts.bebasNeue();
    final inter = GoogleFonts.inter();
    final jetBrains = GoogleFonts.jetBrainsMono();

    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: AppColors.background,
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primary,
        secondary: AppColors.primaryDim,
        surface: AppColors.surface,
        error: AppColors.danger,
      ),
      cardTheme: const CardThemeData(
        color: AppColors.surface,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(12)),
        ),
      ),
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        elevation: 0,
        titleTextStyle: bebas.copyWith(
          fontSize: 24,
          color: AppColors.text,
          letterSpacing: 1.2,
        ),
        iconTheme: const IconThemeData(color: AppColors.text),
      ),
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textMuted,
        type: BottomNavigationBarType.fixed,
      ),
      textTheme: TextTheme(
        displayLarge: bebas.copyWith(fontSize: 48, color: AppColors.text),
        displayMedium: bebas.copyWith(fontSize: 36, color: AppColors.text),
        displaySmall: bebas.copyWith(fontSize: 24, color: AppColors.text),
        headlineLarge: bebas.copyWith(fontSize: 22, color: AppColors.text),
        headlineMedium: bebas.copyWith(fontSize: 18, color: AppColors.text),
        bodyLarge: inter.copyWith(fontSize: 16, color: AppColors.text),
        bodyMedium: inter.copyWith(fontSize: 14, color: AppColors.text),
        bodySmall: inter.copyWith(fontSize: 12, color: AppColors.textMuted),
        labelLarge: jetBrains.copyWith(fontSize: 16, color: AppColors.text),
        labelMedium: jetBrains.copyWith(fontSize: 14, color: AppColors.text),
        labelSmall: jetBrains.copyWith(fontSize: 12, color: AppColors.textMuted),
      ),
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.background,
        shape: CircleBorder(),
      ),
    );
  }
}
