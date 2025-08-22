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

import 'dart:developer';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:retrofit/http.dart';
import 'package:dio/adapter.dart';
import 'package:test_new/mobikul/models/base_model.dart';

import '../constants/app_constants.dart';
import '../models/google_place_model.dart';
import 'interceptors.dart';
part 'api_client_retrofit.g.dart';

@RestApi(baseUrl: ApiConstant.webUrl)
abstract class ApiClientRetrofit{
  factory ApiClientRetrofit({String? baseUrl}) {
    Dio dio = Dio();
    dio.options = BaseOptions(
        receiveTimeout: 50000,
        connectTimeout: 50000,
        baseUrl: ApiConstant.webUrl);
    dio.options.headers["Content-Type"] = "application/json";
    // dio.options.headers["Authorization"] = ApiConstant.authToken;
    dio.interceptors.add(LogInterceptor(
        request: true,
        requestBody: true,
        requestHeader: true,
        responseBody: true,
        responseHeader: true,
        logPrint: (b) {
          log(b.toString());
        }));
    dio.interceptors.add(InterceptorsWrapper(onRequest: (options, handler) {
      return handler.next(options);
    }, onResponse: (response, handler) async {
      // print(response);
      log("Response::: $response");
      return handler.next(response);
    }, onError: (DioError e, handler) {
      return handler.next(e);
    }));
    dio.interceptors.add(EncodingInterceptor());
    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate = (HttpClient client) {
      client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
      return client;
    };
    return _ApiClientRetrofit(dio, baseUrl: baseUrl);
  }

  @GET(ApiConstant.googlePlace)
  Future<GooglePlaceModel> getGooglePlace(@Path() String endPoint);

  @FormUrlEncoded()
  @POST(ApiConstant.updateToken)
  Future<BaseModel> getUpdateToken(
      @Field("userId") String userId,
      @Field("name") String username,
      @Field("avatar") String avatar,
      @Field("token") String token,
      @Field("accountType") String accountType,
      @Field("os") String os,
      @Field("sellerId") String sellerId
      );
}