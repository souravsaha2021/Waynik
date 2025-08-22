/*
* Webkul Software.
*
@package Mobikul Application Code.
* @Category Mobikul
* @author Webkul <support@webkul.com>
* @Copyright (c) Webkul Software Private Limited (https://webkul.com)
* @license https://store.webkul.com/license.html
* @link https://store.webkul.com/license.html
*
*/
import 'package:json_annotation/json_annotation.dart';

import '../../base_model.dart';
part 'ngenius_payment_details_model.g.dart';



@JsonSerializable()
class GetngeNiusrequestdata extends BaseModel{
  @JsonKey(name:"_id")
  String? id;

  @JsonKey(name:"_links")
  LinkDataModel? links;

  @JsonKey(name:"type")
  String? type;

  @JsonKey(name:"merchantDefinedData")
  List<String>? merchantDefinedData;

  @JsonKey(name:"action")
  String? action;

  @JsonKey(name:"amount")
  Amount? amount;

  @JsonKey(name:"language")
  String? language;

  @JsonKey(name:"merchantAttributes")
  MerchantAttributes? merchantAttributes;

  @JsonKey(name:"reference")
  String? reference;

  @JsonKey(name:"outletId")
  String? outletId;

  @JsonKey(name:"createDateTime")
  String? createDateTime;

  @JsonKey(name:"paymentMethods")
  PaymentMethods? paymentMethods;

  @JsonKey(name:"referrer")
  String? referrer;

  @JsonKey(name:"merchantDetails")
  MerchantDetails? merchantDetails;

  @JsonKey(name:"isSplitPayment")
  bool? isSplitPayment;

  @JsonKey(name:"formattedOrderSummary")
  List<String>? formattedOrderSummary;

  @JsonKey(name:"formattedAmount")
  String? formattedAmount;

  @JsonKey(name:"formattedOriginalAmount")
  String? formattedOriginalAmount;

  @JsonKey(name:"_embedded")
  Embedded? embedded;

  GetngeNiusrequestdata({this.id,this.links,this.type,this.merchantDefinedData,this.action,this.amount,this.language,this.merchantAttributes
  ,this.reference,this.outletId,this.createDateTime,this.paymentMethods,this.referrer,this.merchantDetails,this.isSplitPayment,this.formattedOrderSummary,
  this.formattedAmount,this.formattedOriginalAmount,this.embedded});

  factory GetngeNiusrequestdata.fromJson(Map<String, dynamic> json) => _$GetngeNiusrequestdataFromJson(json);

  Map<String,dynamic> toJson() => _$GetngeNiusrequestdataToJson(this);
}

@JsonSerializable()
class LinkDataModel extends BaseModel{
  @JsonKey(name:"cancel")
  CancelDataModel? cancel;

  @JsonKey(name:"cnpPaymentLink")
  CnpPaymentLink? cnpPaymentLink;

  @JsonKey(name:"paymentAuthorization")
  PaymentAuthorization? paymentAuthorization;

  @JsonKey(name:"self")
  Self? self;

  @JsonKey(name:"tenantBrand")
  TenantBrand? tenantBrand;

  @JsonKey(name:"payment")
  Payment? payment;

  @JsonKey(name:"merchantBrand")
  MerchantBrand? merchantBrand;


  LinkDataModel({this.cancel,this.cnpPaymentLink,this.paymentAuthorization,this.self,this.tenantBrand,this.payment,this.merchantBrand});

  factory LinkDataModel.fromJson(Map<String, dynamic> json) => _$LinkDataModelFromJson(json);

  Map<String,dynamic> toJson() => _$LinkDataModelToJson(this);
}

@JsonSerializable()
class CancelDataModel extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  CancelDataModel({this.href});

  factory CancelDataModel.fromJson(Map<String, dynamic> json) => _$CancelDataModelFromJson(json);

  Map<String,dynamic> toJson() => _$CancelDataModelToJson(this);
}

