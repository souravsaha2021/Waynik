
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
import 'package:test_new/mobikul/models/productDetail/product_detail_page_model.dart';

import '../../../models/base_model.dart';
import '../../../models/homePage/add_to_wishlist_response.dart';
import '../../../models/productDetail/add_to_cart_response.dart';
import '../../../network_manager/api_client.dart';

abstract class ProductDetailScreenRepository{

  Future<ProductDetailPageModel> getProductDetailPageData(String productId);
  Future<ProductDetailPageModel> getProductConfigurableData(String productId);
  Future<ProductDetailPageModel> getProductUpdatedData(String productId);
  Future<AddToWishlistResponse?> addToWishList(String productId);
  Future<BaseModel?> removeFromWishList(String productId);
  Future<BaseModel?> addToCompare(String productId);
  Future<AddToCartResponse?> addToCart(String productId, int qty, Map<String, dynamic> productParamsJSON,  List<dynamic> relatedProducts );
}

class ProductDetailScreenRepositoryImp extends ProductDetailScreenRepository{
  @override
  Future<ProductDetailPageModel> getProductDetailPageData(String productId) async {

    ProductDetailPageModel? responseData;
    try{
      responseData = await ApiClient().productPageData(productId);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  /// ****AddToWishList**/
  @override
  Future<AddToWishlistResponse?> addToWishList(String productId) async {

    var wishlistAllAllCartData = await ApiClient().addToWishlist(productId);
    return wishlistAllAllCartData!;
  }

  /// ****RemoveFromWishList**/
  @override
  Future<BaseModel?> removeFromWishList(String productId) async {

    var responseData = await ApiClient().removeFromWishlist(productId);
    return responseData!;
  }

  /// ****AddToCompare**/
  @override
  Future<BaseModel?> addToCompare(String productId) async {

    var responseModel = await ApiClient().addToCompare(productId);
    return responseModel!;
  }

  /// ****Add to Cart**/
  @override
  Future<AddToCartResponse?> addToCart(String productId, int qty, Map<String, dynamic>  productParamsJSON, List<dynamic> relatedProducts) async {

    var responseData = await ApiClient().addToCart(productId, qty, productParamsJSON, relatedProducts);
    return responseData!;
  }

  @override
  Future<ProductDetailPageModel> getProductConfigurableData(String productId) async {

    ProductDetailPageModel? responseData;
    try{
      responseData = await ApiClient().productConfigurableData(productId);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

  @override
  Future<ProductDetailPageModel> getProductUpdatedData(String productId) async {

    ProductDetailPageModel? responseData;
    try{
      responseData = await ApiClient().getProductUpdatedData(productId);
    }
    catch(error,stacktrace){
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
    return responseData!;
  }

}