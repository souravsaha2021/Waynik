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
import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/mobikul/helper/app_storage_pref.dart';
import '../constants/app_constants.dart';

class GraphQlApiCalling {
  final loggerLink = LoggerLink();
  final authLink = AuthLink(
    getToken: ()async{
      return 'Basic ${base64.encode(utf8.encode('${ApiConstant.apiKey}:${ApiConstant.apiPassword}'))}';
    }
  );
  final httpLink = HttpLink(
    '${appStoragePref.getWebsiteUrl()}/graphql',
      defaultHeaders: {
        'Content-Type': 'application/json',
        'Accept-Charset': 'utf-8',
        'current-currency': appStoragePref.getCurrencyCode(),
        'Platform': Platform.isAndroid? "android" : "iOS",
        'Authorization': 'Basic ${base64.encode(utf8.encode('${ApiConstant.apiKey}:${ApiConstant.apiPassword}'))}',
      },
  );

  GraphQLClient clientToQuery() {
    debugPrint("HEADER ----------------------------> ${httpLink.defaultHeaders}");
    return GraphQLClient(
      cache: GraphQLCache(store: HiveStore()),
      link: loggerLink.concat(authLink.concat(httpLink)),
    );
  }
}

class LoggerLink extends Link {
  @override
  Stream<Response> request(Request request, [NextLink? forward]) {
    debugPrint("BASE URL ----------------------------> ${ApiConstant.baseUrl}");
    log("OPERATION ----------------------------> ${request.operation}");
    return forward!(request);
  }
}
