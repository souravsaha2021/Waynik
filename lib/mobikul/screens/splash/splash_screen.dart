
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

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:test_new/mobikul/models/homePage/home_screen_model.dart';
import '../../../main.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../configuration/mobikul_theme.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/global_data.dart';
import '../../helper/app_localizations.dart';
import '../../helper/extension.dart';
import '../../models/walk_through/walk_through_model.dart';
import 'bloc/splash_screen_bloc.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}


class _SplashScreenState extends State<SplashScreen> {
  bool isLoading = true;
  HomePageData? homePageDataModel;
  SplashScreenBloc? _splashScreenBloc;

  List<WalkthroughData>? walkthroughData  = [];
  late CheckTheme themeNotifier;

  @override
  void initState() {
    checkAndUpdateTheme();
    _splashScreenBloc = context.read<SplashScreenBloc>();
    _splashScreenBloc?.add(SplashScreenDataFetchEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<CheckTheme>(
      builder: (context, CheckTheme themeNotifier, child) {
        return Scaffold(
          body: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (BuildContext context, state) {
              if (state is SplashScreenInitial) {
                isLoading = true;
              } else if (state is SplashScreenSuccess) {
                isLoading = false;
                homePageDataModel = state.homePageData;
                GlobalData.homePageData = state.homePageData;
                setApplicationData();
                manageThemeData(themeNotifier);
              } else if (state is WalkThroughDataSuccess) {
                isLoading = false;
                walkthroughData = state.model.walkthroughData??[];
                if ((walkthroughData??[]).isNotEmpty) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) async{
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.walkThrough,(Route<dynamic> route) => false);
                  });
                } else {
                 /* WidgetsBinding.instance?.addPostFrameCallback((_) async
                      await Future.delayed(const Duration(seconds: 3));
                    Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomTabBar,(Route<dynamic> route) => false);
                  });*/
                  WidgetsBinding.instance.addPostFrameCallback((_) async {
                    await Future.delayed(const Duration(seconds: 3));
                    Navigator.of(context).pushNamedAndRemoveUntil(
                      AppRoutes.bottomTabBar,
                          (Route<dynamic> route) => false,
                    );
                  });
                }
              } else if (state is WalkThroughDataError) {
                isLoading = false;
                WidgetsBinding.instance?.addPostFrameCallback((_) async{
                  Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomTabBar,(Route<dynamic> route) => false);
                });
              } else if (state is SplashScreenError) {
                isLoading = false;
                WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AppDialogHelper.errorDialog(
                    AppStringConstant.errorRequest,
                    context,
                    AppLocalizations.of(context),
                    title: AppStringConstant.somethingWentWrong,
                    cancelable: false,
                    onConfirm: () async {
                      _splashScreenBloc?.emit(SplashScreenInitial());
                      _splashScreenBloc?.add(SplashScreenDataFetchEvent());
                    },
                  );
                });
              }
              return buildUI(context,themeNotifier);
            },
          ),
        );},
    );
  }

  Widget buildUI(BuildContext context,CheckTheme themeNotifier) {
    return Stack(
      children: [
        SizedBox(
          width: AppSizes.deviceWidth.toDouble(),
          height: AppSizes.deviceHeight.toDouble(),
          child: appStoragePref.getSplashScreen().isEmpty ? Image.asset(
            AppImages.splashScreen,
            fit: BoxFit.fill,
          ) :
          Container(
            decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(
                    themeNotifier.isDark == "true" ? appStoragePref.getSplashScreenDark() : appStoragePref.getSplashScreen() ?? "",
                  ),
                  fit: BoxFit.fill,
                )
            ),
          ),
        ),
        Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Visibility(
              visible: isLoading,
              child: LinearProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Theme.of(context).colorScheme.onPrimary,
                ),
              ),
            )
        ),
      ],
    );
  }

  @override
  void dispose() {
    super.dispose();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: [
      SystemUiOverlay.top,
      SystemUiOverlay.bottom
    ]); // Revert the status bar visibility
  }

  void setApplicationData() {
    // if (appStoragePref.getStoreCode() == null && (homePageDataModel?.storeData?.length ?? 0) > 0) {
    //   appStoragePref.setStoreCode(homePageDataModel?.d?[0] ?? "en");
    // }

    appStoragePref.setSplashScreen(homePageDataModel?.splashImage?? "");
    appStoragePref.setSplashScreenDark(homePageDataModel?.darkSplashImage?? "");
    appStoragePref.setAppLogo(homePageDataModel?.appLogo?? "");
    appStoragePref.setAppLogoDark(homePageDataModel?.darkAppLogo?? "");

    appStoragePref.setIsTabCategoryView(((homePageDataModel?.tabCategoryView??"1") == "1"));

    /// Set Watch app data
    appStoragePref.setWatchEnabled(homePageDataModel?.watchEnabled ??  false);

    if (appStoragePref.getCurrencyCode().isEmpty)
      appStoragePref.setCurrencyCode(homePageDataModel?.defaultCurrency?? AppConstant.defaultCurrency);

    setStoreData();
    setOnBoardingVersion();
    updatePricePref();

    WidgetsBinding.instance?.addPostFrameCallback((_) async{
      print("TEST_LOG=====showWalkThrough==> ${await appStoragePref.showWalkThrough()??""}");
      if (appStoragePref.showWalkThrough()) {
        _splashScreenBloc?.add(const WalkThroughDataFetchEvent());
      } else {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(context).pushNamedAndRemoveUntil(AppRoutes.bottomTabBar,(Route<dynamic> route) => false);
        });
      }
    });

  }

  void setStoreData() {
    if (homePageDataModel?.websiteId != null && (homePageDataModel?.websiteId.toString()??"").isNotEmpty) {
      appStoragePref.setWebsiteId(homePageDataModel?.websiteId.toString()??"");
    }
    homePageDataModel?.storeData?.forEach((element) {
      element.stores?.forEach((store) {
        if (appStoragePref.getStoreId() == store.id.toString()) {
          appStoragePref.setStoreCode(store.code??"");
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AppLocalizations.of(context)?.load(Locale.fromSubtags(languageCode: appStoragePref.getStoreCode()));
            MobikulApp.setLocale(context, Locale.fromSubtags(languageCode: appStoragePref.getStoreCode()));
          });
        }
      });
    });
  }

  void updatePricePref() {
    appStoragePref.setPricePattern(homePageDataModel?.priceFormat?.pattern??"");
    appStoragePref.setPrecision(homePageDataModel?.priceFormat?.precision??0);
  }

  void setOnBoardingVersion() async {
    if (homePageDataModel?.walkthroughVersion?.isNotEmpty??false) {
      if (appStoragePref.getWalkThroughVersion()?.isEmpty??true) {
        appStoragePref.setShowWalkThrough(true);
        appStoragePref.setWalkThroughVersion(homePageDataModel?.walkthroughVersion.toString()?? "");
      }
      if (double.parse(appStoragePref.getWalkThroughVersion().toString()??"") < double.parse(homePageDataModel?.walkthroughVersion.toString()??"0.0")) {
        appStoragePref.setShowWalkThrough(true);
        appStoragePref.setWalkThroughVersion(homePageDataModel?.walkthroughVersion.toString()?? "");
      }
    }
  }

  ///  Method for manage dynamic theme
  Future<bool> manageThemeData(CheckTheme themeNotifier) async {
    print("---------.....${AppTheme.lightAppBarColor}");
    if ((await updateLightTheme(homePageDataModel) || await updateDarkTheme(homePageDataModel))) {
      await _updateLightTheme(homePageDataModel?.appThemeColor,homePageDataModel?.appButtonColor,homePageDataModel?.buttonTextColor,homePageDataModel?.appThemeTextColor);
      await _updateDarkTheme(homePageDataModel?.darkAppThemeColor,homePageDataModel?.darkAppButtonColor,homePageDataModel?.darkButtonTextColor,homePageDataModel?.darkAppThemeTextColor);
      themeNotifier.isDark == "true"
          ? themeNotifier.isDark = "false"
          : themeNotifier.isDark = "true";
      Future.delayed(Duration.zero, () {
        themeNotifier.isDark == "true"
            ? themeNotifier.isDark = "false"
            : themeNotifier.isDark = "true";
      });
      return true;
    } else {
      return false;
    }
  }

  /// Method for check light theme
  Future<bool> updateLightTheme(HomePageData? model) async {
    var update = false;

    try {
      if (model?.appThemeColor?.replaceFirst("#", "") != appStoragePref.getLightThemeColor()) {
        update = true;
      }
      if (model?.appThemeTextColor?.replaceFirst("#", "") != appStoragePref.getLightThemeTextColor()) {
        update = true;
      }
      if (model?.appButtonColor?.replaceFirst("#", "") != appStoragePref.getLightThemeButtonColor()) {
        update = true;
      }
      if (model?.buttonTextColor?.replaceFirst("#", "") != appStoragePref.getLightThemeButtonTextColor()) {
        update = true;
      }
      return update;
    } catch (e) {
      return true;
    }
  }

  /// Method for check dark theme
  Future<bool> updateDarkTheme(HomePageData? model) async {
    var update = false;

    try {
      if (model?.darkAppThemeColor?.replaceFirst("#", "") != appStoragePref.getDarkThemeColor()) {
        update = true;
      }

      if (model?.darkAppThemeTextColor?.replaceFirst("#", "") != appStoragePref.getDarkThemeTextColor()) {
        update = true;
      }

      if (model?.darkAppButtonColor?.replaceFirst("#", "") != appStoragePref.getDarkThemeButtonColor()) {
        update = true;
      }
      if (model?.darkButtonTextColor?.replaceFirst("#", "") != appStoragePref.getDarkThemeButtonTextColor()) {
        update = true;
      }
      return update;
    } catch (e) {
      return true;
    }
  }

  ///   Method to check need to update theme or not
  void checkAndUpdateTheme() async {
    if(appStoragePref.getLightThemeColor()?.isNotEmpty ?? false) {
      try {

        await _updateLightTheme(appStoragePref.getLightThemeColor(),appStoragePref.getLightThemeButtonColor(),appStoragePref.getLightThemeButtonTextColor(),appStoragePref.getLightThemeTextColor());
        await _updateDarkTheme(appStoragePref.getDarkThemeColor(),appStoragePref.getDarkThemeButtonColor(),appStoragePref.getDarkThemeButtonTextColor(),appStoragePref.getDarkThemeTextColor());
        themeNotifier.isDark == "true"
            ? themeNotifier.isDark = "false"
            : themeNotifier.isDark = "true";
        Future.delayed(Duration.zero, () {
          themeNotifier.isDark == "true"
              ? themeNotifier.isDark = "false"
              : themeNotifier.isDark = "true";
        });
      }catch (e) {
        // ignore
        print("Error occurred $e");
      }
    }
  }

  ///   Set Dynamic theme data
  void setThemeData() async{
    appStoragePref.setLightThemeColor(homePageDataModel?.appThemeColor?.replaceFirst("#", ""));
    appStoragePref.setDarkThemeColor(homePageDataModel?.darkAppThemeColor?.replaceFirst("#", ""));
    appStoragePref.setLightThemeButtonColor(homePageDataModel?.appButtonColor?.replaceFirst("#", ""));
    appStoragePref.setDarkThemeButtonColor(homePageDataModel?.darkAppButtonColor?.replaceFirst("#", ""));
    appStoragePref.setLightThemeButtonTextColor(homePageDataModel?.buttonTextColor?.replaceFirst("#", ""));
    appStoragePref.setDarkThemeButtonTextColor(homePageDataModel?.darkButtonTextColor?.replaceFirst("#", ""));
    appStoragePref.setLightThemeTextColor(homePageDataModel?.appThemeTextColor?.replaceFirst("#", ""));
    appStoragePref.setDarkThemeTextColor(homePageDataModel?.darkAppThemeTextColor?.replaceFirst("#", ""));
  }


  /// Update Light theme
  Future<void> _updateLightTheme(String? lightAppBar,String? lightButton,String? lightButtonText,String? lightAppTextColor) async {
    setThemeData();

    AppTheme.lightAppBarColor = HexColor.fromHex(lightAppBar ?? "");
    AppTheme.lightBtnColor = HexColor.fromHex(lightButton ?? "");
    AppTheme.lightOutlinedCenterTextColor = HexColor.fromHex(lightButton ?? "");
    AppTheme.lightAppTextColor = HexColor.fromHex(lightButtonText ?? "");





    AppTheme.lightTheme = AppTheme.lightTheme.copyWith(
      iconTheme: IconThemeData(
          color: HexColor.fromHex(lightButton ?? "")
      ),

      appBarTheme: AppTheme.lightTheme.appBarTheme.copyWith(
          color: HexColor.fromHex(lightAppBar ?? ""),
          titleTextStyle: AppTheme.lightTheme.appBarTheme.titleTextStyle
              ?.copyWith(
              color: HexColor.fromHex(lightButtonText ?? "")),
          iconTheme: AppTheme.lightTheme.appBarTheme.iconTheme?.copyWith(
              color: HexColor.fromHex(lightButton ?? ""))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                HexColor.fromHex(lightButton ?? ""),),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: HexColor.fromHex(lightButtonText ?? ""),))
          )),
      textTheme: TextTheme(
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
        labelLarge: TextStyle(color: HexColor.fromHex(lightButtonText ?? ""),),
          bodySmall:TextStyle(
              fontSize: AppSizes.textSizeMedium,
              fontWeight: FontWeight.bold,
              fontFamily: "Roboto",
              color: HexColor.fromHex(lightAppTextColor ?? ""),),

      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppTheme.lightTheme.outlinedButtonTheme.style?.copyWith(
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                  color: HexColor.fromHex(lightButton ?? "")
              )),
              textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                  color: HexColor.fromHex(lightButtonText ?? "")
              )))),

    );
  }

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
      color: MobikulTheme.accentColor,
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



  /// Update Dark theme
  Future<void> _updateDarkTheme(String? darkAppTheme,String? darkAppButton,String? darkAppButtonText,String? darkAppText) async{

    AppTheme.darkAppBarColor = HexColor.fromHex(darkAppTheme ?? "");
    AppTheme.darkBtnColor = HexColor.fromHex(darkAppButton ?? "");
    AppTheme.darkOutlinedCenterTextColor = HexColor.fromHex(darkAppButton ?? "");
    AppTheme.darkAppTextColor = HexColor.fromHex(darkAppButtonText ?? "");


    AppTheme.darkTheme  = AppTheme.darkTheme.copyWith(
      iconTheme: IconThemeData(
          color: HexColor.fromHex(darkAppButton ?? "")
      ),

      appBarTheme: AppTheme.darkTheme.appBarTheme.copyWith(
          color: HexColor.fromHex(darkAppTheme ?? ""),
          titleTextStyle: AppTheme.lightTheme.appBarTheme.titleTextStyle
              ?.copyWith(
              color: HexColor.fromHex(darkAppButtonText ?? "")),
          iconTheme: AppTheme.lightTheme.appBarTheme.iconTheme?.copyWith(
              color: HexColor.fromHex(darkAppButton ?? ""))),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: AppTheme.lightTheme.elevatedButtonTheme.style?.copyWith(
              backgroundColor: MaterialStateProperty.all<Color>(
                HexColor.fromHex(darkAppButton ?? ""),),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  TextStyle(color: HexColor.fromHex(darkAppButtonText ?? ""),))
          )),
      textTheme: TextTheme(
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
        labelLarge: TextStyle(color: HexColor.fromHex(darkAppButtonText ?? ""),),
        bodySmall: TextStyle(
            fontSize: AppSizes.textSizeMedium,
            fontWeight: FontWeight.bold,
            fontFamily: "Roboto",
          color: HexColor.fromHex(darkAppText ?? ""),),
      ),

      outlinedButtonTheme: OutlinedButtonThemeData(
          style: AppTheme.lightTheme.outlinedButtonTheme.style?.copyWith(
              side: MaterialStateProperty.all<BorderSide>(BorderSide(
                  color: HexColor.fromHex(darkAppButton ?? "")
              )),
              textStyle: MaterialStateProperty.all<TextStyle>(TextStyle(
                  color: HexColor.fromHex(darkAppButtonText ?? ""))))),

    );

  }




}
