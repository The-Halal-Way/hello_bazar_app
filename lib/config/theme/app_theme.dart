// appTheme.dart
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/constants/my_string.dart';

abstract class AppTheme {
  static final visualDensity = VisualDensity.adaptivePlatformDensity;

  static bool isMobile(BuildContext context) {
    return MediaQuery.of(context).size.width < 600;
  }

  static bool isTablet(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return width >= 600 && width < 1750;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1750;
  }

  static double responsiveTextScale(BuildContext context) {
    if (isMobile(context)) return 1.0;
    if (isTablet(context)) return 0.7;
    return 1.2;
  }

  static double responsiveSpacing(BuildContext context) {
    if (isMobile(context)) return 1.0;
    if (isTablet(context)) return 0.6;
    return 1.5;
  }

  static double tabletSizeMultiplier(BuildContext context) {
    if (isTablet(context)) return 0.65;
    return 1.0;
  }

  static double getResponsiveSize(
    BuildContext context,
    double mobileSize,
    double tabletSize,
    double desktopSize,
  ) {
    if (isMobile(context)) return mobileSize;
    if (isTablet(context)) {
      return tabletSize * tabletSizeMultiplier(context);
    }
    return desktopSize;
  }

  static double getResponsiveTextSize(
    BuildContext context,
    double mobileSize,
    double tabletSize,
    double desktopSize,
  ) {
    if (isMobile(context)) return mobileSize;
    if (isTablet(context)) return mobileSize * 0.5;
    return desktopSize;
  }

