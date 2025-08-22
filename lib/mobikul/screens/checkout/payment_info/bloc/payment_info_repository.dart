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
import 'dart:developer';

import 'package:flutter/services.dart';
import 'package:test_new/mobikul/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/mobikul/models/checkout/place_order/place_order_model.dart';

import '../../../../helper/push_notifications_manager.dart';
import '../../../../models/base_model.dart';
import '../../../../models/checkout/place_order/billing_data_request.dart';
import '../../../../models/checkout/shipping_info/shipping_address_model.dart';
import '../../../../network_manager/api_client.dart';

abstract class PaymentInfoScreenRepository{
  Future<PaymentInfoModel> getPaymentInfo(String shippingMethod);
  Future<ShippingAddressModel> getCheckoutAddress();
  Future<PlaceOrderModel> placeOrder(String paymentMethod, BillingDataRequest billingData);
  Future<BaseModel> applyCoupon(String couponCode, int remove);
  Future<BaseModel> updatePaymentStatus(String referenceId);
}

class PaymentInfoScreenRepositoryImp implements PaymentInfoScreenRepository{
  @override
  Future<PaymentInfoModel> getPaymentInfo(String shippingMethod) async{
    PaymentInfoModel? responseData;
    try{
      responseData = await ApiClient().reviewAndPayment(shippingMethod);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<ShippingAddressModel> getCheckoutAddress() async {
    ShippingAddressModel? responseData;
    try{
      responseData = await ApiClient().checkoutAddress();
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<PlaceOrderModel> placeOrder(String paymentMethod, BillingDataRequest billingData) async{
    PlaceOrderModel? responseData;
    try{
      var firebaseToken = await PushNotificationsManager().createFcmToken();
      print("deviceId==>$firebaseToken");
      responseData = await ApiClient().placeOrder(paymentMethod, billingData, firebaseToken??"");
      log("ResponseData===>${responseData?.toJson()}");
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<BaseModel> applyCoupon(String couponCode, int remove) async{
    BaseModel? responseData;
    try{
      responseData = await ApiClient().applyCoupon(couponCode, remove);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }

    return responseData!;
  }

  @override
  Future<BaseModel> updatePaymentStatus(String referenceId) async {
    BaseModel? responseData;
    try{
      responseData = await ApiClient().updatePaymentStatus(referenceId);
      print("sdhg==>${responseData}");
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }
}