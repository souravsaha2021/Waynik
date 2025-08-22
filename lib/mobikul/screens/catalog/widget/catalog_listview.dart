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
import 'package:test_new/mobikul/models/categoryPage/product_tile_data.dart';

import '../../../app_widgets/image_view.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../category/widgets/category_products.dart';
import 'item_catalog_product_list.dart';

class CatalogListView extends StatelessWidget {
  final List<ProductTileData>? products;
  final ScrollController? controller;

  const CatalogListView({this.products, this.controller, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      controller: controller,
      shrinkWrap: true,
      itemCount: (products?.length ?? 0),
      itemBuilder: (BuildContext context, int index) {
        if (index == products?.length) {
          return const Padding(
            padding: EdgeInsets.only(top: AppSizes.size6, bottom: AppSizes.size6),
            child: Center(
              child: SizedBox(
                width: AppSizes.size30,
                height: AppSizes.size30,
                child: CircularProgressIndicator(
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.grey),
                ),
              ),
            ),
          );
        }

        var product = products?[index];
        if (!(mainBox?.containsKey("ProductPageData:${product?.entityId ?? 0}" ?? "") == true)) {
          precCacheProductPage((product?.entityId ?? 0).toString() ?? "");
        }        return GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPage,
              arguments: getProductDataAttributeMap(
                product?.name ?? "",
                product?.entityId.toString() ?? "",
              ),
            );
          },
          child: ItemCatalogProductList(
            product: products![index],
            isSelected: false,
          ),
        );
      },
    );
  }
}
