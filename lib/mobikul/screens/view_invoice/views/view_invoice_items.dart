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
import 'package:test_new/mobikul/models/downloadable_products/downloadable_products_list_model.dart';

import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/app_string_constant.dart';
import '../../../helper/utils.dart';
import '../../../models/invoice_view/invoice_view_model.dart';
import '../../../network_manager/download_file.dart';

Widget ViewInvoiceItems(BuildContext context, ItemListData? item) {
  Widget getListItem(String key, String? value) {
    return Row(
      children: [
        SizedBox(width: 110, child: Text(key)),
        Text(
          value!,
          textAlign: TextAlign.start,
          style: Theme.of(context).textTheme.headlineSmall,
        ),
      ],
    );
  }

  return Padding(
    padding: const EdgeInsets.only(bottom: 10.0),
    child: Container(
      decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Text(
              item?.name?.toString() ?? " ",
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(fontSize: AppSizes.textSizeMedium),
            ),
            const Divider(),
            getListItem(
                Utils.getStringValue(context, AppStringConstant.qtyColon),
                item?.qty?.toString()),
            const SizedBox(
              height: AppSizes.size8,
            ),
            getListItem(
                Utils.getStringValue(context, AppStringConstant.priceColon),
                item?.price?.toString()),
            const SizedBox(
              height: AppSizes.size8,
            ),
            getListItem(
                Utils.getStringValue(context, AppStringConstant.subtotalColon),
                item?.subTotal?.toString()),
            const SizedBox(
              height: AppSizes.size8,
            ),
          ],
        ),
      ),
    ),
  );
}
