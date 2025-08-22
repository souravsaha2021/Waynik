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
import 'package:test_new/mobikul/constants/app_constants.dart';

import '../../../../configuration/mobikul_theme.dart';

Widget addNewAddress(
  BuildContext context,
  String title,
  VoidCallback callback,
) {
  return Padding(
    padding: const EdgeInsets.all(AppSizes.size8),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Expanded(
            flex: 1,
            child: InkWell(
              onTap: callback,
              child: Row(
                // mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.add,
                    size: 22,
                    color: Theme.of(context).iconTheme.color,
                  ),
                  const SizedBox(
                    width: AppSizes.linePadding,
                  ),
                  Expanded(
                    child: Text(title.toUpperCase(),
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        overflow: TextOverflow.ellipsis,
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge
                            ?.copyWith(fontSize: AppSizes.textSizeTiny, fontWeight: FontWeight.bold)),
                  )
                ],
              ),
            )),
      ],
    ),
  );
}
