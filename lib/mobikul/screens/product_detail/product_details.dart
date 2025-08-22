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

import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/models/productDetail/image_gallery.dart';
import 'package:test_new/mobikul/models/productDetail/product_detail_page_model.dart';
import 'package:test_new/mobikul/screens/home/widgets/product_carasoul_widget_type2.dart';
import 'package:test_new/mobikul/screens/product_detail/bloc/product_detail_screen_bloc.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/add_to_cart_button.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/bundle_option_view.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/downloadable_product_options.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/downloadable_product_sample.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/group_product.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/guest_checkout_bottomsheet.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/load_options.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_basic_details.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_configurable_view.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_details.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_images.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_more_info.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_reviews.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/product_size_color_view.dart';
import 'package:test_new/mobikul/screens/product_detail/widgets/quantity_view.dart';

import '../../app_widgets/app_alert_message.dart';
import '../../app_widgets/app_dialog_helper.dart';
import '../../app_widgets/badge_icon.dart';
import '../../app_widgets/loader.dart';
import '../../configuration/mobikul_theme.dart';
import '../../constants/app_constants.dart';
import '../../constants/app_routes.dart';
import '../../constants/app_string_constant.dart';
import '../../constants/arguments_map.dart';
import '../../helper/LocalDb/floor/database.dart';
import '../../helper/LocalDb/floor/entities/recent_product.dart';
import '../../helper/LocalDb/floor/recent_view_controller.dart';
import '../../helper/app_storage_pref.dart';
import '../../helper/bottom_sheet_helper.dart';
import '../../helper/generic_methods.dart';
import '../../helper/utils.dart';
import '../../models/productDetail/add_to_cart_response.dart';
import 'bloc/product_detail_screen_events.dart';
import 'bloc/product_detail_screen_state.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails(this.arguments, {Key? key}) : super(key: key);

  final Map<String, dynamic> arguments;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails>
    with WidgetsBindingObserver {
  ProductDetailScreenBloc? _productDetailScreenBloc;
  bool isLoading = true;
  ProductDetailPageModel? _productDetailPageModel;
  List<ImageGallery> productImageGalleryArray = [];
  final ScrollController _scrollController = ScrollController();
  AppLocalizations? _localizations;
  int? counter = 1;
  final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey =
      GlobalKey<ScaffoldMessengerState>();
  bool _checkingPermission = false;
  final Permission _permission = Permission.storage;

  List<dynamic> downloadLinksPrice = [];
  List<dynamic> downloadLinks = [];
  List<dynamic> groupedParams = [];
  List<dynamic> bundleParams = [];
  List<dynamic> customOptionSelection = [];

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed && !_checkingPermission) {
      _checkingPermission = true;
      _checkPermission(_permission).then((_) => _checkingPermission = false);
    }
  }

  @override
  void initState() {
    _productDetailScreenBloc = context.read<ProductDetailScreenBloc>();
    _productDetailScreenBloc?.add(ProductDetailScreenDataFetchEvent(
        widget.arguments[productIdKey] ?? ""));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: AppBar(
        title: Html(
          data: widget.arguments[productNameKey] ?? "",
          style: {
            "body": Style(
              fontSize:  FontSize(AppSizes.textSizeLarge),
              color: Theme.of(context).textTheme.bodySmall?.color
              // color: Theme.of(context).brightness == Brightness.dark
              //     ? AppColorsDark.textColorPrimary
              //     : AppColors.textColorPrimary,
            ),
          },
        ),
        actions: [
          if (appStoragePref.isLoggedIn())
            IconButton(
                onPressed: () {
                  // startArActivity();
                  Navigator.pushNamed(context, AppRoutes.wishlist);
                },
                icon: const Icon(
                  Icons.favorite_outline,
                )),
          IconButton(
              onPressed: () {
                Navigator.pushNamed(context, AppRoutes.cart);
              },
              icon: BadgeIcon(
                icon: const Icon(Icons.shopping_cart),
                badgeColor: Colors.red,
              )),
        ],
      ),
      body: mainView(),
    );
  }

  Widget mainView() {
    return BlocBuilder<ProductDetailScreenBloc, ProductDetailScreenState>(
      builder: (context, currentState) {
        if (currentState is ProductDetailScreenInitial) {
          isLoading = true;
        } else if (currentState is ProductDetailScreenSuccess) {
          isLoading = false;
          appStoragePref.setCartCount(appStoragePref.getCartCount());
          _productDetailPageModel = currentState.productDetailPageData;
          productImageGalleryArray = _productDetailPageModel?.imageGallery ?? [];
          _productDetailScreenBloc?.add(ProductUpdatedDataFetchEvent(widget.arguments[productIdKey] ?? ""));
          if (_productDetailPageModel?.typeId == "configurable"){
            _productDetailScreenBloc?.add(ProductConfigurableDataFetchEvent(widget.arguments[productIdKey] ?? ""));
          }
          setRecentViewed();
        } else if (currentState is ProductUpdatedDataSuccess) {
          isLoading = false;
          appStoragePref.setCartCount(appStoragePref.getCartCount());
          _productDetailPageModel?.isInWishlist = currentState.productDetailPageData.isInWishlist;
          _productDetailPageModel?.wishlistItemId = currentState.productDetailPageData.wishlistItemId;
          _productDetailPageModel?.relatedProductList = currentState.productDetailPageData.relatedProductList;
          _productDetailPageModel?.upsellProductList = currentState.productDetailPageData.upsellProductList;
        } else if (currentState is ProductConfigurableDataSuccess) {
          isLoading = false;
          appStoragePref.setCartCount(appStoragePref.getCartCount());
          _productDetailPageModel?.configurableData = currentState.productDetailPageData.configurableData;
        } else if (currentState is AddProductToWishlistStateSuccess) {
          isLoading = false;
          if (currentState.wishListModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.wishListModel.message ?? '', context);
            });
            _productDetailPageModel?.isInWishlist = true;
            _productDetailPageModel?.wishlistItemId =
                currentState.wishListModel.itemId;
            setRecentViewed();
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.wishListModel.message ?? '', context);
            });
          }
        } else if (currentState is RemoveFromWishlistStateSuccess) {
          isLoading = false;
          if (currentState.baseModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.baseModel.message ?? '', context);
            });
            _productDetailPageModel?.isInWishlist = false;
          }
          setRecentViewed();
        } else if (currentState is QuantityUpdateState) {
          isLoading = false;
          counter = currentState.qty;
        } else if (currentState is ProductDetailScreenErrorAlert) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showError(
                currentState.message?.isNotEmpty ?? false
                    ? currentState.message.toString()
                    : _localizations
                    ?.translate(AppStringConstant.somethingWentWrong) ??
                    '',
                context);
          });
        } else if (currentState is AddtoCartState) {
          isLoading = false;

          if (appStoragePref.getQuoteId() == 0) {
            if (currentState.model?.quoteId != 0) {
              appStoragePref.setQuoteId(currentState.model?.quoteId);
            }
          }
          appStoragePref.setCartCount(currentState.model?.cartCount);
          if (currentState.goToCheckout) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model?.message ?? "", context);
              Navigator.pushNamed(context, AppRoutes.cart);
            });
            // if (!appStoragePref.isLoggedIn() &&
            //     _productDetailPageModel?.typeId == "downloadable" &&
            //     _productDetailPageModel?.canGuestCheckoutDownloadable == true) {
            //   guestCheckout(currentState.model!);
            // } else {
            //   if (appStoragePref.isLoggedIn()) {
            //     checkout(currentState.model!);
            //   } else {
            //     guestCheckout(currentState.model!);
            //   }
            // }
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.model?.message ?? "", context);
            });
          }
        } else if (currentState is UpdateDownloadablePriceState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            print("TEST_LOG==>UPDATE PRICE");
            updateDownloadableProductPrice();
          });
        } else if (currentState is UpdatePriceState) {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            print("TEST_LOG==>UPDATE PRICE");
            updatePrice();
          });
        } else if (currentState is AddProductToCompareStateSuccess) {
          isLoading = false;
          if (currentState.responseModel.success == true) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(
                  currentState.responseModel.message ?? '', context);
            });
          } else {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(
                  currentState.responseModel.message ?? '', context);
            });
          }
        } else if (currentState is ProductDetailEmptyState) {
        } else {
          isLoading = false;
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AppDialogHelper.informationDialog(AppStringConstant.errorRequest,
                context, AppLocalizations.of(context), onConfirm: () async {
                  Navigator.pop(context);
                }, title: AppStringConstant.somethingWentWrong);
          });
        }
        _productDetailScreenBloc?.emit(ProductDetailEmptyState());
        return _buildUI();
      },
    );
  }

  Widget _buildUI() {
    return Stack(
      children: [
        if (_productDetailPageModel != null)
          SingleChildScrollView(
            child: Column(
              children: [
                Stack(
                  children: [
                    SingleChildScrollView(
                        controller: _scrollController,
                        child: Column(
                          children: [
                            Container(
                                color: Theme.of(context).cardColor,
                                child: Column(
                                  children: [
                                    Stack(
                                      children: [
                                        ProductImages(
                                            productImageGalleryArray ?? []),
                                        if (_productDetailPageModel?.isNew ??
                                            true)
                                          Positioned(
                                              left: AppSizes.size20,
                                              top: AppSizes.size14,
                                              child: ColoredBox(
                                                  color: AppColors.red,
                                                  child: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: AppSizes
                                                            .spacingGeneric,
                                                        vertical: AppSizes
                                                            .spacingTiny),
                                                    child: Text(
                                                        Utils.getStringValue(
                                                            context,
                                                            AppStringConstant
                                                                .newTest),
                                                        style: const TextStyle(
                                                            color:
                                                                AppColors.white,
                                                            fontSize: AppSizes
                                                                .spacingSmall)),
                                                  ))),
                                        if (getArStatus())
                                          Positioned(
                                            right: AppSizes.size20,
                                            bottom: AppSizes.size14,
                                            child: Container(
                                              height: AppSizes.size30,
                                              width: AppSizes.size30,
                                              padding:
                                                  const EdgeInsets.only(top: 1),
                                              decoration: BoxDecoration(
                                                  color: AppColors.white,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          15)),
                                              child: InkWell(
                                                child: Image.asset(
                                                  AppImages.threeDIcon,
                                                  width: AppSizes.size30,
                                                  height: AppSizes.size30,
                                                ),
                                                onTap: () => startArActivity(),
                                              ),
                                            ),
                                          ),
                                      ],
                                    ),
                                    ProductPageBasicDetailsView(
                                      _productDetailPageModel?.isInWishlist ??
                                          false,
                                      _productDetailScreenBloc,
                                      product: _productDetailPageModel,
                                    ),
                                  ],
                                )),
                            if ((_productDetailPageModel?.customOptions ?? [])
                                    .isNotEmpty &&
                                (_productDetailPageModel?.isAvailable ?? true))
                              space(),
                            if ((_productDetailPageModel?.customOptions ?? [])
                                    .isNotEmpty &&
                                (_productDetailPageModel?.isAvailable ?? true))
                              LoadOptions(
                                  options:
                                      _productDetailPageModel?.customOptions,
                                  /*selectedOptions: productPageData?.productOptions?.selectedOptions,*/
                                  formattedPrice: _productDetailPageModel
                                      ?.formattedFinalPrice,
                                  productOptions: (List<dynamic> map) {
                                    setState(() {
                                      // prepareCartRequest(map);
                                      customOptionSelection = map;
                                      print(
                                          "TEST_LOG --> map --> ${map.toString()}");
                                    });
                                  }),
                            space(),
                            if (_productDetailPageModel?.typeId ==
                                "configurable")
                              ProductConfigurableView(
                                  _productDetailScreenBloc,
                                  _productDetailPageModel?.id ?? '',
                                  _productDetailPageModel?.typeId ?? '',
                                  _productDetailPageModel?.configurableData),
                            if (_productDetailPageModel?.typeId ==
                                "downloadable")
                              Column(
                                children: [
                                  if (_productDetailPageModel
                                          ?.samples?.hasSample ??
                                      false)
                                    DownloadProductSample(
                                      samples: _productDetailPageModel?.samples,
                                      scaffoldMessengerKey:
                                          scaffoldMessengerKey,
                                    ),
                                  if (_productDetailPageModel?.isAvailable ??
                                      true)
                                    DownloadProductOptions(
                                      links: _productDetailPageModel?.links,
                                      callBack: (ids, selectedLinksPrice) {
                                        setState(() {
                                          downloadLinks = ids;
                                          downloadLinksPrice = selectedLinksPrice;
                                          print(
                                              "TEST_LOG${downloadLinks.toString()}  PRICE${downloadLinksPrice.toString()}");
                                          _productDetailScreenBloc?.add(UpdateDownloadablePriceEvent());
                                          setState(() {});
                                        });
                                      },
                                    )
                                ],
                              ),
                            if (_productDetailPageModel?.typeId == "grouped")
                              GroupProduct(
                                groupedProducts:
                                    _productDetailPageModel?.groupedData,
                                callBack: (qties) {
                                  setState(() {

                                  });
                                  groupedParams = qties;
                                  print("TEST_LOG${groupedParams.toString()}");
                                },
                              ),
                            if (_productDetailPageModel?.typeId == "bundle")
                              BundleOptionsView(
                                options:
                                    _productDetailPageModel?.bundleOptions ??
                                        [],
                                callBack: (data) {
                                  setState(() {
                                    print("-----data Set state ${data}");
                                  });

                                  bundleParams = data;
                                  print(
                                      "TEST_LOG ---> bundleParams -->${bundleParams.toString()}");
                                },
                              ),
                            // if (_productDetailPageModel?.typeId == "bundle")
                            //   space(),
                            if (_productDetailPageModel?.typeId != "grouped")
                              QuantityView(
                                bloc: _productDetailScreenBloc,
                                counter: counter,
                              ),
                            if (_productDetailPageModel?.typeId != "grouped")
                              space(),
                            AddToCartButtonView(
                                _productDetailScreenBloc,
                                _productDetailPageModel,
                                counter ?? 1,
                                downloadLinks,
                                groupedParams,
                                bundleParams,
                                customOptionSelection),
                            if (_productDetailPageModel
                                    ?.description?.isNotEmpty ??
                                false)
                              space(),
                            if (_productDetailPageModel
                                    ?.description?.isNotEmpty ??
                                false)
                              ProductDetailsView(
                                  _productDetailPageModel?.description),
                            if (_productDetailPageModel
                                    ?.description?.isNotEmpty ??
                                false)
                              space(),
                            productInfo(
                                _productDetailPageModel?.additionalInformation,
                                context),
                            space(),
                            if ((_productDetailPageModel?.reviewCount ?? 0) > 0)
                              productReviewList(
                                  _productDetailPageModel,
                                  context,
                                  _localizations,
                                  _productDetailPageModel?.reviewCount?.toInt() ??
                                      0),
                            space(),
                            if (_productDetailPageModel
                                    ?.upsellProductList?.isNotEmpty ??
                                false)
                              ProductCarasoulType2(
                                  _productDetailPageModel?.upsellProductList ??
                                      [],
                                  context,
                                  "",
                                  _localizations?.translate(AppStringConstant
                                          .upsellProductTitle) ??
                                      '',
                                  isShowViewAll: false),
                            space(),
                            if (_productDetailPageModel
                                    ?.relatedProductList?.isNotEmpty ??
                                false)
                              ProductCarasoulType2(
                                  _productDetailPageModel?.relatedProductList ??
                                      [],
                                  context,
                                  "",
                                  _localizations?.translate(
                                          AppStringConstant.relatedProducts) ??
                                      '',
                                  isShowViewAll: false,
                                  callBack: () {}),
                            space(),
                          ],
                        )),
                  ],
                )
              ],
            ),
          ),
        Visibility(visible: isLoading, child: const Loader())
      ],
    );
  }

  Widget space() {
    return Container(
      height: 12.0,
    );
  }

  void checkout(AddToCartResponse addToCartResponse) {
    if (addToCartResponse.isCheckoutAllowed == true) {
      if (addToCartResponse.isVirtual ?? false) {
        Navigator.pushNamed(context, AppRoutes.paymentInfo,
            arguments: getCheckoutMap("", null));
      } else {
        Navigator.of(context).pushNamed(AppRoutes.shippingIfo,
            arguments: addToCartResponse?.cartTotal ?? "0.00");
      }
    } else {
      if (addToCartResponse.descriptionMessage?.isEmpty == true) {
        if (addToCartResponse.minimumAmount! > 0) {
          AlertMessage.showWarning(
              "${_localizations?.translate(AppStringConstant.minimumOrderAmountError)} ${addToCartResponse.minimumFormattedAmount}",
              context);
        } else {
          Navigator.of(context).pushNamed(AppRoutes.shippingIfo,
              arguments: addToCartResponse?.cartTotal ?? "0.00");
        }
      } else {
        AlertMessage.showWarning(
            "${addToCartResponse.descriptionMessage}", context);
      }
    }
  }

  void guestCheckout(AddToCartResponse addToCartResponse) {
    if (_productDetailPageModel?.isAllowedGuestCheckout == true &&
        addToCartResponse.isCheckoutAllowed != true) {
      if (addToCartResponse.descriptionMessage?.isEmpty == true) {
        if (addToCartResponse.minimumAmount! > 0) {
          AlertMessage.showWarning(
              "${_localizations?.translate(AppStringConstant.minimumOrderAmountError)} ${addToCartResponse.minimumFormattedAmount}",
              context);
        } else {
          guestCheckoutBottomSheet(
              context,
              addToCartResponse.cartTotalFormattedAmount ?? "",
              addToCartResponse.isVirtual ?? false);
        }
      } else {
        AlertMessage.showWarning(
            "${addToCartResponse.descriptionMessage}", context);
      }
    } else {
      guestCheckoutBottomSheet(
          context,
          addToCartResponse.cartTotalFormattedAmount ?? "",
          addToCartResponse.isVirtual ?? false);
    }
  }

  void updateDownloadableProductPrice() {
    double finalPrice = _productDetailPageModel?.finalPrice ?? 0.0;
    double updatedFinalPrice = finalPrice;

    if ((_productDetailPageModel?.links?.linkData?.length ?? 0) >
        0) {
      for (var element in downloadLinksPrice) {
        print(
            "TEST_LOG==>indexElement[$element]");
        updatedFinalPrice =
            updatedFinalPrice + double.parse(element);
      }
      print("TEST_LOG==>FinalPrice is==> $updatedFinalPrice");

      String pattern = appStoragePref.getPricePattern() ?? "";
      var formattedFinalPrice =
      pattern.replaceAll("%s", updatedFinalPrice.toString());

        _productDetailPageModel?.formattedPrice = formattedFinalPrice;
        _productDetailPageModel?.formattedFinalPrice = formattedFinalPrice;

    }
  }

  void updatePrice() {
    int noOfSelectedOptions = 0;

    int productId = 0;
    double price = _productDetailPageModel?.price ?? 0.0;
    double finalPrice = _productDetailPageModel?.finalPrice ?? 0.0;
    double updatedFinalPrice = finalPrice;

    if ((_productDetailPageModel?.configurableData?.attributes?.length ?? 0) >
        0) {
      List<String> configOptionsId = [];
      List<int> selectedConfigOptionsId = [];

      _productDetailPageModel?.configurableData?.attributes
          ?.forEach((attributeElement) {
        configOptionsId.add(attributeElement.id.toString());
        if (attributeElement.swatchType == "visual" ||
            attributeElement.swatchType == "text") {
          bool isOptionSelected = false;
          // _productDetailPageModel?.configurableData?.attributes?.forEach((element) {
          //   print("TEST_LOG==>element.options==> ${attributeElement.options?.length??0}");
          attributeElement.options?.forEach((element) {
            if (element.swatchData?.isSelected ?? false) {
              // print("TEST_LOG==>element.id==> ${element.id??0}");
              isOptionSelected = true;
              noOfSelectedOptions++;
              selectedConfigOptionsId.add(element.id ?? 0);
            }
          });
          // });
          if (!isOptionSelected) {
            selectedConfigOptionsId.add(attributeElement.options?[0].id ?? 0);
          }
        } else {
          bool isOptionSelected = false;
          attributeElement.options?.forEach((element) {
            if (element.swatchData?.isSelected ?? false) {
              // print("TEST_LOG==>element.id==> ${element.id??0}");
              isOptionSelected = true;
              noOfSelectedOptions++;
              selectedConfigOptionsId.add(element.id ?? 0);
            }
          });
          // });
          if (!isOptionSelected) {
            selectedConfigOptionsId.add(attributeElement.options?[0].id ?? 0);
          }
        }
      });

      bool priceFound = false;
      try {
        List indexArray =
            json.decode(_productDetailPageModel?.configurableData?.index ?? "");
        indexArray.forEach((indexElement) {
          // print("TEST_LOG==>indexElement==> ${indexElement}");
          for (var configElement in configOptionsId) {
            // print("TEST_LOG==>indexElement[${configElement}]==> ${indexElement[configElement]}");
            if (indexElement[configElement].toString() ==
                selectedConfigOptionsId[configOptionsId.indexOf(configElement)]
                    .toString()) {
              priceFound = true;
            } else {
              priceFound = false;
              break;
            }
          }

          if (priceFound) {
            updatedFinalPrice = double.parse(_productDetailPageModel
                    ?.configurableData
                    ?.optionPrices?[indexArray.indexOf(indexElement)]
                    .finalPrice
                    ?.amount
                    .toString() ??
                "0");
            productId = int.parse(_productDetailPageModel?.configurableData
                    ?.optionPrices?[indexArray.indexOf(indexElement)].product
                    .toString() ??
                "");
          }
        });
      } catch (e) {
        print(e);
      }
      if (noOfSelectedOptions > 0) {
        updateImage(productId);
      }
    }

    price = price + updatedFinalPrice - finalPrice;

    print("TEST_LOG==>price==> ${price}");
    print("TEST_LOG==>productId==> ${productId}");

    String pattern = appStoragePref.getPricePattern() ?? "";
    var newFormattedPrice = pattern.replaceAll("%s", price.toString());
    var formattedFinalPrice =
        pattern.replaceAll("%s", updatedFinalPrice.toString());

    if (_productDetailPageModel?.typeId != "configurable" ||
        noOfSelectedOptions ==
            _productDetailPageModel?.configurableData?.attributes?.length) {
      _productDetailPageModel?.formattedPrice = newFormattedPrice;
      _productDetailPageModel?.formattedFinalPrice = formattedFinalPrice;
    }
  }

  void updateImage(int productId) {
    List<ImageGallery> imageGalleryDataArray = [];
    // _productDetailPageModel?.imageGallery?.forEach((element) {
    //   ImageGallery imageGalleryDataObject = ImageGallery(
    //       element.smallImage,
    //       element.largeImage,
    //       element.dominantColor,
    //       element.isVideo,
    //       element.videoUrl);
    //   imageGalleryDataArray.add(imageGalleryDataObject);
    // });

    if (productId != 0) {
      try {
        var imagesJSON = json
            .decode(_productDetailPageModel?.configurableData?.images ?? "");
        List imageGalleryArray = imagesJSON[productId.toString()];

        if (imageGalleryArray.isNotEmpty) {
          imageGalleryArray.forEach((element) {
            ImageGallery imageGalleryDataObject =
                ImageGallery(element["thumb"], element["full"], "", false, "");
            imageGalleryDataArray.add(imageGalleryDataObject);
          });
        }
      } catch (e) {
        print(e);
      }
    }
    productImageGalleryArray = imageGalleryDataArray;
    print("TEST_LOG==>updateImage==>");
  }

  var methodChannel = const MethodChannel(AppConstant.channelName);

  bool getArStatus() {
    if (AppConstant.enableArCore) {
      if (Platform.isAndroid &&
          ((_productDetailPageModel?.arUrl ?? "").isNotEmpty)) {
        print("_productDetailPageModel?.arUrl ${_productDetailPageModel?.arUrl}");
        return true;
      } else if (Platform.isIOS &&
          ((_productDetailPageModel?.arUrlIos ?? "").isNotEmpty)) {
        print("_productDetailPageModel?.arUrl iOS ${_productDetailPageModel?.arUrlIos}");
        return true;
      }
    }
    return false;
  }

  Future startArActivity() async {
    if (Platform.isIOS) {
      GenericMethods.loadArOnIOS(
          context, _productDetailPageModel?.arUrlIos ?? "");
    }
    _checkPermission(_permission);
    print("${_productDetailPageModel?.arUrl}");
  }

  Future<void> _checkPermission(Permission permission) async {
    final status = await permission.request();
    var androidInfo = await DeviceInfoPlugin().androidInfo;
    if (int.parse(androidInfo.version.release ?? "10") > 12) {
      try {
        var data = await methodChannel.invokeMethod("showAr", {
          "name": _productDetailPageModel?.name,
          "url": _productDetailPageModel?.arUrl
        });
        return data;
      } on PlatformException catch (e) {
        WidgetsBinding.instance?.addPostFrameCallback((_) {
          AlertMessage.showWarning(e.message ?? '', context);
        });
      }
    }else {
      if (status == PermissionStatus.granted) {
        try {
          var data = await methodChannel.invokeMethod("showAr", {
            "name": _productDetailPageModel?.name,
            "url": _productDetailPageModel?.arUrl
          });
          return data;
        } on PlatformException catch (e) {
          WidgetsBinding.instance?.addPostFrameCallback((_) {
            AlertMessage.showWarning(e.message ?? '', context);
          });
        }
      }

      else if (status == PermissionStatus.denied) {
        _checkPermission(_permission);
      }
      else if (status == PermissionStatus.permanentlyDenied) {
        openAppSettings();
      }
    }
  }

  void setRecentViewed() {
    AppDatabase.getDatabase().then(
      (value) => value.recentProductDao
          .insertRecentProduct(
            RecentProduct(
              entityId: int.parse(_productDetailPageModel?.id ?? ''),
              availability: _productDetailPageModel?.availability,
              dominantColor: '',
              formattedPrice: _productDetailPageModel?.formattedPrice,
              finalPrice: _productDetailPageModel?.finalPrice.toString(),
              formattedFinalPrice: (_productDetailPageModel?.hasPrice() ?? true)
                  ? _productDetailPageModel?.formattedFinalPrice
                  : (_productDetailPageModel?.hasGroupedPrice() ?? false)
                      ? _productDetailPageModel?.groupedPrice
                      : ((_productDetailPageModel?.hasMinPrice() ?? false) &&
                              (_productDetailPageModel?.hasMaxPrice() ?? false))
                          ? "${_productDetailPageModel?.formattedMinPrice} - ${_productDetailPageModel?.formattedMaxPrice}"
                          : _productDetailPageModel?.formattedPrice,
              formattedTierPrice: _productDetailPageModel?.formattedMaxPrice,
              hasRequiredOptions: false,
              isAvailable: _productDetailPageModel?.isAvailable,
              isInRange: _productDetailPageModel?.isInRange,
              isInWishlist: _productDetailPageModel?.isInWishlist,
              isNew: _productDetailPageModel?.isNew,
              minAddToCartQty: _productDetailPageModel?.thresholdQtyLeft,
              name: _productDetailPageModel?.name,
              price: _productDetailPageModel?.price.toString(),
              reviewCount: _productDetailPageModel?.reviewCount,
              thumbNail: _productDetailPageModel?.thumbNail,
              tierPrice: _productDetailPageModel?.priceView,
              typeId: _productDetailPageModel?.typeId,
              rating: _productDetailPageModel?.rating.toString(),
              wishlistItemId: _productDetailPageModel?.wishlistItemId,
              storeId: appStoragePref.getStoreCode(),
              currency: appStoragePref.getCurrencyCode(),
            ),
          )
          .then(
            (value) => RecentViewController.controller.sink
                .add(_productDetailPageModel?.id),
          ),
    );
  }
}
