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

// import 'dart:convert';
//
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:html_unescape/html_unescape.dart';
// import 'package:webview_flutter/webview_flutter.dart';
//
// import '../../app_widgets/app_alert_message.dart';
// import '../../app_widgets/loader.dart';
// import '../../constants/app_constants.dart';
// import '../../constants/arguments_map.dart';
// import '../../models/cms_page/cms_page_model.dart';
// import 'bloc/cms_page_bloc.dart';
// import 'bloc/cms_page_event.dart';
// import 'bloc/cms_page_state.dart';
//
// class CmsPage extends StatefulWidget {
//   final Map<String, dynamic> arguments;
//
//   CmsPage(this.arguments,{Key? key}) : super(key: key);
//
//   @override
//   State<CmsPage> createState() => _CmsPageState();
// }
//
// class _CmsPageState extends State<CmsPage> {
//   CmsPageBloc? _cmsPageBloc;
//   bool isLoading = true;
//   CmsPageModel? _model;
//   late final WebViewController _controller;
//
//   @override
//   void initState() {
//     _cmsPageBloc = context.read<CmsPageBloc>();
//     _cmsPageBloc?.add(CmsPageDetailsEvent(widget.arguments[cmsPageId]));
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Theme.of(context).colorScheme.background,
//       appBar: AppBar(
//         title: Html(
//           data:  widget.arguments[cmsPageTitle]??'',style: {
//           "body": Style(
//             fontSize:  FontSize(AppSizes.textSizeLarge),
//              color: Theme.of(context).textTheme.bodySmall?.color
//           ),
//         },),
//       ),
//       body: mainView(),
//     );
//   }
//
//   Widget mainView() {
//     return BlocBuilder<CmsPageBloc, CmsPageState>(
//         builder: (BuildContext context, CmsPageState currentState) {
//           if (currentState is CmsPageLoadingState) {
//             isLoading = true;
//           } else if (currentState is CmsPageSuccessState) {
//             isLoading = false;
//             _model = currentState.data;
//           } else if (currentState is CmsPageErrorState) {
//             isLoading = false;
//             WidgetsBinding.instance?.addPostFrameCallback((_) {
//               AlertMessage.showError(
//                   currentState.message ?? '', context);
//             });
//           }
//           return _buildUI();
//         });  }
//
//   Widget _buildUI() {
//     return Stack(
//       children: [
//         Visibility(
//           visible: !isLoading,
//           // child:SingleChildScrollView(
//           //   child: Html(
//           //     data: _model?.content ?? "",
//           //   ),
//           // ),
//           child: WebView(
//             initialUrl: "",
//             javascriptMode: JavascriptMode.unrestricted,
//             onWebViewCreated: (c) {
//               _loadHtmlFromAssets(c);
//             },
//           ),
//         ),
//         Visibility(visible: isLoading, child: const Loader())
//       ],
//     );
//   }
//   _loadHtmlFromAssets(_controller) async {
//     String fileText = _model?.content??"" ;
//     HtmlUnescape unescape = HtmlUnescape();
//     String jsonString = unescape.convert(fileText);
//     _controller?.loadUrl(Uri.dataFromString("""<!DOCTYPE html>
//     <html>
//       <head><meta name="viewport" content="width=device-width, initial-scale=1.0">
//       <style>
//         body {
//             margin: 0;
//             padding: 0;
//         }
//         img {
//             width: 100%;  /* Makes the image responsive */
//             height: auto; /* Maintains aspect ratio */
//             max-height: 50vh; /* Adjust this value based on your needs */
//         }
//         .container {
//             padding: 20px; /* Add padding if needed */
//         }
//     </style>
//       </head>
//       <body style='"margin: 0; padding: 0;'>
//         <div>
//           $jsonString
//         </div>
//       </body>
//     </html>""", mimeType: 'text/html', encoding: Encoding.getByName('utf-8'))
//
//         .toString());
//   }
//
// }

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:html_unescape/html_unescape.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/loader.dart';
import '../../constants/app_constants.dart';
import '../../constants/arguments_map.dart';
import '../../models/cms_page/cms_page_model.dart';
import 'bloc/cms_page_bloc.dart';
import 'bloc/cms_page_event.dart';
import 'bloc/cms_page_state.dart';

class CmsPage extends StatefulWidget {
  final Map<String, dynamic> arguments;

  const CmsPage(this.arguments, {Key? key}) : super(key: key);

  @override
  State<CmsPage> createState() => _CmsPageState();
}

class _CmsPageState extends State<CmsPage> {
  CmsPageBloc? _cmsPageBloc;
  bool isLoading = true;
  CmsPageModel? _model;
  late final WebViewController _controller;

  @override
  void initState() {
    super.initState();
    _cmsPageBloc = context.read<CmsPageBloc>();
    _cmsPageBloc?.add(CmsPageDetailsEvent(widget.arguments[cmsPageId]));

    _controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Html(
          data: widget.arguments[cmsPageTitle] ?? '',
          style: {
            "body": Style(
              fontSize: FontSize(AppSizes.textSizeLarge),
              color: Theme.of(context).textTheme.bodySmall?.color,
            ),
          },
        ),
      ),
      body: mainView(),
    );
  }

  Widget mainView() {
    return BlocBuilder<CmsPageBloc, CmsPageState>(
      builder: (BuildContext context, CmsPageState currentState) {
        if (currentState is CmsPageLoadingState) {
          isLoading = true;
        } else if (currentState is CmsPageSuccessState) {
          isLoading = false;
          _model = currentState.data;
          _loadHtmlToWebView();
        } else if (currentState is CmsPageErrorState) {
          isLoading = false;
          WidgetsBinding.instance.addPostFrameCallback((_) {
            AlertMessage.showError(currentState.message ?? '', context);
          });
        }
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        Visibility(
          visible: !isLoading,
          child: WebViewWidget(controller: _controller),
        ),
        Visibility(visible: isLoading, child: const Loader()),
      ],
    );
  }

  Future<void> _loadHtmlToWebView() async {
    final fileText = _model?.content ?? "";
    final HtmlUnescape unescape = HtmlUnescape();
    final jsonString = unescape.convert(fileText);

    final htmlContent = """
    <!DOCTYPE html>
    <html>
      <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <style>
          body {
              margin: 0;
              padding: 0;
          }
          img {
              width: 100%;   /* Makes the image responsive */
              height: auto;  /* Maintains aspect ratio */
              max-height: 50vh;
          }
          .container {
              padding: 20px;
          }
        </style>
      </head>
      <body style="margin: 0; padding: 0;">
        <div>
          $jsonString
        </div>
      </body>
    </html>
    """;

    await _controller.loadHtmlString(htmlContent);
  }
}