  static ThemeData light(BuildContext context) => ThemeData(
    useMaterial3: true,
    visualDensity: visualDensity,
    primaryColor: MyColor.primary,
    scaffoldBackgroundColor: MyColor.surface,
    cardColor: MyColor.surfaceContainer,
    iconTheme: IconThemeData(
      color: MyColor.onSurfaceVariant,
      size: getResponsiveSize(context, 20.w, 14.w, 24.w),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      titleSpacing: getResponsiveSize(context, 16.w, 8.w, 24.w),
      centerTitle: isTablet(context) ? true : false,
      iconTheme: IconThemeData(
        color: MyColor.onSurfaceVariant,
        size: getResponsiveSize(context, 20.w, 14.w, 24.w),
      ),
      backgroundColor: MyColor.primary,
      titleTextStyle: TextStyle(
        color: MyColor.onSurface,
        fontSize: getResponsiveTextSize(context, 16.sp, 14.sp, 18.sp),
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
      toolbarHeight: getResponsiveSize(context, 56.h, 70.h, 64.h),
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
            getResponsiveTextSize(context, 32.sp, 28.sp, 40.sp) *
            responsiveTextScale(context),
        fontWeight: FontWeight.w700,
      ),
      displayMedium: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            getResponsiveTextSize(context, 28.sp, 24.sp, 36.sp) *
            responsiveTextScale(context),
        fontWeight: FontWeight.w600,
      ),
      displaySmall: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            getResponsiveTextSize(context, 24.sp, 20.sp, 32.sp) *
            responsiveTextScale(context),
        fontWeight: FontWeight.w600,
      ),
      titleLarge: TextStyle(
        color: MyColor.onSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            getResponsiveTextSize(context, 20.sp, 18.sp, 24.sp) *
            responsiveTextScale(context),
        fontWeight: FontWeight.w600,
      ),
      titleMedium: TextStyle(
        color: MyColor.onSurface,
        fontSize:
            getResponsiveTextSize(context, 16.sp, 14.sp, 18.sp) *
            responsiveTextScale(context),
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      titleSmall: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 14.sp, 12.sp, 16.sp) *
            responsiveTextScale(context),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyLarge: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 16.sp, 14.sp, 18.sp) *
            responsiveTextScale(context),
        color: MyColor.onSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodyMedium: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 14.sp, 12.sp, 16.sp) *
            responsiveTextScale(context),
        color: MyColor.onSurface,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      bodySmall: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 10.sp, 9.sp, 12.sp) *
            responsiveTextScale(context),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.rubikRegular,
        fontWeight: FontWeight.w400,
      ),
      labelLarge: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 14.sp, 12.sp, 16.sp) *
            responsiveTextScale(context),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w500,
      ),
      labelMedium: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 12.sp, 10.sp, 14.sp) *
            responsiveTextScale(context),
        color: MyColor.onSurfaceVariant,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
      labelSmall: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 10.sp, 9.sp, 12.sp) *
            responsiveTextScale(context),
        color: MyColor.outline,
        fontFamily: MyString.poppinsRegular,
        fontWeight: FontWeight.w400,
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 14.sp, 12.sp, 16.sp) *
            responsiveTextScale(context),
        color: MyColor.onSurfaceVariant,
        fontWeight: FontWeight.w400,
      ),
      hintStyle: TextStyle(
        fontSize:
            getResponsiveTextSize(context, 14.sp, 12.sp, 16.sp) *
            responsiveTextScale(context),
        color: MyColor.outline,
        letterSpacing: 1.2,
        fontWeight: FontWeight.w400,
      ),
      isDense: true,
      filled: true,
      prefixIconColor: MyColor.outline,
      fillColor: MyColor.surfaceContainerLowest,
      contentPadding: EdgeInsets.symmetric(
        vertical: 10.h * responsiveSpacing(context),
        horizontal: 18.w * responsiveSpacing(context),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.r * tabletSizeMultiplier(context)),
        ),
        borderSide: BorderSide(
          color: MyColor.primary,
          width: 1.5.w * tabletSizeMultiplier(context),
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.r * tabletSizeMultiplier(context)),
        ),
        borderSide: BorderSide(
          color: MyColor.outlineVariant,
          width: 1.0.w * tabletSizeMultiplier(context),
        ),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.r * tabletSizeMultiplier(context)),
        ),
        borderSide: BorderSide(
          color: MyColor.error,
          width: 1.5.w * tabletSizeMultiplier(context),
        ),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(7.r * tabletSizeMultiplier(context)),
        ),
        borderSide: BorderSide(
          color: MyColor.error,
          width: 1.5.w * tabletSizeMultiplier(context),
        ),
      ),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ButtonStyle(
        shape: WidgetStateProperty.all(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              7.r * tabletSizeMultiplier(context),
            ),
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical: 16.h * responsiveSpacing(context),
            horizontal: 24.w * responsiveSpacing(context),
          ),
        ),
        backgroundColor: WidgetStateProperty.all(MyColor.primary),
        foregroundColor: WidgetStateProperty.all(MyColor.onPrimary),
        textStyle: WidgetStateProperty.all(
          TextStyle(
            fontSize:
                getResponsiveTextSize(context, 16.sp, 14.sp, 18.sp) *
                responsiveTextScale(context),
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w600,
          ),
        ),
        elevation: WidgetStateProperty.all(0),
        minimumSize: WidgetStateProperty.all(
          Size(
            getResponsiveSize(context, 100.w, 70.w, 120.w),
            getResponsiveSize(context, 44.h, 32.h, 52.h),
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
                getResponsiveTextSize(context, 14.sp, 12.sp, 16.sp) *
                responsiveTextScale(context),
            fontFamily: MyString.poppinsMedium,
            fontWeight: FontWeight.w500,
          ),
        ),
        padding: WidgetStateProperty.all(
          EdgeInsets.symmetric(
            vertical: 8.h * responsiveSpacing(context),
            horizontal: 16.w * responsiveSpacing(context),
          ),
        ),
      ),
    ),
    dividerTheme: DividerThemeData(
      color: MyColor.outlineVariant,
      thickness: 1.0.w * tabletSizeMultiplier(context),
      space: 1.0.h * responsiveSpacing(context),
    ),
  );

  static ThemeData dark(BuildContext context) => ThemeData.dark().copyWith(
    visualDensity: visualDensity,
    primaryColor: MyColor.primary,
    scaffoldBackgroundColor: MyColor.darkSurface,
    cardColor: MyColor.darkSurfaceContainer,
    iconTheme: IconThemeData(
      color: MyColor.darkOnSurfaceVariant,
      size: getResponsiveSize(context, 20.w, 14.w, 24.w),
    ),
    appBarTheme: AppBarTheme(
      elevation: 0,
      iconTheme: IconThemeData(
        color: MyColor.darkOnSurfaceVariant,
        size: getResponsiveSize(context, 20.w, 14.w, 24.w),
      ),
      backgroundColor: MyColor.darkSurface,
      titleTextStyle: TextStyle(
        color: MyColor.darkOnSurface,
        fontSize: getResponsiveTextSize(context, 16.sp, 14.sp, 18.sp),
        fontFamily: MyString.poppinsMedium,
        fontWeight: FontWeight.w600,
      ),
      toolbarHeight: getResponsiveSize(context, 56.h, 40.h, 64.h),
    ),
    // ... apply same responsive patterns for the rest of dark theme
    // Make sure to use getResponsiveTextSize for all text
    // and responsiveSpacing/tabletSizeMultiplier for spacing/sizes
    textTheme: TextTheme(
      displayLarge: TextStyle(
        color: MyColor.darkOnSurface,
        fontFamily: MyString.poppinsMedium,
        fontSize:
            getResponsiveTextSize(context, 32.sp, 28.sp, 40.sp) *
            responsiveTextScale(context),
        fontWeight: FontWeight.w700,
      ),
      // ... copy all text styles from light theme but with dark colors
    ),
    // ... copy other theme properties from light theme with same responsive adjustments
  );
}

