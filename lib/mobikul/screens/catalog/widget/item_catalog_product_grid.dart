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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/screens/home/widgets/item_card_bloc/item_card_bloc.dart';

import '../../../app_widgets/app_alert_message.dart';
import '../../../app_widgets/app_dialog_helper.dart';
import '../../../app_widgets/image_view.dart';
import '../../../configuration/mobikul_theme.dart';
import '../../../constants/app_constants.dart';
import '../../../constants/app_routes.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_localizations.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../models/categoryPage/product_tile_data.dart';
import '../../home/widgets/item_card_bloc/item_card_event.dart';
import '../../home/widgets/item_card_bloc/item_card_state.dart';

class ItemCatalogProductGrid extends StatefulWidget {
  double? imageSize;
  Function? callBack;
  bool isSelected = false;

  final ProductTileData? product;

  ItemCatalogProductGrid(
      {this.product, this.imageSize, this.callBack, this.isSelected = false});

  @override
  State<ItemCatalogProductGrid> createState() => _ItemCatalogProductGridState();
}

class _ItemCatalogProductGridState extends State<ItemCatalogProductGrid> {
  bool isLoading = true;
  ItemCardBloc? itemCardBloc;

  @override
  Widget build(BuildContext ctx, {Function(String)? callback}) {
    widget.imageSize ??= AppSizes.calculatedCatalogGridHeight;
    //(((AppSizes.deviceWidth-AppSizes.spacingMedium)/AppSizes.gridProductCount));
    print("widget.imageSize---${widget.imageSize}");
        //(AppSizes.deviceWidth / 2.5) - AppSizes.size4;
    itemCardBloc = ctx.read<ItemCardBloc>();
    return BlocBuilder<ItemCardBloc, ItemCardState>(
      builder: (context, currentState) {
        if (currentState is ItemCardInitial) {
          isLoading = true;
        } else if (currentState is ItemCardErrorState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message ??
                    Utils.getStringValue(
                        context, AppStringConstant.somethingWentWrong),
                context);
          });
        } else if (currentState is AddProductToWishlistStateSuccess) {
          isLoading = false;
          if (currentState.wishListModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.wishListModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
            if (widget.product?.entityId.toString() == currentState.productId) {
              widget.product?.isInWishlist = true;
              widget.product?.wishlistItemId =
                  currentState.wishListModel.itemId;
            }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.wishListModel.message ?? '', context);
            });
          }
          itemCardBloc?.emit(ItemCardEmptyState());
        } else if (currentState is RemoveFromWishlistStateSuccess) {
          isLoading = false;
          if (currentState.baseModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel.message ?? '', context);
              itemCardBloc?.emit(WishlistIdleState());
            });
            if (widget.product?.wishlistItemId.toString() ==
                currentState.productId.toString()) {
              widget.product?.isInWishlist = false;
            }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.baseModel.message ??
                      Utils.getStringValue(
                          context, AppStringConstant.somethingWentWrong),
                  context);
            });
            itemCardBloc?.emit(ItemCardEmptyState());
          }
        }
        return buildUi(ctx);
      },
    );
  }

  Widget buildUi(BuildContext context) {
    return Container(
        width: AppSizes.catProductItemHeight,
        padding: const EdgeInsets.only(left:AppSizes.spacingGeneric,right: AppSizes.spacingGeneric,top: AppSizes.spacingGeneric),

        // padding: const EdgeInsets.all(AppSizes.spacingGeneric),
        decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[350]!)),
        child: GestureDetector(
          onTap: () {
            Navigator.of(context).pushNamed(
              AppRoutes.productPage,
              arguments: getProductDataAttributeMap(
                widget.product?.name ?? "",
                widget.product?.entityId.toString() ?? "",
              ),
            );
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Stack(children: <Widget>[
                Center(
                  child: ImageView(
                    fit: BoxFit.fill,
                    url: widget.product?.thumbNail,
                    width: widget.imageSize!,
                    height: widget.imageSize! * AppSizes.imageHeightRation,
                    borderRadius: const BorderRadius.only(
                        topRight: Radius.circular(5),
                        topLeft: Radius.circular(5)),
                  ),
                ),
                Positioned(
                  bottom: AppSizes.spacingTiny,
                  left: AppSizes.spacingGeneric,
                  child: (widget.product?.hasSpecialPrice() == true)
                      ? Container(
                          decoration: BoxDecoration(
                              color: AppColors.green,
                              //Colors.white12,
                              borderRadius: BorderRadius.circular(6),
                              border: Border.all(
                                color: Colors.white12,
                                //AppColors.green,
                              )),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: AppSizes.size2,
                                bottom: AppSizes.size2,
                                left: AppSizes.linePadding,
                                right: AppSizes.linePadding),
                            child: Text(
                              "-${widget.product?.getDiscountPercentage()}%",
                              style: TextStyle(color: AppColors.white),
                            ),
                          ),
                        )
                      : Container(),
                ),
                Positioned(
                    right: AppSizes.spacingTiny,
                    top: AppSizes.spacingTiny,
                    child: InkWell(
                      onTap: () async {
                        if (await appStoragePref.isLoggedIn()) {
                          if (widget.product?.isInWishlist != true) {
                            itemCardBloc?.add(AddToWishlistEvent(
                                widget.product?.entityId.toString()));
                          } else {
                            AppDialogHelper.confirmationDialog(
                                Utils.getStringValue(context,
                                    AppStringConstant.removeItemFromWishlist),
                                context,
                                AppLocalizations.of(context),
                                title: Utils.getStringValue(
                                    context, AppStringConstant.removeItem),
                                onConfirm: () async {
                              itemCardBloc?.add(RemoveFromWishlistEvent(
                                  widget.product?.wishlistItemId.toString()));
                            });
                          }
                        } else {
                          AppDialogHelper.confirmationDialog(
                              Utils.getStringValue(
                                  context,
                                  AppStringConstant
                                      .loginRequiredToAddOnWishlist),
                              context,
                              AppLocalizations.of(context),
                              title: Utils.getStringValue(
                                  context, AppStringConstant.loginRequired),
                              onConfirm: () async {
                            Navigator.of(context)
                                .pushNamed(AppRoutes.signInSignUp);
                          });
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(17)),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.4),
                              spreadRadius: 1,
                              blurRadius: 7,
                              offset: const Offset(
                                  0, 1), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Icon(
                          (widget.product?.isInWishlist ?? false)
                              ? Icons.favorite
                              : Icons.favorite_border_outlined,
                          color: (widget.product?.isInWishlist ?? false)
                              ? AppColors.lightRed
                              : AppColors.lightGray,
                          size: 18,
                        ),
                      ),
                    )),
              ]),
              SizedBox(
                width: widget.imageSize,
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: AppSizes.size8,
                      top: AppSizes.size8,
                      right: AppSizes.size8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        height: AppSizes.size18,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          mainAxisSize: MainAxisSize.max,
                          children: <Widget>[
                            Container(
                              width: (AppSizes.deviceWidth-32)/4.5,
                              child: Text(
                                  (widget.product?.formattedFinalPrice ?? '')
                                          .isNotEmpty
                                      ? widget.product?.formattedFinalPrice ?? ''
                                      : '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: Theme.of(context)
                                      .textTheme
                                      .displaySmall
                                      ?.copyWith(
                                          fontSize: AppSizes.textSizeMedium)),
                            ),
                            Visibility(
                                visible:
                                   (widget.product?.hasSpecialPrice() ?? false),
                                child: Row(
                                  children: [
                                    const SizedBox(
                                      width: AppSizes.linePadding,
                                    ),
                                    Container(
                                      width: (AppSizes.deviceWidth-32)/5,
                                      child: Text(widget.product?.formattedPrice ?? '',
                                          maxLines: 1,
                                          overflow: TextOverflow.ellipsis,
                                          style: Theme.of(context)
                                              .textTheme
                                              .bodyMedium
                                              ?.copyWith(
                                                  fontSize:
                                                      AppSizes.textSizeSmall)),
                                    ),
                                  ],
                                )),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: AppSizes.size4,
                      ),
                      (widget.callBack != null)
                          ? Row(
                              children: [
                                Container(
                                  height:AppSizes.spacingGeneric,
                                  child: Checkbox(
                                      value: widget.isSelected,
                                      onChanged: (value) {
                                        setState(() {
                                          widget.isSelected = !widget.isSelected;
                                        });
                                      }),
                                ),
                                Expanded(
                                  child: Text(widget.product?.name ?? '',
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium
                                          ?.copyWith(
                                              fontSize: AppSizes.textSizeSmall)
                                      // const TextStyle(fontSize: 12.0, color: Colors.black),
                                      ),
                                )
                              ],
                            )
                          : Container(
                        height: AppSizes.catalogTextContentHeight,
                        child: Text(widget.product?.name ?? '',
                                maxLines:(AppSizes.deviceWidth <= AppSizes.maxDeviceWidth) ? 2 : 1,
                                overflow: TextOverflow.ellipsis,
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(fontSize: AppSizes.textSizeSmall)
                                // const TextStyle(fontSize: 12.0, color: Colors.black),
                                ),
                          ),
                      const SizedBox(
                        height: AppSizes.spacingGeneric,
                      ),
                      if (widget.product?.rating.toString() == "0")
                        Text(
                          Utils.getStringValue(
                              context, AppStringConstant.noReviewsYet),
                          style: Theme.of(context)
                              .textTheme
                              .headlineMedium
                              ?.copyWith(fontSize: AppSizes.textSizeTiny),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.center,
                        ),
                      if (widget.product?.rating.toString() != "0")
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: AppSizes.spacingTiny,
                              vertical: AppSizes.spacingTiny),
                          color: Utils.ratingBackground(
                                  widget.product?.rating.toString() ?? '') ??
                              Colors.pink,
                          child: SizedBox(
                            height: AppSizes.size16,
                            child: Wrap(
                              alignment: WrapAlignment.center,
                              children: [
                                const SizedBox(
                                  width: AppSizes.size4,
                                ),
                                Text("${widget.product?.rating}",
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodyMedium
                                        ?.copyWith(
                                            fontWeight: FontWeight.bold,
                                            fontSize: AppSizes.textSizeSmall,
                                            color: AppColors.white)),
                                const SizedBox(
                                  width: AppSizes.spacingTiny,
                                ),
                                const Icon(
                                  Icons.star,
                                  size: AppSizes.textSizeSmall,
                                  color: AppColors.white,
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
