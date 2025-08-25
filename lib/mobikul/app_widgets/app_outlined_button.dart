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
import 'package:test_new/mobikul/configuration/mobikul_theme.dart';
import '../constants/app_constants.dart';

Widget appOutlinedButton(
  BuildContext context,
  VoidCallback onPressed,
  String text, {
  double? width,
  double? height,
  Color? textColor,
  Color? backgroundColor,
  double borderRadius = 10,
}) {
  return SizedBox(
    height: AppSizes.genericButtonHeight,
    child: OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: Size((width != null) ? width : AppSizes.deviceWidth,
            (height != null) ? height : AppSizes.deviceHeight / 16),
      ),
      child: Text(
        text,
        // style: Theme.of(context).textTheme.button,
      ),
    ),
  );
}

Widget appRoundcornerButton(BuildContext context,
    VoidCallback onPressed,
    String text, {
      double? width,
      double? height,
      Color? textColor,
      Color? backgroundColor,
      double borderRadius = 10,
    }){
  return SizedBox(
    width: double.infinity, // full-width button
    height: 55, // button height
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14.0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: backgroundColor ?? const Color(0xFF4285F4),//const Color(0xFF4285F4), // Google Blue
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(18), // rounded corners
          ),
          elevation: 0, // flat design
        ),
        onPressed: onPressed,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(width: 12),
             Text(
              text,
              style: TextStyle(
                color: Colors.white,
                fontFamily: "Montserrat",
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
