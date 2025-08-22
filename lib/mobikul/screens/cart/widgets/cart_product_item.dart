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
import 'package:test_new/mobikul/app_widgets/image_view.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/screens/cart/widgets/quantity_drop_down.dart';

import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/widget_space.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/utils.dart';
import '../../../models/cart/cart_item.dart';
import '../bloc/cart_screen_bloc.dart';
import '../bloc/cart_screen_event.dart';
import '../bloc/cart_screen_state.dart';

class CartProductItem extends StatelessWidget {
  const CartProductItem(this.product, this.localizations, this.bloc, {Key? key})
      : super(key: key);

  final CartItem? product;
  final AppLocalizations? localizations;
  final CartScreenBloc? bloc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSizes.size12),
      child: InkWell(
        onTap: () {
          Navigator.of(context).pushNamed(
            AppRoutes.productPage,
            arguments: getProductDataAttributeMap(
              product?.name ?? "",
              product?.productId ?? "",
            ),
          );
        },
        child: Container(
          color: Theme.of(context).cardColor,
          child: Column(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(
                    right: AppSizes.size12,
                    left: AppSizes.size12,
                    top: AppSizes.size12),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    // Image and qty dropdown
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        SizedBox(
                          height: AppSizes.deviceWidth / 3.5,
                          width: AppSizes.deviceWidth / 3.5,
                          child: ImageView(
                            url: product?.image,
                          ),
                        ),
                        // SizedBox(
                        //   height: AppSizes.size26,
                        //   child: QuantityDropDown((value) async {
                        //     String operator = "";
                        //     if (int.tryParse(value)! >
                        //         (product?.qty?.toInt() ?? 1)) {}
                        //     bloc?.add(SetCartItemQuantityEvent(
                        //         product?.id ?? "", int.tryParse(value) ?? 1));
                        //     bloc?.emit(CartScreenInitial());
                        //   }, product?.qty?.toInt()
                        //       // product?.
                        //       ),
                        // ),
                      ],
                    ),

                    const SizedBox(width: AppSizes.size12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(product?.name ?? "",
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(fontWeight: FontWeight.normal)),
                          const SizedBox(height: AppSizes.size16),
                          if (product?.options?.isNotEmpty ?? false)
                            ListView.builder(
                                shrinkWrap: true,
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: product?.options?.length ?? 0,
                                itemBuilder: (context, index) {
                                  return Column(
                                    children: [
                                      Row(
                                        children: [
                                          Expanded(
                                              flex: 1,
                                              child: Text(
                                                  "${product?.options?[index].label}:")),
                                          // Expanded(
                                          //     flex: 1,
                                          //     child: Text(product
                                          //         ?.options?[index]
                                          //         .value?[0] ??
                                          //         '')),
                                          Expanded(
                                            child: Column(
                                              children: [
                                                ListView.builder(
                                                    shrinkWrap: true,
                                                    physics: const NeverScrollableScrollPhysics(),
                                                    itemCount: product?.options?[index].value?.length ?? 0,
                                                    itemBuilder: (context,
                                                        index1) {
                                                      return Text(product
                                                          ?.options?[index]
                                                          .value?[index1] ??
                                                          '');

                                                    })
                                              ],
                                            ),
                                          ),

                                          const Spacer(),
                                        ],
                                      ),
                                      const SizedBox(height: AppSizes.size8),
                                    ],
                                  );
                                }),
                          Row(
                            children: [
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    localizations?.translate(
                                        AppStringConstant.priceColon) ??
                                        "",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 14),
                                  )),
                              Expanded(
                                flex: 2,
                                child: Text(
                                    product?.formattedFinalPrice ?? "0.00",
                                    style:
                                    Theme.of(context).textTheme.titleLarge),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.size16),
                          Row(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Expanded(
                                  flex: 1,
                                  child: Text(
                                    "${localizations?.translate(AppStringConstant.subtotal) ?? ""}: ",
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(fontSize: 14),
                                  )),
                              Expanded(
                                flex: 2,
                                child: Text((product?.subTotal ?? "0.00"),
                                    style:
                                    Theme.of(context).textTheme.titleLarge),
                              ),
                            ],
                          ),
                          const SizedBox(height: AppSizes.size16),

                          Row(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Text(
                                  Utils.getStringValue(context, AppStringConstant.qtyColon),
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(fontSize: AppSizes.textSizeMedium),),
                              ),
                              // widgetSpace(1,AppSizes.spacingMax),

                              Flexible(
                                flex: 2,
                                child: Container(
                                  // width: AppSizes.spacingMax,
                                  height: AppSizes.size30,
                                  child: QuantityDropDown((value) async {
                                    var currentCount = appStoragePref.getCartCount();
                                    String operator = "";
                                    if (int.tryParse(value)! >
                                        (product?.qty?.toInt() ?? 1)) {}
                                    bloc?.add(SetCartItemQuantityEvent(
                                        product?.id ?? "", int.tryParse(value) ?? 1, currentCount));
                                    bloc?.emit(CartScreenInitial());
                                  }, product?.qty?.toInt()
                                    // product?.
                                  ),
                                ),
                              ),
                            ],
                          ),
                          widgetSpace(0,AppSizes.spacingGeneric),
                        ],
                      ),
                    ),

                    // Edit button
                    // InkWell(
                    //   onTap: () {
                    //     Navigator.of(context).pushNamed(
                    //         AppRoutes.productPage,
                    //         arguments: getProductDataAttributeMap(
                    //         product?.name?? "",
                    //         product?.productId ?? "", )); },
                    //   child: const Padding(
                    //     padding: EdgeInsets.all(AppSizes.size8),
                    //     child: Icon(Icons.edit,size: AppSizes.size16,),
                    //   ),
                    // )
                  ],
                ),
              ),
              const Divider(thickness: 1.0),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  const SizedBox(
                    width: 10.0,
                  ),
                  Expanded(
                    child: _iconButton(
                        Icons.favorite_border,
                        localizations
                                ?.translate(AppStringConstant.moveToWishlist) ??
                            "", () {
                      if (appStoragePref.isLoggedIn()) {
                        bloc?.add(CartToWishlistEvent(
                            product?.id ?? "",
                            product?.productId ?? "",
                            product?.qty.toString() ?? ""));
                        bloc?.emit(CartScreenInitial());
                      } else {
                        AppDialogHelper.confirmationDialog(
                            Utils.getStringValue(context,
                                AppStringConstant.loginRequiredToAddOnWishlist),
                            context,
                            AppLocalizations.of(context),
                            title: Utils.getStringValue(
                                context, AppStringConstant.loginRequired),
                            onConfirm: () async {
                          Navigator.of(context)
                              .pushNamed(AppRoutes.signInSignUp);
                        });
                      }
                    }, context),
                  ),
                  Expanded(
                    child: Center(
                      child: _iconButton(
                          Icons.delete_forever,
                          localizations
                                  ?.translate(AppStringConstant.removeItem) ??
                              "", () {
                        AppDialogHelper.confirmationDialog(
                          AppStringConstant.removeItemDescription,
                          context,
                          localizations,
                          onConfirm: () async {
                            bloc?.add(RemoveCartItem(product?.id ?? ""));
                            bloc?.emit(CartScreenInitial());
                            // AnalyticsEventsFirebase().removeFromCart(product?.lineId.toString() ?? "0", product?.name ?? "0",);
                          },
                          title: AppStringConstant.deleteItemFromCart,
                        );
                      }, context),
                    ),
                  ),
                  const SizedBox(
                    width: 10.0,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _iconButton(IconData icon, String title, VoidCallback onTap,
          BuildContext context) =>
      Padding(
        padding: const EdgeInsets.all(8.0),
        child: ElevatedButton(
          onPressed: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  icon,
                  color:Theme.of(context).textTheme.labelLarge?.color,

            //Colors.white,
                  size: 22,
                ),
                const SizedBox(
                  width: AppSizes.size6,
                ),
                Flexible(
                  child: Text(
                    title.toUpperCase(),
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color:Theme.of(context).textTheme.labelLarge?.color,
                          fontSize: AppSizes.textSizeTiny
                        ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 2,
                  ),
                ),
              ],
            ),
          ),
        ),
      );

  // Widget _iconButton(
  //     IconData icon,
  //     String title,
  //     VoidCallback onTap,
  //     BuildContext context) =>
  //     Container(
  //       color: Theme.of(context).cardColor,
  //       child: InkWell(
  //         onTap: onTap,
  //         child: Padding(
  //           padding: const EdgeInsets.all(AppSizes.size8),
  //           child: Row(
  //             mainAxisSize: MainAxisSize.min,
  //             children: <Widget>[
  //               Icon(icon,color: Theme.of(context).iconTheme.color,),
  //               const SizedBox(width: AppSizes.linePadding),
  //               Flexible(child: Text(title.toUpperCase(),style: Theme.of(context).textTheme.bodyText2?.copyWith(fontWeight: FontWeight.bold))),
  //             ],
  //           ),
  //         ),
  //       ),
  //     );
}
