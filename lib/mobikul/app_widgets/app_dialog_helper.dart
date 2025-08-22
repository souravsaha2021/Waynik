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

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';

import '../constants/app_constants.dart';
import '../constants/app_string_constant.dart';
import '../helper/app_localizations.dart';
import '../helper/utils.dart';
import '../models/shipment_view/shipment_view_model.dart';
import 'app_alert_message.dart';
import 'app_text_field.dart';

class AppDialogHelper {
  static quantityDialog(BuildContext context, AppLocalizations? localizations,
      {ValueChanged<String>? onSave, String? initialValue}) {
    // initial value 0
    final TextEditingController textEditingController =
    TextEditingController(text: initialValue ?? "0");
    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSizes.size16, AppSizes.size16, AppSizes.size16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                localizations?.translate(AppStringConstant.enterQuantity) ?? "",
                style: const TextStyle(fontSize: 22),
              ),
              const SizedBox(height: AppSizes.size8),
              TextField(
                style: Theme.of(context).textTheme.bodyMedium,
                controller: textEditingController,
                keyboardType: TextInputType.number,
                inputFormatters: <TextInputFormatter>[
                  FilteringTextInputFormatter.digitsOnly
                ],
                maxLength: 7,
                decoration: InputDecoration(
                  contentPadding:
                  const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  hintText:
                  localizations?.translate(AppStringConstant.quantity) ??
                      "",
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(
                        color: Colors.grey,
                      )),
                  //
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(color: Colors.grey),
                  ),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey, width: 1.5)),
                ),
              ),
              const Divider(
                thickness: 2,
              ),
              Row(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                        localizations?.translate(AppStringConstant.cancel) ??
                            "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),),
                    ),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        if (onSave != null && textEditingController.text.trim().isNotEmpty) {
                          if (int.parse(textEditingController.text.trim()) > 0) {
                            onSave(textEditingController.text);
                            Navigator.of(ctx).pop();
                          } else {
                            WidgetsBinding.instance?.addPostFrameCallback((_) {
                              AlertMessage.showError(AppStringConstant.enterValidQty ?? '', context);
                            });
                          }
                        }
                      },
                      child: Text(
                        localizations?.translate(AppStringConstant.save) ?? "",
                        style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }

  static confirmationDialog(
      String text, BuildContext context, AppLocalizations? localizations,
      {VoidCallback? onConfirm,
        VoidCallback? onCancel,
        String? title,
        bool? barrierDismissible}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (ctx) => AlertDialog(
        title: (title != null)
            ? Text(localizations?.translate(title) ?? '',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: AppSizes.textSizeMedium),
        )
            : null,
        content: Text(
          localizations?.translate(text) ?? "",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        actions: <Widget>[
          OutlinedButton(
              onPressed: () {
                Navigator.of(ctx).pop();
                if (onCancel != null) {
                  onCancel();
                }
              },
              child: Text(
                (localizations?.translate(AppStringConstant.cancel) ?? "")
                    .toUpperCase(),
                // style: Theme.of(context)
                //     .textTheme
                //     .button,
              )),
          ElevatedButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.ok) ?? "")
                  .toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Theme.of(context).textTheme?.labelLarge?.color),
            ),
          ),
        ],
      ),
    );
  }

  /// information dialog
  static informationDialog(
      String text, BuildContext context, AppLocalizations? localizations,
      {VoidCallback? onConfirm, String? title, bool? barrierDismissible}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (ctx) => AlertDialog(
        title: (title != null)
            ? Text(localizations?.translate(title) ?? '',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: AppSizes.textSizeMedium),
        )
            : null,
        content: Text(
          localizations?.translate(text) ?? "",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.ok) ?? "")
                  .toUpperCase(),
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  /// retry dialog
  static errorDialog(
      String text, BuildContext context, AppLocalizations? localizations,
      {
        String? title,
        bool? cancelable,
        VoidCallback? onConfirm,
        VoidCallback? onDismiss,
        bool? barrierDismissible}) {
    showDialog(
      context: context,
      barrierDismissible: barrierDismissible ?? false,
      builder: (ctx) => AlertDialog(
        title: (title != null)
            ? Text(localizations?.translate(title) ?? '',
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: AppSizes.textSizeMedium),
        )
            : null,
        content: Text(
          localizations?.translate(text) ?? "",
          style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        actions: <Widget>[
          if (cancelable??false) TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onDismiss != null) {
                onDismiss();
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.cancel) ?? "")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              (localizations?.translate(AppStringConstant.tryAgain) ?? "")
                  .toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  static locationPermissionDialog(String text, BuildContext context,
      {VoidCallback? onConfirm}) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(
          AppStringConstant.useYourLocation.localized(),
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontSize: AppSizes.textSizeMedium),
        ),
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              text.localized() ?? "",
            ),
            TextButton.icon(
              onPressed: () {
                // SplashScreenModel? model =
                // AppSharedPref().getSplashData();
                // Navigator.push(
                //     context,
                //     MaterialPageRoute(
                //         builder: (context) =>
                //             PrivacyPolicy(model?.privacyPolicyUrl)));
              },
              icon: Icon(
                Icons.privacy_tip_sharp,
                color: Theme.of(context).iconTheme.color,
              ),
              label: Text(AppStringConstant.privacyPolicy.localized(),
                  style: Theme.of(context).textTheme.labelLarge),
            ),
          ],
        ),
        actions: <Widget>[
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
            },
            child: Text(
              AppStringConstant.cancel.localized().toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
          TextButton(
            onPressed: () {
              Navigator.of(ctx).pop();
              if (onConfirm != null) {
                onConfirm();
              }
            },
            child: Text(
              AppStringConstant.ok.localized().toUpperCase(),
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  //===============Search Screen Text/Image selection=========//
  static searchDialog(BuildContext context, AppLocalizations? localizations,
      GestureTapCallback onImageTap, GestureTapCallback onTextTap) {
    showDialog(
      useSafeArea: true,
      barrierDismissible: true,
      context: context,
      builder: (ctx) => AlertDialog(
        // titlePadding: const EdgeInsets.all(AppSizes.genericPadding),
        title: Text(
            localizations?.translate(AppStringConstant.searchByScanning) ?? "",
            style: Theme.of(context)
                .textTheme
                .bodyLarge
                ?.copyWith(color: AppColors.lightGray)),
        backgroundColor: Theme.of(context).canvasColor,
        contentPadding: const EdgeInsets.all(AppSizes.size16),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            InkWell(
              onTap: onTextTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.format_color_text),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.size16),
                    child: Text(
                        localizations
                            ?.translate(AppStringConstant.textSearch) ??
                            "",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: onImageTap,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const Icon(Icons.image_search),
                  Padding(
                    padding: const EdgeInsets.all(AppSizes.size16),
                    child: Text(
                        localizations
                            ?.translate(AppStringConstant.imageSearch) ??
                            "",
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static shipmentTrackDialog(
      BuildContext context, List<TrackingListData>? trackingListData,
      {VoidCallback? onConfirm,
        VoidCallback? onCancel,
        String? title,
        bool? barrierDismissible}) {
    Widget getListItem(String? key, String? value) {
      return Row(
        children: [
          Expanded(child: Text(key!)),
          const Text(" "),
          Expanded(
              child: Text(
                value!,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.bodyLarge?.copyWith(fontSize: AppSizes.textSizeMedium),
              )),
        ],
      );
    }

    return showDialog(
      context: context,
      builder: (ctx) => Dialog(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(
              AppSizes.size16, AppSizes.size16, AppSizes.size16, 0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                Utils.getStringValue(
                    context, (AppStringConstant.trackingInformation)) ??
                    "",
                style: const TextStyle(fontSize: 22),
              ),

              const SizedBox(
                height: AppSizes.size16,
              ),

              const Divider(
                thickness: 1,
                height: 1,
              ),

              // getListItem(trackingListData?.title, trackingListData?.number),

              const SizedBox(
                height: AppSizes.size16,
              ),

              const Divider(
                thickness: 1,
                height: 1,
              ),
              Column(
                children: <Widget>[
                  Expanded(
                    child: TextButton(
                      onPressed: () {
                        Navigator.of(ctx).pop();
                      },
                      child: Text(
                          Utils.getStringValue(
                              context, AppStringConstant.closeWindow) ??
                              "",
                          style: Theme.of(context).textTheme.bodyLarge),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
