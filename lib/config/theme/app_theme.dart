// ignore_for_file: deprecated_member_use
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/constants/my_string.dart';

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  static ThemeData light() => ThemeData(
    visualDensity: visualDensity,
    primaryColor: MyColor.gray900,
    scaffoldBackgroundColor: MyColor.white,
    cardColor: MyColor.gray100,
    iconTheme: const IconThemeData(color: MyColor.gray800),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: MyColor.gray600, size: 20.w),
      backgroundColor: MyColor.white,
      titleTextStyle: TextStyle(
        color: MyColor.gray900,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme.light(
      primary: MyColor.gray900,
      secondary: MyColor.gray600,
      surface: MyColor.white,
      background: MyColor.white,
      onPrimary: MyColor.white,
      onSecondary: MyColor.white,
      onSurface: MyColor.gray900,
      onBackground: MyColor.gray900,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MyColor.gray900,
        fontFamily: MyString.poppinsMedium,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: MyColor.gray900,
        fontFamily: MyString.poppinsMedium,
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: MyColor.gray900,
        fontFamily: MyString.poppinsMedium,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: MyColor.gray900,
        fontFamily: MyString.poppinsMedium,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: MyColor.gray900,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray900,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: MyColor.gray900,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray900,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 10.sp,
        color: MyColor.gray900,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray600,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize: 12.sp,
        color: MyColor.gray500,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize: 10.sp,
        color: MyColor.gray400,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray600,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray500,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      filled: true,
      prefixIconColor: MyColor.gray500,
      fillColor: MyColor.white,
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.gray900, width: 1.5.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.gray300, width: 1.0.w),
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
          EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        ),
        backgroundColor: WidgetStateProperty.all(MyColor.black),
        foregroundColor: WidgetStateProperty.all(MyColor.white),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        foregroundColor: WidgetStateProperty.all(MyColor.black),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 14.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: MyColor.gray300,
      thickness: 1.0.w,
      space: 1.0.h,
    ),
  );

  /// Dark theme and its settings.
  static ThemeData dark() => ThemeData.dark().copyWith(
    visualDensity: visualDensity,
    primaryColor: MyColor.white,
    scaffoldBackgroundColor: MyColor.gray900,
    cardColor: MyColor.gray800,
    iconTheme: const IconThemeData(color: MyColor.gray300),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(color: MyColor.gray300, size: 20.w),
      backgroundColor: MyColor.gray900,
      titleTextStyle: TextStyle(
        color: MyColor.white,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
    ),
    colorScheme: ColorScheme.dark(
      primary: MyColor.white,
      secondary: MyColor.gray400,
      surface: MyColor.gray800,
      background: MyColor.gray900,
      onPrimary: MyColor.gray900,
      onSecondary: MyColor.gray900,
      onSurface: MyColor.white,
      onBackground: MyColor.white,
    ),
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MyColor.white,
        fontFamily: MyString.poppinsMedium,
        fontSize: 32.sp,
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: MyColor.white,
        fontFamily: MyString.poppinsMedium,
        fontSize: 28.sp,
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: MyColor.white,
        fontFamily: MyString.poppinsMedium,
        fontSize: 24.sp,
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: MyColor.white,
        fontFamily: MyString.poppinsMedium,
        fontSize: 20.sp,
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: MyColor.white,
        fontSize: 16.sp,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray400,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize: 16.sp,
        color: MyColor.gray300,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray400,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize: 12.sp,
        color: MyColor.gray500,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray400,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize: 14.sp,
        color: MyColor.gray500,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      filled: true,
      prefixIconColor: MyColor.gray500,
      fillColor: MyColor.gray800,
      contentPadding: EdgeInsets.symmetric(vertical: 10.h, horizontal: 18.w),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.white, width: 1.5.w),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(7.r)),
        borderSide: BorderSide(color: MyColor.gray700, width: 1.0.w),
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
          EdgeInsets.symmetric(vertical: 16.h, horizontal: 24.w),
        ),
        backgroundColor: WidgetStateProperty.all(MyColor.white),
        foregroundColor: WidgetStateProperty.all(MyColor.black),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize: 16.sp,
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: WidgetStateProperty.all(0),
      ),
    ),

    dividerTheme: DividerThemeData(
      color: MyColor.gray700,
      thickness: 1.0.w,
      space: 1.0.h,
    ),
  );
}