@JsonSerializable()
class CnpPaymentLink extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  CnpPaymentLink({this.href});

  factory CnpPaymentLink.fromJson(Map<String, dynamic> json) => _$CnpPaymentLinkFromJson(json);

  Map<String,dynamic> toJson() => _$CnpPaymentLinkToJson(this);
}

@JsonSerializable()
class PaymentAuthorization extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  PaymentAuthorization({this.href});

  factory PaymentAuthorization.fromJson(Map<String, dynamic> json) => _$PaymentAuthorizationFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentAuthorizationToJson(this);
}

@JsonSerializable()
class Self extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  Self({this.href});

  factory Self.fromJson(Map<String, dynamic> json) => _$SelfFromJson(json);

  Map<String,dynamic> toJson() => _$SelfToJson(this);
}

@JsonSerializable()
class TenantBrand extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  TenantBrand({this.href});

  factory TenantBrand.fromJson(Map<String, dynamic> json) => _$TenantBrandFromJson(json);

  Map<String,dynamic> toJson() => _$TenantBrandToJson(this);
}

@JsonSerializable()
class Payment extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  Payment({this.href});

  factory Payment.fromJson(Map<String, dynamic> json) => _$PaymentFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentToJson(this);
}

@JsonSerializable()
class MerchantBrand extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  MerchantBrand({this.href});

  factory MerchantBrand.fromJson(Map<String, dynamic> json) => _$MerchantBrandFromJson(json);

  Map<String,dynamic> toJson() => _$MerchantBrandToJson(this);
}


@JsonSerializable()
class Amount extends BaseModel{
  @JsonKey(name:"currencyCode")
  String? currencyCode;

  @JsonKey(name:"value")
  dynamic? value;

  Amount({this.currencyCode,this.value});

  factory Amount.fromJson(Map<String, dynamic> json) => _$AmountFromJson(json);

  Map<String,dynamic> toJson() => _$AmountToJson(this);
}

@JsonSerializable()
class PaymentMethods extends BaseModel{
  @JsonKey(name:"card")
  List<String>? card;

  @JsonKey(name:"apm")
  List<String>? apm;

  PaymentMethods({this.card,this.apm});

  factory PaymentMethods.fromJson(Map<String, dynamic> json) => _$PaymentMethodsFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentMethodsToJson(this);
}

@JsonSerializable()
class MerchantDetails extends BaseModel{
  @JsonKey(name:"reference")
  String? reference;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"companyUrl")
  String? companyUrl;

  MerchantDetails({this.reference,this.name,this.companyUrl});

  factory MerchantDetails.fromJson(Map<String, dynamic> json) => _$MerchantDetailsFromJson(json);

  Map<String,dynamic> toJson() => _$MerchantDetailsToJson(this);
}

@JsonSerializable()
class Embedded extends BaseModel{
  @JsonKey(name:"payment")
  List<PaymentData>? payment;


  Embedded({this.payment});

  factory Embedded.fromJson(Map<String, dynamic> json) => _$EmbeddedFromJson(json);

  Map<String,dynamic> toJson() => _$EmbeddedToJson(this);
}

@JsonSerializable()
class PaymentData extends BaseModel{
  @JsonKey(name:"_id")
   String? id;

  @JsonKey(name:"_links")
  PaymentLinksData? paymentLinksData;

  @JsonKey(name:"reference")
  String? reference;

  @JsonKey(name:"state")
  String? state;

  @JsonKey(name:"amount")
  Amount? amount;

  @JsonKey(name:"updateDateTime")
  String? updateDateTime;

  @JsonKey(name:"outletId")
  String? outletId;

  @JsonKey(name:"orderReference")
  String? orderReference;


  PaymentData({this.id,this.paymentLinksData,this.reference,this.state,this.amount,
  this.updateDateTime,this.outletId,this.orderReference});

