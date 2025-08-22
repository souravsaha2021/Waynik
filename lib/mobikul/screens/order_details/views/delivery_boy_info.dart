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
import 'package:test_new/mobikul/helper/app_localizations.dart';

import '../../../app_widgets/image_view.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/app_string_constant.dart';
import '../../../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../../../models/order_details/order_detail_model.dart';
import 'item_assigned_delivery_boy.dart';
import 'order_heading_view.dart';

Widget deliveryBoyInfo(BuildContext context, AppLocalizations? localizations,
    DeliveryBoyDetailsModel deliveryBoyDetailsModel, OrderDetailModel? _orderModel) {
  return orderHeaderLayout(
      context,
      localizations?.translate(AppStringConstant.deliveryBoyDetails) ?? "",
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.spacingHuge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: AppSizes.spacingGeneric,
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (ctx, index) =>
                  ItemAssignedDeliveryBoy(deliveryBoyDetailsModel!.assignedDeliveryBoyDetails![index], localizations, _orderModel,deliveryBoyDetailsModel?.customerAddress),
              itemCount: (deliveryBoyDetailsModel!.assignedDeliveryBoyDetails!.length ?? 0),
            ),
          ],
        ),
      ));
}
