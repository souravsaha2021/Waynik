/*
 *
 *  Webkul Software.
 * @package Mobikul Application Code.
 *  @Category Mobikul
 *  @author Webkul <support@webkul.com>
 *  @Copyright (c) Webkul Software Private Limited (https://webkul.com)
 *  @license https://store.webkul.com/license.html
 *  @link https://store.webkul.com/license.html
 *
 * /
 */

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';

class MobikulTheme {
  static const Color primaryColor = Color(0xFFFFFFFF);
  static const Color accentColor = Color(0xFF000000);
// static const Color primaryColor = Colors.green;
// static const Color accentColor = Color(0xFFECE607);

  static const Color diffColor = Color(0xFF339EF1);
}

class AppTheme {
  AppTheme._();

  //Applied on Scaffold
  static final Color _lightScaffoldColor = Colors.grey.shade200;
  static const Color _darkScaffoldColor = Colors.black26;

  //Applied on Scaffold where TextFormFields are used
  static const Color _lightCustomScaffoldBgColor = Colors.white;
  static const Color _darkCustomScaffoldBgColor = Colors.black;

  //Applied on AppBar
  static  Color lightAppBarColor = Colors.white;
  static  Color darkAppBarColor = Colors.black;

  //Applied on Icons
  static const Color _lightIconColor = Colors.black;
  static const Color _darkIconColor = Colors.white;

  //Applied on Card/Container
  static const Color _lightCardColor = Colors.white;
  static const Color _darkCardColor = Colors.black54;

  //Applied on Divider
  static const Color _lightDividerColor = Colors.black26;
  static const Color _darkDividerColor = Colors.white70;

  //Applied on Button
  static  Color lightBtnColor = MobikulTheme.accentColor;
  static  Color darkBtnColor = Colors.green;

  //Applied on CustomOutlineButton ( Used on "All Orders Screen" )
  static const Color _lightCustomOutlineBtnColor = MobikulTheme.accentColor;
  static const Color _darkCustomOutlineBtnColor = Colors.green;

  //Applied on OutlinedTextButton's Text
  static  Color lightOutlinedCenterTextColor = MobikulTheme.accentColor;
  static  Color darkOutlinedCenterTextColor = Colors.white;

  static const Color _lightPrimaryColor = MobikulTheme.accentColor;
  static const Color _darkPrimaryColor = Colors.green;


  static const Color _lightSecondaryColor = Colors.green;
  static const Color _darkSecondaryColor = Colors.black;
  // static const Color _darkSecondaryColor = Colors.white;

  static const Color _lightOnPrimaryColor = Colors.black;
  static const Color _darkOnPrimaryColor = Colors.green;

  //  Button Text Color
  static const Color lightButtonTextColor = Colors.white;
  static const Color darkButtonTextColor = Colors.white;

  // Icon Color
  static  Color lightAppTextColor = Colors.white;
  static  Color darkAppTextColor = Colors.green;



