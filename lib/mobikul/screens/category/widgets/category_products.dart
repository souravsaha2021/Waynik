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
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/category/widgets/view_all.dart';

import '../../../app_widgets/loader.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/PreCacheApiHelper.dart';
import '../../../models/catalog/request/catalog_product_request.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import '../../../models/productDetail/product_detail_page_model.dart';
import '../../../network_manager/api_client.dart';
import '../../home/widgets/category_widget_type1.dart';
import '../../home/widgets/item_card.dart';


Widget buildCategoryProducts(
    List<ProductTileData> products,
    BuildContext context,
    bool? isLoading,
    String? categoryId,
    String categoryName) {

//mobikul  pre-cache
  Map<String,String>? sort =  Map<String,String>();
  var req = CatalogProductRequest(page: 1, id: categoryId, type:BUNDLE_KEY_CATALOG_TYPE_CATEGORY,sortData: sort,filterData: []);
  preCacheGetCatalogProducts(req);

  return (isLoading ?? false)
      ? const Loader()
      : Visibility(
          visible: products.isNotEmpty,
          child: Container(
            color: Theme.of(context).cardColor,
            child: Padding(
              padding: const EdgeInsets.all(AppSizes.size16),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(AppSizes.size8 / 2),
                        decoration: BoxDecoration(
                          borderRadius:
                              BorderRadius.circular(AppSizes.size8 / 2),
                        ),
                        child: Text(
                          Utils.getStringValue(
                              context, AppStringConstant.products),
                          style: Theme.of(context)
                              .textTheme
                              .titleLarge
                              ?.copyWith(fontSize: AppSizes.textSizeMedium),
                        ),
                      ),
                      viewAllButton(context, () {
                        Navigator.pushNamed(context, AppRoutes.catalog,
                            arguments: getCatalogMap(
                              categoryId ?? "",
                              categoryName,
                              BUNDLE_KEY_CATALOG_TYPE_CATEGORY,
                              false,
                            ));
                      }),
                    ],
                  ),
                  const SizedBox(
                    height: AppSizes.size8,
                  ),
                  SizedBox(
                    width: AppSizes.deviceWidth.toDouble(),
                    height:(AppSizes.deviceWidth <= AppSizes.maxDeviceWidth) ? AppSizes.calculatedListHeight : AppSizes.calculatedMediumDeviceGridHeight,
                    //(AppSizes.deviceWidth <= AppSizes.maxDeviceWidth) ? (((AppSizes.deviceWidth-AppSizes.spacingMedium)/AppSizes.gridProductCount)* AppSizes.imageHeightRation)+AppSizes.gridHeightForSmallDevice : (((AppSizes.deviceWidth-AppSizes.spacingMedium)/AppSizes.gridProductCount)*AppSizes.imageHeightRation)+AppSizes.gridHeight,

                    // height: ((AppSizes.deviceWidth-16)/2)+65,
                    child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: products.length,
                        itemBuilder: (BuildContext context, int index) {
                          var data = products[index];

                          //mobikul  pre-cache
                          if (!(mainBox?.containsKey("ProductPageData:${data.entityId}" ?? "")== true)) {
                            precCacheProductPage(data.entityId.toString() ?? "");
                          }
                          return GestureDetector(
                            onTap: () {
                              Navigator.of(context).pushNamed(
                                AppRoutes.productPage,
                                arguments: getProductDataAttributeMap(
                                  data.name ?? "",
                                  data.entityId.toString() ?? "",
                                ),
                              );
                            },
                            child: ItemCard(
                              product: data,
                              imageSize: (((AppSizes.deviceWidth-AppSizes.spacingMedium)/AppSizes.gridRationtwo))
                              // (AppSizes.deviceWidth -
                              //         (AppSizes.size8 + AppSizes.size8)) /
                              //     2.5,
                            ),
                          );
                        }),
                  ),
                ],
              ),
            ),
          ),
        );
}