  factory PaymentData.fromJson(Map<String, dynamic> json) => _$PaymentDataFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentDataToJson(this);
}

@JsonSerializable()
class PaymentLinksData extends BaseModel{
  @JsonKey(name:"cnpChinaUnionPayTimeout")
  CnpChinaUnionPayTimeout? cnpChinaUnionPayTimeout;

  @JsonKey(name:"paymentChinaUnionPay")
  PaymentChinaUnionPay? paymentChinaUnionPay;

  @JsonKey(name:"self")
  Self? self;

  @JsonKey(name:"cnpChinaUnionPayResults")
  CnpChinaUnionPayResults? cnpChinaUnionPayResults;

  @JsonKey(name:"paymentCard")
  PaymentCard? paymentCard;

  @JsonKey(name:"paymentSavedCard")
  PaymentSavedCard? paymentSavedCard;

  @JsonKey(name:"curies")
  List<Curies>? curies;

  PaymentLinksData({this.cnpChinaUnionPayTimeout,this.cnpChinaUnionPayResults,
  this.paymentCard,this.paymentSavedCard,this.self,this.curies,this.paymentChinaUnionPay});

  factory PaymentLinksData.fromJson(Map<String, dynamic> json) => _$PaymentLinksDataFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentLinksDataToJson(this);
}

@JsonSerializable()
class CnpChinaUnionPayTimeout extends BaseModel{
  @JsonKey(name:"href")
  String? href;


  CnpChinaUnionPayTimeout({this.href});

  factory CnpChinaUnionPayTimeout.fromJson(Map<String, dynamic> json) => _$CnpChinaUnionPayTimeoutFromJson(json);

  Map<String,dynamic> toJson() => _$CnpChinaUnionPayTimeoutToJson(this);
}

@JsonSerializable()
class PaymentChinaUnionPay extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  PaymentChinaUnionPay({this.href});

  factory PaymentChinaUnionPay.fromJson(Map<String, dynamic> json) => _$PaymentChinaUnionPayFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentChinaUnionPayToJson(this);
}

@JsonSerializable()
class CnpChinaUnionPayResults extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  CnpChinaUnionPayResults({this.href});

  factory CnpChinaUnionPayResults.fromJson(Map<String, dynamic> json) => _$CnpChinaUnionPayResultsFromJson(json);

  Map<String,dynamic> toJson() => _$CnpChinaUnionPayResultsToJson(this);
}

@JsonSerializable()
class PaymentCard extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  PaymentCard({this.href});

  factory PaymentCard.fromJson(Map<String, dynamic> json) => _$PaymentCardFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentCardToJson(this);
}

@JsonSerializable()
class PaymentSavedCard extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  PaymentSavedCard({this.href});

  factory PaymentSavedCard.fromJson(Map<String, dynamic> json) => _$PaymentSavedCardFromJson(json);

  Map<String,dynamic> toJson() => _$PaymentSavedCardToJson(this);
}

@JsonSerializable()
class Curies extends BaseModel{
  @JsonKey(name:"href")
  String? href;

  @JsonKey(name:"name")
  String? name;

  @JsonKey(name:"templated")
  bool? templated;

  Curies({this.href,this.name,this.templated});

  factory Curies.fromJson(Map<String, dynamic> json) => _$CuriesFromJson(json);

  Map<String,dynamic> toJson() => _$CuriesToJson(this);
}

@JsonSerializable()
class MerchantAttributes extends BaseModel{
  @JsonKey(name:"redirectUrl")
  String? redirectUrl;

  @JsonKey(name:"skipConfirmationPage")
  String? skipConfirmationPage;

  MerchantAttributes({this.redirectUrl,this.skipConfirmationPage});

  factory MerchantAttributes.fromJson(Map<String, dynamic> json) => _$MerchantAttributesFromJson(json);

  Map<String,dynamic> toJson() => _$MerchantAttributesToJson(this);
}