// // appTheme.dart
// import 'package:flutter/material.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:hello_bazar/core/constants/my_color.dart';
// import 'package:hello_bazar/core/constants/my_string.dart';

// abstract class AppTheme {
//   static final visualDensity = VisualDensity.adaptivePlatformDensity;

//   // Helper method to check if current context is mobile
//   static bool isMobile(BuildContext context) {
//     return MediaQuery.of(context).size.width < 600;
//   }

//   // Responsive text scale factors
//   static double responsiveTextScale(
//     BuildContext context, {
//     double mobile = 1.0,
//     double desktop = 1.2,
//   }) {
//     return isMobile(context) ? mobile : desktop;
//   }

//   // Responsive spacing
//   static double responsiveSpacing(
//     BuildContext context, {
//     double mobile = 1.0,
//     double desktop = 1.5,
//   }) {
//     return isMobile(context) ? mobile : desktop;
//   }

//   static ThemeData light(BuildContext context) => ThemeData(
//     useMaterial3: true,
//     visualDensity: visualDensity,
//     primaryColor: MyColor.primary,
//     scaffoldBackgroundColor: MyColor.surface,
//     cardColor: MyColor.surfaceContainer,
//     iconTheme: IconThemeData(
//       color: MyColor.onSurfaceVariant,
//       size: isMobile(context) ? 20.w : 24.w,
//     ),
//     appBarTheme: AppBarTheme(
//       elevation: 0,
//       iconTheme: IconThemeData(
//         color: MyColor.onSurfaceVariant,
//         size: isMobile(context) ? 20.w : 24.w,
//       ),
//       backgroundColor: MyColor.surface,
//       titleTextStyle: TextStyle(
//         color: MyColor.onSurface,
//         fontSize: isMobile(context) ? 16.sp : 18.sp,
//         fontFamily: MyString.poppinsMedium,
//         fontWeight: FontWeight.w600,
//       ),
//       toolbarHeight: isMobile(context) ? 56.h : 64.h,
//     ),
//     colorScheme: ColorScheme(
//       brightness: Brightness.light,
//       primary: MyColor.primary,
//       onPrimary: MyColor.onPrimary,
//       primaryContainer: MyColor.primaryContainer,
//       onPrimaryContainer: MyColor.onPrimaryContainer,
//       secondary: MyColor.secondary,
//       onSecondary: MyColor.onSecondary,
//       secondaryContainer: MyColor.secondaryContainer,
//       onSecondaryContainer: MyColor.onSecondaryContainer,
//       tertiary: MyColor.secondary,
//       onTertiary: MyColor.onSecondary,
//       tertiaryContainer: MyColor.secondaryContainer,
//       onTertiaryContainer: MyColor.onSecondaryContainer,
//       error: MyColor.error,
//       onError: MyColor.onPrimary,
//       errorContainer: MyColor.errorContainer,
//       onErrorContainer: MyColor.onErrorContainer,
//       surface: MyColor.surface,
//       onSurface: MyColor.onSurface,
//       surfaceContainerHighest: MyColor.surfaceContainerHigh,
//       onSurfaceVariant: MyColor.onSurfaceVariant,
//       outline: MyColor.outline,
//       outlineVariant: MyColor.outlineVariant,
//       shadow: MyColor.black,
//       scrim: MyColor.black,
//       inverseSurface: MyColor.darkSurface,
//       onInverseSurface: MyColor.darkOnSurface,
//       inversePrimary: MyColor.primaryFixedDim,
//       surfaceTint: MyColor.primary,
//     ),
//     textTheme: TextTheme(
//       displayLarge: TextStyle(
//         color: MyColor.onSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 32.sp : 40.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w700,
//       ),
//       displayMedium: TextStyle(
//         color: MyColor.onSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 28.sp : 36.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w600,
//       ),
//       displaySmall: TextStyle(
//         color: MyColor.onSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 24.sp : 32.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w600,
//       ),
//       titleLarge: TextStyle(
//         color: MyColor.onSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 20.sp : 24.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w600,
//       ),
//       titleMedium: TextStyle(
//         color: MyColor.onSurface,
//         fontSize:
//             (isMobile(context) ? 16.sp : 18.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         fontFamily: MyString.poppinsMedium,
//         fontWeight: FontWeight.w500,
//       ),
//       titleSmall: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.onSurfaceVariant,
//         fontFamily: MyString.poppinsRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       bodyLarge: TextStyle(
//         fontSize:
//             (isMobile(context) ? 16.sp : 18.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.onSurface,
//         fontFamily: MyString.rubikRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       bodyMedium: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.onSurface,
//         fontFamily: MyString.rubikRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       bodySmall: TextStyle(
//         fontSize:
//             (isMobile(context) ? 10.sp : 12.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.onSurfaceVariant,
//         fontFamily: MyString.rubikRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       labelLarge: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.onSurfaceVariant,
//         fontFamily: MyString.poppinsMedium,
//         fontWeight: FontWeight.w500,
//       ),
//       labelMedium: TextStyle(
//         fontSize:
//             (isMobile(context) ? 12.sp : 14.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.onSurfaceVariant,
//         fontFamily: MyString.poppinsRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       labelSmall: TextStyle(
//         fontSize:
//             (isMobile(context) ? 10.sp : 12.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.outline,
//         fontFamily: MyString.poppinsRegular,
//         fontWeight: FontWeight.w400,
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.onSurfaceVariant,
//         fontWeight: FontWeight.w400,
//       ),
//       hintStyle: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.outline,
//         letterSpacing: 1.2,
//         fontWeight: FontWeight.w400,
//       ),
//       isDense: true,
//       filled: true,
//       prefixIconColor: MyColor.outline,
//       fillColor: MyColor.surfaceContainerLowest,
//       contentPadding: EdgeInsets.symmetric(
//         vertical: 10.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//         horizontal:
//             18.w * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.primary, width: 1.5.w),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.outlineVariant, width: 1.0.w),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.error, width: 1.5.w),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.error, width: 1.5.w),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ButtonStyle(
//         shape: WidgetStateProperty.all(
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
//         ),
//         padding: WidgetStateProperty.all(
//           EdgeInsets.symmetric(
//             vertical:
//                 16.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//             horizontal:
//                 24.w * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//           ),
//         ),
//         backgroundColor: WidgetStateProperty.all(MyColor.primary),
//         foregroundColor: WidgetStateProperty.all(MyColor.onPrimary),
//         textStyle: WidgetStateProperty.all(
//           TextStyle(
//             fontSize:
//                 (isMobile(context) ? 16.sp : 18.sp) *
//                 responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//             fontFamily: MyString.poppinsMedium,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         elevation: WidgetStateProperty.all(0),
//         minimumSize: WidgetStateProperty.all(
//           Size(
//             isMobile(context) ? 100.w : 120.w,
//             isMobile(context) ? 44.h : 52.h,
//           ),
//         ),
//       ),
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: ButtonStyle(
//         foregroundColor: WidgetStateProperty.all(MyColor.primary),
//         textStyle: WidgetStateProperty.all(
//           TextStyle(
//             fontSize:
//                 (isMobile(context) ? 14.sp : 16.sp) *
//                 responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//             fontFamily: MyString.poppinsMedium,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         padding: WidgetStateProperty.all(
//           EdgeInsets.symmetric(
//             vertical:
//                 8.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//             horizontal:
//                 16.w * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//           ),
//         ),
//       ),
//     ),
//     dividerTheme: DividerThemeData(
//       color: MyColor.outlineVariant,
//       thickness: 1.0.w,
//       space: 1.0.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.5),
//     ),
//   );

//   /// Dark theme and its settings.
//   static ThemeData dark(BuildContext context) => ThemeData.dark().copyWith(
//     visualDensity: visualDensity,
//     primaryColor: MyColor.primary,
//     scaffoldBackgroundColor: MyColor.darkSurface,
//     cardColor: MyColor.darkSurfaceContainer,
//     iconTheme: IconThemeData(
//       color: MyColor.darkOnSurfaceVariant,
//       size: isMobile(context) ? 20.w : 24.w,
//     ),
//     appBarTheme: AppBarTheme(
//       elevation: 0,
//       iconTheme: IconThemeData(
//         color: MyColor.darkOnSurfaceVariant,
//         size: isMobile(context) ? 20.w : 24.w,
//       ),
//       backgroundColor: MyColor.darkSurface,
//       titleTextStyle: TextStyle(
//         color: MyColor.darkOnSurface,
//         fontSize: isMobile(context) ? 16.sp : 18.sp,
//         fontFamily: MyString.poppinsMedium,
//         fontWeight: FontWeight.w600,
//       ),
//       toolbarHeight: isMobile(context) ? 56.h : 64.h,
//     ),
//     colorScheme: ColorScheme(
//       brightness: Brightness.dark,
//       primary: MyColor.primary,
//       onPrimary: MyColor.onPrimary,
//       primaryContainer: MyColor.primaryContainer,
//       onPrimaryContainer: MyColor.onPrimaryContainer,
//       secondary: MyColor.darkSurfaceContainerHigh,
//       onSecondary: MyColor.darkOnSurface,
//       secondaryContainer: MyColor.darkSurfaceContainerHigh,
//       onSecondaryContainer: MyColor.darkOnSurface,
//       tertiary: MyColor.darkSurfaceContainerHigh,
//       onTertiary: MyColor.darkOnSurface,
//       tertiaryContainer: MyColor.darkSurfaceContainerHigh,
//       onTertiaryContainer: MyColor.darkOnSurface,
//       error: MyColor.darkError,
//       onError: MyColor.onPrimary,
//       errorContainer: MyColor.darkErrorContainer,
//       onErrorContainer: MyColor.darkOnErrorContainer,
//       surface: MyColor.darkSurface,
//       onSurface: MyColor.darkOnSurface,
//       surfaceContainerHighest: MyColor.darkSurfaceContainerHigh,
//       onSurfaceVariant: MyColor.darkOnSurfaceVariant,
//       outline: MyColor.darkOutline,
//       outlineVariant: MyColor.darkOutlineVariant,
//       shadow: MyColor.black,
//       scrim: MyColor.black,
//       inverseSurface: MyColor.surface,
//       onInverseSurface: MyColor.onSurface,
//       inversePrimary: MyColor.primaryFixedDim,
//       surfaceTint: MyColor.primary,
//     ),
//     textTheme: TextTheme(
//       displayLarge: TextStyle(
//         color: MyColor.darkOnSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 32.sp : 40.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w700,
//       ),
//       displayMedium: TextStyle(
//         color: MyColor.darkOnSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 28.sp : 36.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w600,
//       ),
//       displaySmall: TextStyle(
//         color: MyColor.darkOnSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 24.sp : 32.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w600,
//       ),
//       titleLarge: TextStyle(
//         color: MyColor.darkOnSurface,
//         fontFamily: MyString.poppinsMedium,
//         fontSize:
//             (isMobile(context) ? 20.sp : 24.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.1),
//         fontWeight: FontWeight.w600,
//       ),
//       titleMedium: TextStyle(
//         color: MyColor.darkOnSurface,
//         fontSize:
//             (isMobile(context) ? 16.sp : 18.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         fontFamily: MyString.poppinsMedium,
//         fontWeight: FontWeight.w500,
//       ),
//       titleSmall: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOnSurfaceVariant,
//         fontFamily: MyString.poppinsRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       bodyLarge: TextStyle(
//         fontSize:
//             (isMobile(context) ? 16.sp : 18.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOnSurface,
//         fontFamily: MyString.rubikRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       bodyMedium: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOnSurface,
//         fontFamily: MyString.rubikRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       bodySmall: TextStyle(
//         fontSize:
//             (isMobile(context) ? 12.sp : 14.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOnSurfaceVariant,
//         fontFamily: MyString.rubikRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       labelLarge: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOnSurfaceVariant,
//         fontFamily: MyString.poppinsMedium,
//         fontWeight: FontWeight.w500,
//       ),
//       labelMedium: TextStyle(
//         fontSize:
//             (isMobile(context) ? 12.sp : 14.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOnSurfaceVariant,
//         fontFamily: MyString.poppinsRegular,
//         fontWeight: FontWeight.w400,
//       ),
//       labelSmall: TextStyle(
//         fontSize:
//             (isMobile(context) ? 10.sp : 12.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOutline,
//         fontFamily: MyString.poppinsRegular,
//         fontWeight: FontWeight.w400,
//       ),
//     ),
//     inputDecorationTheme: InputDecorationTheme(
//       labelStyle: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOnSurfaceVariant,
//         fontWeight: FontWeight.w400,
//       ),
//       hintStyle: TextStyle(
//         fontSize:
//             (isMobile(context) ? 14.sp : 16.sp) *
//             responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//         color: MyColor.darkOutline,
//         letterSpacing: 1.2,
//         fontWeight: FontWeight.w400,
//       ),
//       isDense: true,
//       filled: true,
//       prefixIconColor: MyColor.darkOutline,
//       fillColor: MyColor.darkSurfaceContainer,
//       contentPadding: EdgeInsets.symmetric(
//         vertical: 10.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//         horizontal:
//             18.w * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//       ),
//       focusedBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.primary, width: 1.5.w),
//       ),
//       enabledBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.darkOutlineVariant, width: 1.0.w),
//       ),
//       errorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.darkError, width: 1.5.w),
//       ),
//       focusedErrorBorder: OutlineInputBorder(
//         borderRadius: BorderRadius.all(Radius.circular(7.r)),
//         borderSide: BorderSide(color: MyColor.darkError, width: 1.5.w),
//       ),
//     ),
//     elevatedButtonTheme: ElevatedButtonThemeData(
//       style: ButtonStyle(
//         shape: WidgetStateProperty.all(
//           RoundedRectangleBorder(borderRadius: BorderRadius.circular(7.r)),
//         ),
//         padding: WidgetStateProperty.all(
//           EdgeInsets.symmetric(
//             vertical:
//                 16.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//             horizontal:
//                 24.w * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//           ),
//         ),
//         backgroundColor: WidgetStateProperty.all(MyColor.primary),
//         foregroundColor: WidgetStateProperty.all(MyColor.onPrimary),
//         textStyle: WidgetStateProperty.all(
//           TextStyle(
//             fontSize:
//                 (isMobile(context) ? 16.sp : 18.sp) *
//                 responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//             fontFamily: MyString.poppinsMedium,
//             fontWeight: FontWeight.w600,
//           ),
//         ),
//         elevation: WidgetStateProperty.all(0),
//         minimumSize: WidgetStateProperty.all(
//           Size(
//             isMobile(context) ? 100.w : 120.w,
//             isMobile(context) ? 44.h : 52.h,
//           ),
//         ),
//       ),
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: ButtonStyle(
//         foregroundColor: WidgetStateProperty.all(MyColor.primary),
//         textStyle: WidgetStateProperty.all(
//           TextStyle(
//             fontSize:
//                 (isMobile(context) ? 14.sp : 16.sp) *
//                 responsiveTextScale(context, mobile: 1.0, desktop: 1.05),
//             fontFamily: MyString.poppinsMedium,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//         padding: WidgetStateProperty.all(
//           EdgeInsets.symmetric(
//             vertical:
//                 8.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//             horizontal:
//                 16.w * responsiveSpacing(context, mobile: 1.0, desktop: 1.2),
//           ),
//         ),
//       ),
//     ),
//     dividerTheme: DividerThemeData(
//       color: MyColor.darkOutlineVariant,
//       thickness: 1.0.w,
//       space: 1.0.h * responsiveSpacing(context, mobile: 1.0, desktop: 1.5),
//     ),
//   );
// }
