import 'package:flutter/material.dart';

class MyColor {
  static const Color black = Color(0xFF000000);
  static const Color white = Color(0xFFFFFFFF);

  static const Color gray25 = Color(0xFFFCFCFD);
  static const Color gray50 = Color(0xFFF9FAFB);
  static const Color gray100 = Color(0xFFF2F4F7);
  static const Color gray200 = Color(0xFFEAECF0);
  static const Color gray300 = Color(0xFFD0D5DD);
  static const Color gray400 = Color(0xFF98A2B3);
  static const Color gray500 = Color(0xFF667085);
  static const Color gray600 = Color(0xFF475467);
  static const Color gray700 = Color(0xFF344054);
  static const Color gray800 = Color(0xFF1D2939);
  static const Color gray900 = Color(0xFF101828);

  static const Color error = Color(0xFFD92D20);
  static const Color warning = Color(0xFFDC6803);
  static const Color success = Color(0xFF079455);

  /*
  static const ashhLight = Color(0xFFECF6FF);
  static const bluePrimary = Color(0xFF01204E);
  static const blueSecondary = Color(0xFF0E4D7B);
  static const skyPrimary = Color(0xFF30BCED);
  static const skySecondary = Color(0xFFBDDDFC);
  static const statusColor = Color(0xFFFEF8C0);
  static const statusText = Color(0xFF795548);
  static const bodyGreyColor = Color(0xFFEEEEEE);
  static const activeStatusColor = Color(0xFF00FF00);
  static const successColor = Color(0xFF5cb85c);
  static const failedColor = Color(0xFFd23232);
  static const inActiveColor = Color(0xFFD6D6D6);

  static const textColor = Color(0xFF2D2C2D);
  static const textSecondary = Color(0xFFF9F9F9);
  static const textThird = Color(0xFF757575);
  static const cardBackgroundColor = Color(0xFFFAFAFA);

  static const secondary = Color(0xFF3B76F6);
  static const accent = Color(0xFFD6755B);
  static const textDark = Color(0xFF53585A);
  static const textLigth = Color(0xFFF5F5F5);
  static const textFaded = Color(0xFF9899A5);
  static const iconLight = Color(0xFFB1B4C0);
  static const iconDark = Color(0xFFB1B3C1);
  static const textHighlight = secondary;
  static const cardLight = Color(0xFFEEEEEE);
  static const cardDark = Color(0xFF303334);
  */

  static const MaterialColor primary =
      MaterialColor(_primaryValue, <int, Color>{
        50: Color(0xFFE0E0E0),
        100: Color(0xFFB3B3B3),
        200: Color(0xFF808080),
        300: Color(0xFF4D4D4D),
        400: Color(0xFF262626),
        500: Color(_primaryValue),
        600: Color(0xFF000000),
        700: Color(0xFF000000),
        800: Color(0xFF000000),
        900: Color(0xFF000000),
      });
  static const int _primaryValue = 0xFF000000;

  static const MaterialColor primaryAccent =
      MaterialColor(_primaryAccentValue, <int, Color>{
        100: Color(0xFFA6A6A6),
        200: Color(_primaryAccentValue),
        400: Color(0xFF737373),
        700: Color(0xFF666666),
      });
  static const int _primaryAccentValue = 0xFF8C8C8C;
}
