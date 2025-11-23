// appTheme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/constants/my_string.dart';

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  // Helper method to check if current context is mobile
  static bool _isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  // Responsive text scale factors
  static double _responsiveTextScale(
    BuildContext context, {
    double mobile = 1.0,
    double desktop = 1.2,
  }) {
    return _isMobile(context) ? mobile : desktop;
  }

  // Responsive spacing
  static double _responsiveSpacing(
    BuildContext context, {
    double mobile = 1.0,
    double desktop = 1.5,
  }) {
    return _isMobile(context) ? mobile : desktop;
  }

  static ThemeData light(BuildContext context) => ThemeData(
    useMaterial3: true,
    visualDensity: visualDensity,
    primaryColor: MyColor.primary,
    scaffoldBackgroundColor: MyColor.surface,
    cardColor: MyColor.surfaceContainer,
    iconTheme: IconThemeData(
      color: MyColor.onSurfaceVariant,
      size: _isMobile(context) ? 20.w : 24.w,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColor.onSurfaceVariant,
        size: _isMobile(context) ? 20.w : 24.w,
      ),
      backgroundColor: MyColor.surface,
      titleTextStyle: TextStyle(
        color: MyColor.white,
        fontSize: _isMobile(context) ? 16.sp : 18.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
      toolbarHeight: _isMobile(context) ? 56.h : 64.h,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.light,
      primary: MyColor.primary,
      onPrimary: MyColor.onPrimary,
      primaryContainer: MyColor.primaryContainer,
      onPrimaryContainer: MyColor.onPrimaryContainer,
      secondary: MyColor.secondary,
      onSecondary: MyColor.onSecondary,
      secondaryContainer: MyColor.secondaryContainer,
      onSecondaryContainer: MyColor.onSecondaryContainer,
      tertiary: MyColor.secondary,
      onTertiary: MyColor.onSecondary,
      tertiaryContainer: MyColor.secondaryContainer,
      onTertiaryContainer: MyColor.onSecondaryContainer,
      error: MyColor.error,
      onError: MyColor.onPrimary,
      errorContainer: MyColor.errorContainer,
      onErrorContainer: MyColor.onErrorContainer,
      surface: MyColor.surface,
      onSurface: MyColor.onSurface,
      surfaceContainerHighest: MyColor.surfaceContainerHigh,
      onSurfaceVariant: MyColor.onSurfaceVariant,
      outline: MyColor.outline,
      outlineVariant: MyColor.outlineVariant,
      shadow: MyColor.black,
      scrim: MyColor.black,
      inverseSurface: MyColor.darkSurface,
      onInverseSurface: MyColor.darkOnSurface,
      inversePrimary: MyColor.primaryFixedDim,
      surfaceTint: MyColor.primary,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 32.sp : 40.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 28.sp : 36.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 24.sp : 32.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 20.sp : 24.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: MyColor.onSurface,
        fontSize:
            (_isMobile(context) ? 16.sp : 18.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize:
            (_isMobile(context) ? 16.sp : 18.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.onSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.onSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize:
            (_isMobile(context) ? 10.sp : 12.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize:
            (_isMobile(context) ? 12.sp : 14.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize:
            (_isMobile(context) ? 10.sp : 12.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.outline,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.outline,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      filled: true,
      prefixIconColor: MyColor.outline,
      fillColor: MyColor.surfaceContainerLowest,
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
        horizontal:
            18.w * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.primary, width: 1.5.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.outlineVariant, width: 1.0.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.error, width: 1.5.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.error, width: 1.5.w),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical:
                16.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
            horizontal:
                24.w * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(MyColor.primary),
        foregroundColor: WidgetStateProperty.all(MyColor.onPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize:
                (_isMobile(context) ? 16.sp : 18.sp) *
                _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all(
          Size(
            _isMobile(context) ? 100.w : 120.w,
            _isMobile(context) ? 44.h : 52.h,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(MyColor.primary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize:
                (_isMobile(context) ? 14.sp : 16.sp) *
                _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical:
                8.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
            horizontal:
                16.w * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
          ),
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: MyColor.outlineVariant,
      thickness: 1.0.w,
      space: 1.0.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.5),
    ),
  );

  /// Dark theme and its settings.
  static ThemeData dark(BuildContext context) => ThemeData.dark().copyWith(
    visualDensity: visualDensity,
    primaryColor: MyColor.primary,
    scaffoldBackgroundColor: MyColor.darkSurface,
    cardColor: MyColor.darkSurfaceContainer,
    iconTheme: IconThemeData(
      color: MyColor.darkOnSurfaceVariant,
      size: _isMobile(context) ? 20.w : 24.w,
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColor.darkOnSurfaceVariant,
        size: _isMobile(context) ? 20.w : 24.w,
      ),
      backgroundColor: MyColor.darkSurface,
      titleTextStyle: TextStyle(
        color: MyColor.darkOnSurface,
        fontSize: _isMobile(context) ? 16.sp : 18.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
      toolbarHeight: _isMobile(context) ? 56.h : 64.h,
    ),
    colorScheme: ColorScheme(
      brightness: Brightness.dark,
      primary: MyColor.primary,
      onPrimary: MyColor.onPrimary,
      primaryContainer: MyColor.primaryContainer,
      onPrimaryContainer: MyColor.onPrimaryContainer,
      secondary: MyColor.darkSurfaceContainerHigh,
      onSecondary: MyColor.darkOnSurface,
      secondaryContainer: MyColor.darkSurfaceContainerHigh,
      onSecondaryContainer: MyColor.darkOnSurface,
      tertiary: MyColor.darkSurfaceContainerHigh,
      onTertiary: MyColor.darkOnSurface,
      tertiaryContainer: MyColor.darkSurfaceContainerHigh,
      onTertiaryContainer: MyColor.darkOnSurface,
      error: MyColor.darkError,
      onError: MyColor.onPrimary,
      errorContainer: MyColor.darkErrorContainer,
      onErrorContainer: MyColor.darkOnErrorContainer,
      surface: MyColor.darkSurface,
      onSurface: MyColor.darkOnSurface,
      surfaceContainerHighest: MyColor.darkSurfaceContainerHigh,
      onSurfaceVariant: MyColor.darkOnSurfaceVariant,
      outline: MyColor.darkOutline,
      outlineVariant: MyColor.darkOutlineVariant,
      shadow: MyColor.black,
      scrim: MyColor.black,
      inverseSurface: MyColor.surface,
      onInverseSurface: MyColor.onSurface,
      inversePrimary: MyColor.primaryFixedDim,
      surfaceTint: MyColor.primary,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 32.sp : 40.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 28.sp : 36.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 24.sp : 32.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            (_isMobile(context) ? 20.sp : 24.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: MyColor.darkOnSurface,
        fontSize:
            (_isMobile(context) ? 16.sp : 18.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize:
            (_isMobile(context) ? 16.sp : 18.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOnSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOnSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize:
            (_isMobile(context) ? 12.sp : 14.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize:
            (_isMobile(context) ? 12.sp : 14.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOnSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize:
            (_isMobile(context) ? 10.sp : 12.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOutline,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOnSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize:
            (_isMobile(context) ? 14.sp : 16.sp) *
            _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
        color: MyColor.darkOutline,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      filled: true,
      prefixIconColor: MyColor.darkOutline,
      fillColor: MyColor.darkSurfaceContainer,
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
        horizontal:
            18.w * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.primary, width: 1.5.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.darkOutlineVariant, width: 1.0.w),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.darkError, width: 1.5.w),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.darkError, width: 1.5.w),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical:
                16.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
            horizontal:
                24.w * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(MyColor.primary),
        foregroundColor: WidgetStateProperty.all(MyColor.onPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize:
                (_isMobile(context) ? 16.sp : 18.sp) *
                _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all(
          Size(
            _isMobile(context) ? 100.w : 120.w,
            _isMobile(context) ? 44.h : 52.h,
          ),
        ),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(MyColor.primary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize:
                (_isMobile(context) ? 14.sp : 16.sp) *
                _responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical:
                8.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
            horizontal:
                16.w * _responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
          ),
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: MyColor.darkOutlineVariant,
      thickness: 1.0.w,
      space: 1.0.h * _responsiveSpacing(context, mobile: 1.0, desktop: 1.5),
    ),
  );
}
