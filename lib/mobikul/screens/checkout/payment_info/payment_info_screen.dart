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

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:test_new/mobikul/app_widgets/app_alert_message.dart';
import 'package:test_new/mobikul/app_widgets/app_bar.dart';
import 'package:test_new/mobikul/app_widgets/app_order_button.dart';
import 'package:test_new/mobikul/app_widgets/app_switch_button.dart';
import 'package:test_new/mobikul/app_widgets/loader.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';
import 'package:test_new/mobikul/constants/app_routes.dart';
import 'package:test_new/mobikul/constants/app_string_constant.dart';
import 'package:test_new/mobikul/helper/app_localizations.dart';
import 'package:test_new/mobikul/helper/utils.dart';
import 'package:test_new/mobikul/models/cart/price_details.dart';
import 'package:test_new/mobikul/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/mobikul/models/checkout/payment_info/payment_info_model.dart';
import 'package:test_new/mobikul/models/checkout/place_order/place_order_model.dart';
import 'package:test_new/mobikul/screens/cart/widgets/discount_view.dart';
import 'package:test_new/mobikul/screens/cart/widgets/price_detail_view.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_events.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_state.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/widgets/order_summary.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/widgets/payment_methods.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/widgets/place_order_screen.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/widget/address_item_card.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/widget/checkout_progress_line.dart';

import '../../../configuration/mobikul_theme.dart';
import '../../../constants/arguments_map.dart';
import '../../../helper/app_storage_pref.dart';
import '../../../helper/bottom_sheet_helper.dart';
import '../../../models/checkout/place_order/billing_data_request.dart';
import '../../../models/checkout/shipping_info/shipping_address_model.dart';

class PaymentInfoScreen extends StatefulWidget {
  final Map<String,dynamic> args;
  PaymentInfoScreen(this.args, {Key? key}) : super(key: key);

  @override
  State<PaymentInfoScreen> createState() => _PaymentInfoScreenState();
}

class _PaymentInfoScreenState extends State<PaymentInfoScreen> {
  AppLocalizations? _localizations;
  bool isAddressSame = true;
  bool isLoading = true;
  PaymentInfoModel? paymentInfoModel;
  PaymentInfoScreenBloc? paymentInfoScreenBloc;
  PlaceOrderModel? placeOrderModel;
  String selectedPaymentMethodCode = '';
  BillingDataRequest? billingDataRequest;
  ShippingAddressModel? _addressListModel;

  @override
  void initState() {
    paymentInfoScreenBloc = context.read<PaymentInfoScreenBloc>();
    paymentInfoScreenBloc?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
    _addressListModel = widget.args[addressKey];
    if (widget.args[isVirtualKey]??false) {
      isAddressSame = false;
    }
    super.initState();
  }