  /// light theme ///
  static ThemeData lightTheme = ThemeData(
    scaffoldBackgroundColor: _lightScaffoldColor,
    appBarTheme:  AppBarTheme(
      titleTextStyle: TextStyle(
          color: _darkSecondaryColor,
          fontFamily: "Roboto",
          fontWeight: FontWeight.bold,
          fontSize: AppSizes.textSizeXLarge),
      color: lightAppBarColor,
      iconTheme: IconThemeData(color: _lightIconColor),
    ),
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        backgroundColor: lightAppBarColor,
        selectedIconTheme: IconThemeData(color: _lightIconColor),
        selectedLabelStyle: TextStyle(color: _lightIconColor)),
    colorScheme:  ColorScheme.light(
      primary: _lightPrimaryColor,
      primaryContainer: _lightPrimaryColor,
      secondary: _lightSecondaryColor,
      onPrimary: _lightOnPrimaryColor,
      outline: lightOutlinedCenterTextColor,
      //Applied on Scaffold white
      background: _lightCustomScaffoldBgColor,
    ),
    iconTheme: const IconThemeData(
      color: _lightIconColor,
    ),
    textTheme: _lightTextTheme,
    dividerTheme: const DividerThemeData(color: _lightDividerColor),
    cardColor: _lightCardColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: lightBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(lightBtnColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          side: const BorderSide(color: MobikulTheme.accentColor),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          backgroundColor: Colors.transparent),
    ),
    buttonTheme: const ButtonThemeData(
      colorScheme: ColorScheme.light(
        background: _lightCustomOutlineBtnColor
      )
    ),
    // buttonColor: _lightCustomOutlineBtnColor,
    // Override the button color for the date picker dialog
    dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
        decorationColor: Colors.blue,
      ),
    ),
  );

  /// dark theme ///
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: _darkScaffoldColor,
    appBarTheme:  AppBarTheme(
      color: darkAppBarColor,
      iconTheme: IconThemeData(color: _darkIconColor),
    ),
    colorScheme:  ColorScheme.dark(
      primary: _darkPrimaryColor,
      primaryContainer: _darkPrimaryColor,
      // primaryVariant: _darkPrimaryColor,
      secondary: _darkSecondaryColor,
      onPrimary: _darkOnPrimaryColor,
      outline: darkOutlinedCenterTextColor,

      //Applied on Scaffold white
      background: _darkCustomScaffoldBgColor,
    ),
    iconTheme: const IconThemeData(color: _darkIconColor),
    textTheme: _darkTextTheme,
    bottomNavigationBarTheme:  BottomNavigationBarThemeData(
        backgroundColor: darkAppBarColor,
        selectedIconTheme: IconThemeData(color: _darkIconColor),
        selectedLabelStyle: TextStyle(color: _darkIconColor)),
    dividerTheme: const DividerThemeData(color: _darkDividerColor),
    cardColor: _darkCardColor,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 5.0,
        backgroundColor: darkBtnColor,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        textStyle: const TextStyle(
            color: Colors.white, fontSize: 15, fontWeight: FontWeight.bold),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all<Color>(darkBtnColor),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.0),
          ),
        ),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
          side: const BorderSide(
            color: Colors.white,
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(8.0),
            ),
          ),
          backgroundColor: Colors.black45),
    ),
    buttonTheme: const ButtonThemeData(
        colorScheme: ColorScheme.dark(
            background: _darkCustomOutlineBtnColor
        )
    ),
    // buttonColor: _darkCustomOutlineBtnColor,
    dialogTheme: DialogTheme(
      contentTextStyle: TextStyle(
        decorationColor: Colors.blue,
      ),
    ),
  );

  static const TextTheme _lightTextTheme = TextTheme(
    displayLarge: _lightScreenHeading1TextStyle,
    displayMedium: _lightScreenHeading2TextStyle,
    displaySmall: _lightScreenHeading3TextStyle,
    headlineMedium: _lightScreenHeading4TextStyle,
    headlineSmall: _lightScreenHeading5TextStyle,
    titleLarge: _lightScreenHeading6TextStyle,
    titleMedium: _lightScreenSubTile1TextStyle,
    titleSmall: _lightScreenSubTile2TextStyle,
    bodyLarge: _lightScreenTaskNameTextStyle,
    bodyMedium: _lightScreenTaskDurationTextStyle,
    labelLarge: _lightScreenButtonTextStyle,
    bodySmall: _lightScreenCaptionTextStyle

  );

  static final TextTheme _darkTextTheme = TextTheme(
    displayLarge: _darkScreenHeading1TextStyle,
    displayMedium: _darkScreenHeading2TextStyle,
    displaySmall: _darkScreenHeading3TextStyle,
    headlineMedium: _darkScreenHeading4TextStyle,
    headlineSmall: _darkScreenHeading5TextStyle,
    titleLarge: _darkScreenHeading6TextStyle,
    titleMedium: _darkScreenSubTile1TextStyle,
    titleSmall: _darkScreenSubTile2TextStyle,
    bodyLarge: _darkScreenTaskNameTextStyle,
    bodyMedium: _darkScreenTaskDurationTextStyle,
    labelLarge: _darkScreenButtonTextStyle,
    bodySmall: _darkScreenCaptionTextStyle

  );

  /// light theme text style ///
  static const TextStyle _lightScreenHeading1TextStyle = TextStyle(
      fontSize: AppSizes.textSizeXLarge,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading2TextStyle = TextStyle(
      fontSize: AppSizes.textSizeLarge,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading3TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading4TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorSecondary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading5TextStyle = TextStyle(
      fontSize: AppSizes.textSizeSmall,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenHeading6TextStyle = TextStyle(
      fontSize: AppSizes.textSizeSmall,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorSecondary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenTaskNameTextStyle = TextStyle(
      fontSize: AppSizes.textSizeSmall,
      color: AppColors.textColorPrimary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenTaskDurationTextStyle = TextStyle(
      fontSize: AppSizes.textSizeSmall,
      color: AppColors.textColorSecondary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenSubTile1TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      color: AppColors.textColorPrimary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenSubTile2TextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      color: AppColors.textColorSecondary,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenButtonTextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: lightButtonTextColor,
      //MobikulTheme.accentColor,
      fontFamily: "Roboto");

  static const TextStyle _lightScreenCaptionTextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: AppColors.textColorPrimary,
      fontFamily: "Roboto");

  /// dark theme text style ///
  static final TextStyle _darkScreenHeading1TextStyle =
  _lightScreenHeading1TextStyle.copyWith(
      color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading2TextStyle =
  _lightScreenHeading2TextStyle.copyWith(
      color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading3TextStyle =
  _lightScreenHeading3TextStyle.copyWith(
      color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading4TextStyle =
  _lightScreenHeading4TextStyle.copyWith(
      color: AppColorsDark.textColorSecondary);

  static final TextStyle _darkScreenHeading5TextStyle =
  _lightScreenHeading5TextStyle.copyWith(
      color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenHeading6TextStyle =
  _lightScreenHeading6TextStyle.copyWith(
      color: AppColorsDark.textColorSecondary);

  static final TextStyle _darkScreenTaskNameTextStyle =
  _lightScreenTaskNameTextStyle.copyWith(
      color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenTaskDurationTextStyle =
  _lightScreenTaskDurationTextStyle.copyWith(
      color: AppColorsDark.textColorSecondary);

  static final TextStyle _darkScreenSubTile1TextStyle =
  _lightScreenSubTile1TextStyle.copyWith(
      color: AppColorsDark.textColorPrimary);

  static final TextStyle _darkScreenSubTile2TextStyle =
  _lightScreenSubTile2TextStyle.copyWith(
      color: AppColorsDark.textColorSecondary);

  static const TextStyle _darkScreenButtonTextStyle = TextStyle(
      fontSize: AppSizes.textSizeMedium,
      fontWeight: FontWeight.bold,
      color: Colors.white,
      fontFamily: "Roboto");

  static final TextStyle _darkScreenCaptionTextStyle =
  _lightScreenHeading3TextStyle.copyWith(
      color: AppColorsDark.textColorPrimary);
}

//Manage the theme by toggle from profile
class CheckTheme extends ChangeNotifier {
  late String _isDark;
  late AppStoragePref _appStoragePref;
  String get isDark => _isDark;

  CheckTheme() {
    _isDark = "false";
    _appStoragePref = AppStoragePref();
    getPreferences();
  }
//Switching the themes
  set isDark(String value) {
    _isDark = value;
    _appStoragePref.setTheme(value);
    notifyListeners();
  }

  getPreferences() async {
    _isDark = await _appStoragePref.getTheme();
    notifyListeners();
    print(_isDark);
    if (_isDark == "") {
      print("Fetching Device Theme Data");
      if (window.platformBrightness == Brightness.dark) {
        _isDark = "true";
        _appStoragePref.setTheme("true");
      } else {
        _isDark = "false";
        _appStoragePref.setTheme("false");
      }
    } else {
      _isDark = await _appStoragePref.getTheme();
      notifyListeners();
      print(_isDark);
    }
  }
}
