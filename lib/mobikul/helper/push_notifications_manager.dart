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

import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/constants/arguments_map.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';

import '../../main.dart';
import '../constants/app_constants.dart';
import '../models/deliveryBoyDetails/delivery_boy_details_model.dart';

class PushNotificationsManager {
  static final FirebaseMessaging _firebaseMessaging =
      FirebaseMessaging.instance;
  static final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  static const initializationSettingsAndroid =
  AndroidInitializationSettings('@mipmap/ic_launcher');

  static const initializationSettingsIOS = IOSInitializationSettings(
    requestAlertPermission: true,
    requestBadgePermission: true,
    requestSoundPermission: true,
  );

  final InitializationSettings initializationSettings =
  const InitializationSettings(
      android: initializationSettingsAndroid,
      iOS: initializationSettingsIOS);

  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
  FlutterLocalNotificationsPlugin();

  void setUpFirebase(BuildContext context) {
    flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: (String? payload) async {
          if ((payload?.isNotEmpty ?? false) && appStoragePref.getAllowAllNotifications()) {
            print("payload---==>" + payload.toString());

            Map notificationModelMap = json.decode(payload.toString());
            var notificationId = notificationModelMap["id"];
            var notificationType = notificationModelMap["notificationType"];

            if (notificationType ==  AppConstant.productTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.of(navigatorKey.currentContext!).pushNamed(
                AppRoutes.productPage,
                arguments: getProductDataAttributeMap(
                  notificationModelMap["productName"] ?? "",
                  notificationModelMap["productId"] ?? "",
                ),
              );

            } else if (notificationType ==  AppConstant.categoryTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    notificationModelMap["categoryId"] ?? "",
                    notificationModelMap["categoryName"] ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));

            } else if (notificationType ==  AppConstant.customTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
                  arguments: getCatalogMap(
                    notificationModelMap["id"] ?? "",
                    notificationModelMap["title"] ?? "",
                    BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                    false,
                  ));

            } else if (notificationType ==  AppConstant.otherTypeNotification && appStoragePref.getAllowOfferNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.cmsPage,
                  arguments: getCmsPageArguments(
                      notificationModelMap["id"] ?? "",
                      notificationModelMap["title"] ?? ""
                  ));

            } else if (notificationType ==  AppConstant.chatTypeNotification) {
              print("CHECK_Data ==> ${int.parse(notificationModelMap["senderId"].split("-")[1] ?? "0")} ");
              AssignedDeliveryBoyDetails? deliveryBoys = AssignedDeliveryBoyDetails(sellerId:int.parse(notificationModelMap["senderId"].split("-")[1] ?? "0"),
                  customerId: 9, name: "Himani"
              );
              Navigator.pushNamed(context, AppRoutes.deliveryboyHelpChatScreen,arguments: deliveryBoys);

            } else if (notificationType ==  AppConstant.orderTypeNotification && appStoragePref.getAllowOrderNotifications()) {
              Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.orderDetail,
                  arguments: notificationModelMap["incrementId"] ?? ""
              );

            }
          }
        });
    _firebaseCloudMessagingListeners(context);
  }

  Future<StyleInformation?> getNotificationStyle(String? image) async {
    if (image != null) {
      final ByteData imageData =
      await NetworkAssetBundle(Uri.parse(image)).load("");
      return BigPictureStyleInformation(
          ByteArrayAndroidBitmap(imageData.buffer.asUint8List()));
    } else {
      return null;
    }
  }

  void showNotification(
      String title, String body, String? payload, String? image) async {
    var notificationStyle = await getNotificationStyle(image);
    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
        '${Random().nextDouble()}', '${AppStringConstant.appName} Notification',
        importance: Importance.max,
        priority: Priority.max,
        playSound: true,
        styleInformation: notificationStyle);

    var iOSPlatformChannelSpecifics = const IOSNotificationDetails(
      presentAlert: true,
      presentSound: true,
      presentBadge: true,
    );

    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
    );

    flutterLocalNotificationsPlugin
        .show(0, title, body, platformChannelSpecifics, payload: payload);
  }

  Future<String?> createFcmToken() async {
    return _firebaseMessaging.getToken();
  }

  void _firebaseCloudMessagingListeners(BuildContext context) async {
    if (Platform.isIOS) _iosPermission();

    await createFcmToken();

    if (Platform.isIOS) {
      IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
      print("deviceId${iosInfo.identifierForVendor}");
      AppStoragePref().setDeviceId(iosInfo.identifierForVendor ?? "");
      await _firebaseMessaging.subscribeToTopic(AppConstant.fcmMessagingTopiciOS);
    } else {
      AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
      print("deviceId${androidInfo.id}");
      AppStoragePref().setDeviceId(androidInfo.id ?? "");
      await _firebaseMessaging.subscribeToTopic(AppConstant.fcmMessagingTopicAndroid);
    }

    //When app is in Working state
    FirebaseMessaging.onMessage.listen((RemoteMessage message) async {
      print('NOTIFICATION DATA ====>  ${message.data}');

      var data = message.data;
      if (data.isNotEmpty) {
        var notificationTitle = data["title"] ?? "";
        var notificationBody = data["body"] ?? "";
        var notificationBanner = data["banner_url"];

        showNotification(notificationTitle, notificationBody, json.encode(data), notificationBanner);
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print("OnAppOpened}");
      print(message.data);
      _handleNotificationNavigation(message.data);
    });

    FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage? message) {
      print("open app data");
      if (message != null && message.data.isNotEmpty) {
        var data = message.data;
        var notificationTitle = data["title"] ?? "";
        var notificationBody = data["body"] ?? "";
        var notificationBanner = data["banner_url"];

        showNotification(notificationTitle, notificationBody, json.encode(data), notificationBanner);
      }
    });
  }

  void _handleNotificationNavigation(Map<String, dynamic> data) {
    var type = data['type'];
    if (type == "product") {
      print("product");
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.productPage,
          arguments: getProductDataAttributeMap(data['name'] ?? "", data['id'] ?? ""));
    } else if (type == "category") {
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
        arguments: getCatalogMap(
            data['id'] ?? "",
            data['name'] ?? "",
            "",
            false),
      );
    } else if (type == AppConstant.chatTypeNotification) {
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.deliveryboyHelpChatScreen,
          arguments: getNotificationArguments(
              data["accountType"] ?? "",
              data["senderId"] ?? ""
          ));
    } else if (type == AppConstant.customTypeNotification) {
      Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
        arguments: getCatalogMap(
            data['id'] ?? "",
            data['name'] ?? "",
            "",
            false),
      );
    }
  }

  void checkInitialMessage(BuildContext context) {
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      print("open app data");
      if (message?.data != null && appStoragePref.getAllowAllNotifications()) {

        print("payload==> ${message?.data}" );
        var notificationModelMap = message!.data;
        var notificationType = notificationModelMap["notificationType"];

        if (notificationType ==  AppConstant.productTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.of(navigatorKey.currentContext!).pushNamed(
            AppRoutes.productPage,
            arguments: getProductDataAttributeMap(
              notificationModelMap["productName"] ?? "",
              notificationModelMap["productId"] ?? "",
            ),
          );

        } else if (notificationType ==  AppConstant.categoryTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
              arguments: getCatalogMap(
                notificationModelMap["categoryId"] ?? "",
                notificationModelMap["categoryName"] ?? "",
                BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                false,
              ));

        } else if (notificationType ==  AppConstant.customTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.catalog,
              arguments: getCatalogMap(
                notificationModelMap["id"] ?? "",
                notificationModelMap["title"] ?? "",
                BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                false,
              ));

        } else if (notificationType ==  AppConstant.otherTypeNotification && appStoragePref.getAllowOfferNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.cmsPage,
              arguments: getCmsPageArguments(
                  notificationModelMap["id"] ?? "",
                  notificationModelMap["title"] ?? ""
              ));

        } else if (notificationType ==  AppConstant.chatTypeNotification) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.deliveryboyHelpChatScreen,
              arguments: getNotificationArguments(
                  notificationModelMap["accountType"] ?? "",
                  notificationModelMap["senderId"] ?? ""
              ));
        } else if (notificationType ==  AppConstant.orderTypeNotification && appStoragePref.getAllowOrderNotifications()) {
          Navigator.pushNamed(navigatorKey.currentContext!, AppRoutes.orderDetail,
              arguments: notificationModelMap["incrementId"] ?? ""
          );

        }
      }
    });
  }

  void _iosPermission() {
    _firebaseMessaging
        .requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    )
        .then((value) {
      print("Settings registered: $value");
    });
  }
}