  @override
  void didChangeDependencies() {
    _localizations = AppLocalizations.of(context);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: commonAppBar(
            _localizations?.translate(AppStringConstant.reviewPayments) ?? "",
            context),
        body: BlocBuilder<PaymentInfoScreenBloc, PaymentInfoScreenState>(
            builder: (context, currentState) {
          if (currentState is PaymentInfoScreenInitial) {
            isLoading = true;
          } else if (currentState is GetPaymentMethodSuccess) {
            isLoading = false;
            paymentInfoModel = currentState.paymentModel;
            if (_addressListModel == null) {
              paymentInfoScreenBloc?.add(const CheckoutAddressFetchEvent());
            }
          } else if (currentState is CheckoutAddressSuccess) {
            isLoading = false;
            if (currentState.model.success ?? false) {
              _addressListModel = currentState.model;
              if (_addressListModel?.address != null) {
                _addressListModel?.selectedAddressData = _addressListModel?.address?[0];
              }
            }

            if (appStoragePref.getUserAddressData()?.firstname?.isNotEmpty??false) {
              Address addressData = Address(
                  value: _addressListModel?.getFormattedAddress(appStoragePref.getUserAddressData()!),
                  id: "",
                  isNew: true
              );
              List<Address>? address = [];
              address.add(addressData);
              if (_addressListModel?.address != null) {
                _addressListModel?.address?.add(addressData);
              } else {
                _addressListModel?.address = address;
              }
              _addressListModel?.selectedAddressData = addressData;

              _addressListModel?.hasNewAddress = true;
            }
          } else if (currentState is PlaceOrderSuccess) {
            isLoading = false;
            appStoragePref.setQuoteId(0);
            appStoragePref.setCartCount(0);
            placeOrderModel = currentState.placeOrderModel;
            log("RPlace Order Response Data ===>${placeOrderModel?.getngeniusrequestdata?.toJson()}");

            log("RPlace Order Response Data ===>${placeOrderModel?.toJson()}");
            WidgetsBinding.instance?.addPostFrameCallback((_)  async {
              if(selectedPaymentMethodCode == "ngeniusonline"){
                var paymentType = "ngeniusonline";
                try {
                  const platform = MethodChannel(AppConstant.channelName);
                  print("ngeniusonline--==>${paymentType}");
                  try {
                     Map<String, dynamic> jsonData = {};
                    Future<void> sendJsonToIOS() async {

                   


                      jsonData = {
                        "_id": placeOrderModel?.getngeniusrequestdata?.id,
                        "type": placeOrderModel?.getngeniusrequestdata?.type,
                        "action": placeOrderModel?.getngeniusrequestdata?.action,
                        "amount": {
                          "currencyCode": placeOrderModel
                              ?.getngeniusrequestdata?.amount?.currencyCode,
                          "value": placeOrderModel
                              ?.getngeniusrequestdata?.amount?.value ?? ""
                        },
                        "formattedAmount": placeOrderModel
                            ?.getngeniusrequestdata?.formattedAmount,
                        "language": placeOrderModel
                            ?.getngeniusrequestdata?.language,
                        "merchantAttributes": {
                          "redirectUrl":placeOrderModel?.getngeniusrequestdata?.merchantAttributes?.redirectUrl,
                          "skipConfirmationPage": placeOrderModel?.getngeniusrequestdata?.merchantAttributes?.skipConfirmationPage,
                        },
                        "emailAddress":"",
                        "reference":placeOrderModel
                            ?.getngeniusrequestdata?.reference,
                        "outletId":placeOrderModel?.getngeniusrequestdata?.outletId,
                        "createDateTime": placeOrderModel?.getngeniusrequestdata?.createDateTime,
                        "referrer": placeOrderModel?.getngeniusrequestdata?.referrer,
                        "orderSummary":{
                          "total": {
                            "currencyCode": placeOrderModel
                                ?.getngeniusrequestdata?.amount?.currencyCode,
                            "value": placeOrderModel
                                ?.getngeniusrequestdata?.amount?.value ?? ""
                          }
                        },
                        "formattedOrderSummary":{
                          "total": placeOrderModel
                              ?.getngeniusrequestdata?.amount?.value.toString()
                        },
                        "paymentMethods":{
                          "card": placeOrderModel
                              ?.getngeniusrequestdata?.paymentMethods?.card,
                          "wallet": [
                            "UNION_PAY"
                          ]
                        },
                        "_links": {
                          "cnp:payment-link": {
                            "href": placeOrderModel
                                ?.getngeniusrequestdata?.links?.cnpPaymentLink?.href,
                          },
                          "payment-authorization": {
                            "href":placeOrderModel
                                ?.getngeniusrequestdata?.links?.paymentAuthorization?.href
                          },
                          "self": {
                            "href":placeOrderModel
                                ?.getngeniusrequestdata?.links?.self?.href
                          },
                          "payment": {
                            "href":placeOrderModel
                                ?.getngeniusrequestdata?.links?.payment?.href
                          },
                        },
                        "_embedded": {
                          "payment": [{
                            "_id": placeOrderModel
                                ?.getngeniusrequestdata?.embedded?.payment?[0]?.id,
                            "state": placeOrderModel
                                ?.getngeniusrequestdata?.embedded?.payment?[0]?.state,
                            "amount": {
                              "currencyCode": placeOrderModel
                                  ?.getngeniusrequestdata?.embedded?.payment?[0]?.amount
                                  ?.currencyCode?? "",
                              "value": placeOrderModel
                                  ?.getngeniusrequestdata?.embedded?.payment?[0]?.amount
                                  ?.value ?? ""
                            },
                            "_links":{
                              "self":{
                                "href":placeOrderModel
                                    ?.getngeniusrequestdata?.embedded?.payment?[0].paymentLinksData?.self?.href,
                              },
                              "payment:card": {
                                "href":placeOrderModel
                                    ?.getngeniusrequestdata?.embedded?.payment?[0].paymentLinksData?.paymentCard?.href,
                              },
                              "payment:saved-card":{
                                "href":placeOrderModel
                                    ?.getngeniusrequestdata?.embedded?.payment?[0].paymentLinksData?.paymentSavedCard?.href,
                              }
                            },
                            "orderReference":placeOrderModel
                                ?.getngeniusrequestdata?.embedded?.payment?[0]?.orderReference,
                            "outletId": placeOrderModel?.getngeniusrequestdata?.embedded?.payment?[0]?.outletId,
                          }]
                        }

                      };



                    }
                     sendJsonToIOS();
                    print("jsonData==>${jsonData}");
                    var data = await platform.invokeMethod(paymentType,
                        {"paymentSheetData" : jsonData});

                    var resultData = data;
                     debugPrint("--->resultData==>${resultData.toString()}");

                     debugPrint("--->Data==>${data.toString()}");
                    if(resultData.toString() == "success"){

                      paymentInfoScreenBloc?.add(UpdatePaymentStatusEvent(placeOrderModel?.getngeniusrequestdata?.reference ?? "","success"));

                      debugPrint("--->In side success==>${data.toString()}");
                      // Future.microtask(() {
                      //
                      // Navigator.push(
                      //     context,
                      //     MaterialPageRoute(
                      //         builder: (context) =>
                      //             PlaceOrderScreen(placeOrderModel))
                      // );
                      // });
                    } else if(resultData.toString() == "failed"){
                      debugPrint("--->Inside Failed==>${resultData.toString()}");
                      paymentInfoScreenBloc?.add(UpdatePaymentStatusEvent(placeOrderModel?.getngeniusrequestdata?.reference ?? "","failed"));

                      // Future.microtask(() {
                      //   AlertMessage.showWarning(data?? Utils.getStringValue(context, AppStringConstant.paymentFailed), context);
                      //   Navigator.pushNamedAndRemoveUntil(
                      //       context, AppRoutes.bottomTabBar, (route) => false);
                      // });
                    } else {
                      debugPrint("--->Inside cancel==>${resultData.toString()}");
                      paymentInfoScreenBloc?.add(UpdatePaymentStatusEvent(placeOrderModel?.getngeniusrequestdata?.reference ?? "",resultData.toString()));

                      // Future.microtask(() {
                      //   AlertMessage.showWarning(data?? Utils.getStringValue(context, AppStringConstant.paymentCancle), context);
                      //   Navigator.pushNamedAndRemoveUntil(
                      //       context, AppRoutes.bottomTabBar, (route) => false);
                      // });
                    }
                    // return data;
                  } on PlatformException catch (e) {
                    WidgetsBinding.instance?.addPostFrameCallback((_) {
                      AlertMessage.showWarning(e.message ?? '', context);
                    });
                    print("Failed to send data: ${e.message}");
                  }

                } on PlatformException catch (e) {
                  WidgetsBinding.instance?.addPostFrameCallback((_) {
                    AlertMessage.showWarning(e.message ?? '', context);
                  });
                }
              } else {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlaceOrderScreen(placeOrderModel))
                );
              }
            });
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          }
          else if (currentState is ApplyCouponState) {
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showSuccess(currentState.data.message!= '' ? currentState.data.message?? '': Utils.getStringValue(context, AppStringConstant.deleteItemFromCart), context);
            });
            paymentInfoScreenBloc?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          }
          else if (currentState is PaymentInfoScreenError) {
            isLoading = false;
            WidgetsBinding.instance?.addPostFrameCallback((_) {
              AlertMessage.showError(currentState.message?? Utils.getStringValue(context, AppStringConstant.somethingWentWrong), context);
            });
            paymentInfoScreenBloc?.emit(PaymentInfoScreenEmptyState());
          } else if (currentState is ChangeBillingAddressState) {
            paymentInfoScreenBloc?.add(GetPaymentInfoEvent(widget.args[shippingMethodKey]));
          } else if(currentState is PaymentStatusUpdate){
            isLoading = false;
            debugPrint("Comming inside payment status update");
            debugPrint(currentState.status);

            if(currentState.status == "success"){
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) =>
                            PlaceOrderScreen(placeOrderModel))
                );              });
              // Future.microtask(() {
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) =>
              //             PlaceOrderScreen(placeOrderModel))
              // );
              // });
            } else if(currentState.status == "failed"){
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                AlertMessage.showWarning("Failed" ?? Utils.getStringValue(context, AppStringConstant.paymentFailed), context);
                Navigator.pushNamedAndRemoveUntil(
                    context, AppRoutes.bottomTabBar, (route) => false);
              });
              // Future.microtask(() {
              //   AlertMessage.showWarning("Failed" ?? Utils.getStringValue(context, AppStringConstant.paymentFailed), context);
              //   Navigator.pushNamedAndRemoveUntil(
              //       context, AppRoutes.bottomTabBar, (route) => false);
              // });
            } else {
              WidgetsBinding.instance?.addPostFrameCallback((_) {
                  AlertMessage.showWarning("Cancel" ?? Utils.getStringValue(context, AppStringConstant.paymentCancle), context);
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.bottomTabBar, (route) => false);
              });
              // Future.microtask(() {
              //   AlertMessage.showWarning("Cancel" ?? Utils.getStringValue(context, AppStringConstant.paymentCancle), context);
              //   Navigator.pushNamedAndRemoveUntil(
              //       context, AppRoutes.bottomTabBar, (route) => false);
              // });
            }
          }
          return _buildUI();
        }));
  }

  Widget _buildUI() {

    return Stack (children: [
      Visibility(
          visible: paymentInfoModel != null,
          child: paymentInfoModel?.success ?? false
              ? Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      checkoutProgressLine(false, context),
                      showBillingAddress(context, AppStringConstant.billingAddress),
                      DiscountView(
                        discountApplied: paymentInfoModel?.couponCode?.isNotEmpty??false,
                        discountCode: paymentInfoModel?.couponCode??"",
                        onClickApply: (discountCode) {
                          paymentInfoScreenBloc?.add(ApplyCouponEvent(discountCode.toString()??"", 0));
                        },
                        onClickRemove: (discountCode) {
                          paymentInfoScreenBloc?.add(ApplyCouponEvent(paymentInfoModel?.couponCode.toString()??"", 1));
                        },
                      ),
                      if (widget.args[shippingMethodKey] != "")
                        shippinginfo(AppStringConstant.shippingInfo),
                      paymentMethod(),
                      orderSummary(context, _localizations, paymentInfoModel?.orderReviewData?.items ?? []),
                      PriceDetailView(
                          paymentInfoModel?.orderReviewData?.totals ?? [],
                          _localizations)
                    ],
                  ),
                ),
              ),
              commonOrderButton(context, _localizations, paymentInfoModel?.total ?? "", () async {
                billingDataRequest = BillingDataRequest(
                    sameAsShipping: isAddressSame? 1:0,
                    addressId: _addressListModel?.selectedAddressData?.id);

                if ((!isAddressSame && (appStoragePref.getUserAddressData()?.firstname??"").isEmpty)) {
                  AlertMessage.showError(_localizations?.translate(AppStringConstant.paymentAddressSelectError) ?? "", context);
                } else if (selectedPaymentMethodCode.isEmpty) {
                  AlertMessage.showError(_localizations?.translate(AppStringConstant.selectPaymentMethod) ?? "", context);
                } else {
                  paymentInfoScreenBloc?.add(PlaceOrderEvent(selectedPaymentMethodCode, widget.args[shippingMethodKey], billingDataRequest!, ));
                  paymentInfoScreenBloc?.emit(PaymentInfoScreenInitial());
                  var mHiveBox = await HiveStore.openBox("graphqlClientStore");
                  mHiveBox.clear();
                }
              },
                  title: AppStringConstant.placeOrder)
            ],
          )
              : Container()

      ),
      Visibility(
        visible: isLoading,
        child: const Loader(),
      ),
    ],);
  }

  Widget showBillingAddress(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.size8),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.size8, horizontal: AppSizes.size8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(_localizations?.translate(title) ?? '',
                      style: Theme.of(context).textTheme.displaySmall),
                ],
              ),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            if (widget.args[shippingMethodKey] != "")
              AppSwitchButton(
                _localizations?.translate(AppStringConstant.sameAsShippingAddress) ?? '',
                billingAddress,
                isAddressSame,
                isFromPaymentInfo: true,
              ),
            Visibility(
              visible: !isAddressSame || (widget.args[shippingMethodKey] == ""),
              child: addressItemCard(
                  _addressListModel?.selectedAddressData?.value ?? "", context,
                  isElevated: false,
                  actions: actionContainer(context,
                          () {
                            shippingAddressModelBottomSheet(context, (value) {
                               paymentInfoScreenBloc?.add(const ChangeAddressEvent());
                            }, _addressListModel);
                          },
                          () {
                            Navigator.of(context).pushNamed(
                                AppRoutes.addEditAddress,
                                arguments: {addressId: "", address: appStoragePref.getUserAddressData(), isCheckout: true}
                            ).then((value) {
                              print("TEST_LOG ==> address ==> ${value}");
                              paymentInfoScreenBloc?.emit(PaymentInfoScreenInitial());
                              paymentInfoScreenBloc?.add(const CheckoutAddressFetchEvent());

                            });
                          },
                      titleLeft: _localizations?.translate(AppStringConstant.changeAddress) ??'',
                      titleRight:  (_addressListModel?.hasNewAddress??false)?_localizations?.translate(AppStringConstant.editAddress) ?? '':_localizations?.translate(AppStringConstant.newAddress) ?? '',
                      iconLeft: Icons.edit,
                      iconRight: (_addressListModel?.hasNewAddress??false)?Icons.edit:Icons.add,
                      isNewAddress: ((_addressListModel?.hasNewAddress??false)?(_addressListModel?.selectedAddressData?.isNew??false):true),
                      hasAddress: ((_addressListModel?.selectedAddressData?.value??"").isNotEmpty?true:false)
                  )
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget shippinginfo(String title) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSizes.size12),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.size8),
              child: Text(_localizations?.translate(title) ?? "",
                  style: Theme.of(context).textTheme.displaySmall),
            ),
            const Divider(
              thickness: 1,
              height: 1,
            ),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.size8,
                  left: AppSizes.size8,
                  right: AppSizes.size8),
              child: Text(
                  _localizations
                          ?.translate(AppStringConstant.shippingAddress)
                          .toUpperCase() ??
                      "",
                  style: Theme.of(context).textTheme.displaySmall),
            ),
            addressItemCard(paymentInfoModel?.shippingAddress ?? '', context,
                isElevated: false),
            Padding(
              padding: const EdgeInsets.only(
                  top: AppSizes.size8,
                  left: AppSizes.size8,
                  right: AppSizes.size8),
              child: Text(
                  _localizations
                          ?.translate(AppStringConstant.shippingMethod)
                          .toUpperCase() ??
                      "",
                  style: Theme.of(context).textTheme.displaySmall),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(
                  vertical: AppSizes.linePadding, horizontal: AppSizes.size8),
              child: Text(
                paymentInfoModel?.shippingMethod ?? '',
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(fontWeight: FontWeight.normal),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget paymentMethod() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSizes.size12),
      child: Container(
        color: Theme.of(context).cardColor,
        margin: const EdgeInsets.only(top: AppSizes.size8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(AppSizes.size8),
              child: Text(
                  _localizations?.translate(AppStringConstant.paymentMethods) ??
                      "",
                  style: Theme.of(context).textTheme.displaySmall),
            ),
            const Divider(
              height: 1,
              thickness: 1,
            ),
            PaymentMethodsView(
              paymentMethods: getActivePaymentMethod(paymentInfoModel?.paymentMethods??[]),
              callBack: (index) {
                selectedPaymentMethodCode = index;
              },
              paymentCallback: () {
              },
            )
          ],
        ),
      ),
    );
  }

  void billingAddress(bool isOn) {
    setState(() {
      isAddressSame = isOn;
      // isAddressSame = !isAddressSame;
    });
  }

  List<PaymentMethods> getActivePaymentMethod(List<PaymentMethods> allPaymentMethods) {
    List<PaymentMethods> activePaymentMEthods = [];

    allPaymentMethods.forEach((element) {
      if (AppConstant.allowedPaymentMethods.contains(element.code)) {
        activePaymentMEthods.add(element);
      }
    });

    return activePaymentMEthods;

  }
}
