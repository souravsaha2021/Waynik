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
import 'package:test_new/mobikul/models/productDetail/product_review_data.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/rating_container.dart';

import '../../../constants/app_constants.dart';

Widget reviewListItemCard(ProductReviewData? reviewData, BuildContext context,
    ) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.min,
    children: [
      const Divider(),
      Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          if((reviewData?.ratings ?? []).isNotEmpty)...[
            RatingContainer(double.parse((reviewData?.ratings?.first.value.toString()) ?? "0.0")),
          ]else ...[
            RatingContainer(double.parse("0.0")),
          ],
          const  SizedBox(
            width: AppSizes.size4 ,
          ),
          if((reviewData?.title ?? "") != "")
            Text(
              '${reviewData?.title}',
              style: Theme.of(context).textTheme.titleLarge,
            )
        ],
      ),
      const SizedBox(
        height: AppSizes.size8,
      ),
      Flexible(child: Text("${reviewData?.details}")),
      const SizedBox(
        height: AppSizes.size8,
      ),
      Text(
        '${reviewData?.reviewBy}',
        style: Theme.of(context).textTheme.bodySmall?.copyWith(
            fontWeight: FontWeight.w700,
            color: Theme.of(context).textTheme.displaySmall?.color),
      ),
      const SizedBox(
        height: AppSizes.size8,
      ),
      Text(
        '${reviewData?.reviewOn}',
        style: Theme.of(context).textTheme.bodySmall,
      ),
      const SizedBox(
        height: AppSizes.size8,
      ),
    ],
  );
}
