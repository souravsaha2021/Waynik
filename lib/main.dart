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
import 'dart:convert';

import 'package:double_back_to_close/double_back_to_close.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_storage/get_storage.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:test_new/mobikul/app_widgets/Tabbar/bottom_tabbar.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import 'package:upgrader/upgrader.dart';
import 'mobikul/configuration/mobikul_theme.dart';
import 'mobikul/constants/app_constants.dart';
import 'mobikul/constants/app_routes.dart';
import 'mobikul/constants/arguments_map.dart';
import 'mobikul/helper/PreCacheApiHelper.dart';
import 'mobikul/helper/app_localizations.dart';
import 'mobikul/helper/push_notifications_manager.dart';
import 'mobikul/screens/home/widgets/item_card_bloc/item_card_bloc.dart';
import 'mobikul/screens/home/widgets/item_card_bloc/item_card_repository.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  var data = message.data;
  print("===>>>${message.data}");
  if (data.isNotEmpty) {
    var notificationId = data["id"];
    var notificationType = data["notificationType"];
    var notificationTitle = data["title"];
    var notificationBody = data["body"];
    var notificationBanner = data["banner_url"];

    PushNotificationsManager().showNotification(notificationTitle!, notificationBody!, json.encode(data),
        notificationBanner);
  }
  print('Handling a background message ${message.messageId}');
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
FirebaseDatabase secondaryDatabase = FirebaseDatabase.instance;


void main() async {

  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp();
    print("Firebase initialized successfully.");
  } catch (e) {
    print("Error initializing Firebase: $e");
  }
  await Permission.notification.isDenied.then((value) {
    if (value) {
      Permission.notification.request();
    }
  });
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);


  await initHiveForFlutter();
  await GetStorage().initStorage;
  await AppStoragePref().init();
  SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
  ));
   mainBox = await HiveStore.openBox("graphqlClientStore");
  // HttpOverrides.global =  MyHttpOverrides();
  WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp();
  // await Firebase.initializeApp(
  //     name: "Mobikul Magento2 App",
  //     options: const FirebaseOptions(
  //         apiKey: "AIzaSyD_05KkgNRt8rTVoIi5BKxcpDSNdv-2nC8",
  //         appId: "1:754615847029:android:0798e390a3010b39",
  //         iosBundleId: "com.webkul.MobikulMagento-2",
  //         messagingSenderId: "",
  //         projectId: "mobikul-magento2-app",
  //         databaseURL: "https://mobikul-magento2-app.firebaseio.com/"));
  // await Upgrader.clearSavedSettings(); ///Debug use only
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      builder: (context, child) {
        final mediaQueryData = MediaQuery.of(context);
        final scale = mediaQueryData.textScaleFactor.clamp(1.0, 1.3);
        return MediaQuery(
          child: UpgradeAlert(
           // upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.material),
            dialogStyle: UpgradeDialogStyle.material,
            child: child,
          ),
          data: MediaQuery.of(context).copyWith(textScaleFactor: 1),
        );
      },
      debugShowCheckedModeBanner: false,
      title: AppStringConstant.appName,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: UpgradeAlert(
        //upgrader: Upgrader(dialogStyle: UpgradeDialogStyle.material),
          dialogStyle: UpgradeDialogStyle.material,
        child: const MobikulApp(),
      ),
    );
  }
}

class MobikulApp extends StatefulWidget {
  const MobikulApp({Key? key}) : super(key: key);

  //for change locale run time
  static void setLocale(BuildContext context, Locale newLocale) {
    _MobikulAppState? state = context.findAncestorStateOfType<_MobikulAppState>();
    state!.refresh(newLocale);
  }

  @override
  State<MobikulApp> createState() => _MobikulAppState();
}

class _MobikulAppState extends State<MobikulApp> {
  bool isDarkMode = false;
  Locale? _locale;

  @override
  void initState() {
    print("init state===>");
    // PushNotificationsManager().setUpFirebase(context);
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      var locale = _fetchLocale();
      setState(() {
        _locale = locale;
        AppLocalizations.of(context)?.load(_locale??Locale.fromSubtags(languageCode: appStoragePref.getStoreCode()));
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return OverlaySupport.global(
      child: ChangeNotifierProvider(
          create: (_) => CheckTheme(),
          child: Consumer<CheckTheme>(
              builder: (context, CheckTheme themeNotifier, child) {
                return MultiBlocProvider(
                  providers: [
                    BlocProvider<ItemCardBloc>(
                      create: (context) => ItemCardBloc(
                        repository: ItemCardRepositoryImp(),
                      ),
                    ),
                  ],
                  child: MaterialApp(
                      theme: themeNotifier.isDark == 'true'
                          ? AppTheme.darkTheme
                          : AppTheme.lightTheme,
                      // darkTheme: AppTheme.darkTheme,
                      onGenerateRoute: AppRoutes.generateRoute,
                      supportedLocales: AppConstant.supportedLanguages.map((e) => Locale(e)),
                      locale: _locale,
                      localizationsDelegates: const [
                        AppLocalizations.delegate,
                        GlobalMaterialLocalizations.delegate,
                        GlobalWidgetsLocalizations.delegate,
                      ],
                      initialRoute: AppRoutes.splash,
                      home: const BottomTabBarWidget(),
                      debugShowCheckedModeBanner: false,
                      navigatorKey: navigatorKey,
                      localeResolutionCallback: (locale, supportedLocales) {
                        if (supportedLocales.contains(_locale)) {
                          return _locale;
                        } else {
                          return supportedLocales.first;
                        }
                      }),
                );
              })),
    );
  }

  //check isDarkMode
  void checkDarkMode() {
    setState(() {
      isDarkMode = appStoragePref.isDarkMode();
    });
  }

  //refresh locale
  refresh(Locale newLocale) => setState(() {
    _locale = newLocale;
  });

  Locale _fetchLocale() {
    final String savedLocale = appStoragePref.getStoreCode();
    var locale = const Locale('en', 'US');
    if (savedLocale == 'en') {
      locale = const Locale('en', 'US');
    } else if (savedLocale == 'ar') {
      locale = const Locale('ar', 'AE');
    }
    return locale;
  }
}