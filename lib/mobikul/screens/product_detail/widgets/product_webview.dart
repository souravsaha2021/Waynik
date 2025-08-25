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

/*import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductsWebView extends StatefulWidget {
  String description;

  ProductsWebView(this.description, {Key? key}) : super(key: key);
  @override
  _ProductsWebViewState createState() => _ProductsWebViewState(this.description);
}

class _ProductsWebViewState extends State<ProductsWebView> {
  WebViewController? _webViewController;
  String description;

  _ProductsWebViewState(this.description);

  _loadHtml(){
    _webViewController!.loadRequest(Uri.dataFromString("<h1>$description</h1>", mimeType: 'text/html',encoding: Encoding.getByName('utf-8')));

  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color:  Theme.of(context).colorScheme.background,
      // height: MediaQuery.of(context).size.height/5,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(AppSizes.size8),
      child: WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            _loadHtml();
          }
      ),
    );
  }
}*/


import 'package:flutter/material.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:webview_flutter/webview_flutter.dart';

class ProductsWebView extends StatefulWidget {
  final String description;

  const ProductsWebView(this.description, {Key? key}) : super(key: key);

  @override
  _ProductsWebViewState createState() => _ProductsWebViewState();
}

class _ProductsWebViewState extends State<ProductsWebView> {
  late final WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _webViewController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..loadHtmlString("<h1>${widget.description}</h1>");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Theme.of(context).colorScheme.background,
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.all(AppSizes.size8),
      child: WebViewWidget(
        controller: _webViewController,
      ),
    );
  }
}

