
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

import 'package:flutter/services.dart';

import '../../../models/homePage/add_to_wishlist_response.dart';
import '../../../models/homePage/home_screen_model.dart';
import '../../../network_manager/api_client.dart';

abstract class HomeScreenRepository{

  Future<HomePageData> getHomePageData(bool isRefresh);
  Future<HomePageData> getCartCount();
}

class HomeScreenRepositoryImp extends HomeScreenRepository{
  @override
  Future<HomePageData> getHomePageData(bool isRefresh) async {
    HomePageData? responseData;
    try{
      responseData = await ApiClient().getHomePageData(isRefresh);
    }
    catch(error,stacktrace){
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseData!;
  }

  @override
  Future<HomePageData> getCartCount() async {
    HomePageData? responseData;
    try{
      responseData = await ApiClient().getCartCount();
    }
    catch(error,stacktrace){
      print("Error --> " + error.toString());
      print("StackTrace --> " + stacktrace.toString());
    }
    return responseData!;
  }

}