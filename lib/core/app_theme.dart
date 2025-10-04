import 'package:flutter/material.dart';
import 'color.dart';

class AppTheme {
  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: const ColorScheme.dark(
        primary: primary,
        surface: surface,
        onSurface: onSurface,
      ),
      // scaffoldBackgroundColor: AppColors.surface,
      // appBarTheme: const AppBarTheme(
      //   backgroundColor: AppColors.primary,
      //   foregroundColor: AppColors.onSurface,
      // ),
      // textTheme: const TextTheme(
      //   bodyLarge: TextStyle(color: AppColors.onSurface),
      //   bodyMedium: TextStyle(color: AppColors.onSurface),
      // ),
    );
  }
}
