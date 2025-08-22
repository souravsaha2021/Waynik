// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ngenius_payment_details_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetngeNiusrequestdata _$GetngeNiusrequestdataFromJson(
        Map<String, dynamic> json) =>
    GetngeNiusrequestdata(
      id: json['_id'] as String?,
      links: json['_links'] == null
          ? null
          : LinkDataModel.fromJson(json['_links'] as Map<String, dynamic>),
      type: json['type'] as String?,
      merchantDefinedData: (json['merchantDefinedData'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      action: json['action'] as String?,
      amount: json['amount'] == null
          ? null
          : Amount.fromJson(json['amount'] as Map<String, dynamic>),
      language: json['language'] as String?,
      merchantAttributes: json['merchantAttributes'] == null
          ? null
          : MerchantAttributes.fromJson(
              json['merchantAttributes'] as Map<String, dynamic>),
      reference: json['reference'] as String?,
      outletId: json['outletId'] as String?,
      createDateTime: json['createDateTime'] as String?,
      paymentMethods: json['paymentMethods'] == null
          ? null
          : PaymentMethods.fromJson(
              json['paymentMethods'] as Map<String, dynamic>),
      referrer: json['referrer'] as String?,
      merchantDetails: json['merchantDetails'] == null
          ? null
          : MerchantDetails.fromJson(
              json['merchantDetails'] as Map<String, dynamic>),
      isSplitPayment: json['isSplitPayment'] as bool?,
      formattedOrderSummary: (json['formattedOrderSummary'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      formattedAmount: json['formattedAmount'] as String?,
      formattedOriginalAmount: json['formattedOriginalAmount'] as String?,
      embedded: json['_embedded'] == null
          ? null
          : Embedded.fromJson(json['_embedded'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$GetngeNiusrequestdataToJson(
        GetngeNiusrequestdata instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      '_id': instance.id,
      '_links': instance.links,
      'type': instance.type,
      'merchantDefinedData': instance.merchantDefinedData,
      'action': instance.action,
      'amount': instance.amount,
      'language': instance.language,
      'merchantAttributes': instance.merchantAttributes,
      'reference': instance.reference,
      'outletId': instance.outletId,
      'createDateTime': instance.createDateTime,
      'paymentMethods': instance.paymentMethods,
      'referrer': instance.referrer,
      'merchantDetails': instance.merchantDetails,
      'isSplitPayment': instance.isSplitPayment,
      'formattedOrderSummary': instance.formattedOrderSummary,
      'formattedAmount': instance.formattedAmount,
      'formattedOriginalAmount': instance.formattedOriginalAmount,
      '_embedded': instance.embedded,
    };

LinkDataModel _$LinkDataModelFromJson(Map<String, dynamic> json) =>
    LinkDataModel(
      cancel: json['cancel'] == null
          ? null
          : CancelDataModel.fromJson(json['cancel'] as Map<String, dynamic>),
      cnpPaymentLink: json['cnpPaymentLink'] == null
          ? null
          : CnpPaymentLink.fromJson(
              json['cnpPaymentLink'] as Map<String, dynamic>),
      paymentAuthorization: json['paymentAuthorization'] == null
          ? null
          : PaymentAuthorization.fromJson(
              json['paymentAuthorization'] as Map<String, dynamic>),
      self: json['self'] == null
          ? null
          : Self.fromJson(json['self'] as Map<String, dynamic>),
      tenantBrand: json['tenantBrand'] == null
          ? null
          : TenantBrand.fromJson(json['tenantBrand'] as Map<String, dynamic>),
      payment: json['payment'] == null
          ? null
          : Payment.fromJson(json['payment'] as Map<String, dynamic>),
      merchantBrand: json['merchantBrand'] == null
          ? null
          : MerchantBrand.fromJson(
              json['merchantBrand'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$LinkDataModelToJson(LinkDataModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'cancel': instance.cancel,
      'cnpPaymentLink': instance.cnpPaymentLink,
      'paymentAuthorization': instance.paymentAuthorization,
      'self': instance.self,
      'tenantBrand': instance.tenantBrand,
      'payment': instance.payment,
      'merchantBrand': instance.merchantBrand,
    };

CancelDataModel _$CancelDataModelFromJson(Map<String, dynamic> json) =>
    CancelDataModel(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CancelDataModelToJson(CancelDataModel instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

CnpPaymentLink _$CnpPaymentLinkFromJson(Map<String, dynamic> json) =>
    CnpPaymentLink(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CnpPaymentLinkToJson(CnpPaymentLink instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

PaymentAuthorization _$PaymentAuthorizationFromJson(
        Map<String, dynamic> json) =>
    PaymentAuthorization(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentAuthorizationToJson(
        PaymentAuthorization instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

Self _$SelfFromJson(Map<String, dynamic> json) => Self(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$SelfToJson(Self instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

TenantBrand _$TenantBrandFromJson(Map<String, dynamic> json) => TenantBrand(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$TenantBrandToJson(TenantBrand instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

Payment _$PaymentFromJson(Map<String, dynamic> json) => Payment(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentToJson(Payment instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

MerchantBrand _$MerchantBrandFromJson(Map<String, dynamic> json) =>
    MerchantBrand(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$MerchantBrandToJson(MerchantBrand instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

Amount _$AmountFromJson(Map<String, dynamic> json) => Amount(
      currencyCode: json['currencyCode'] as String?,
      value: json['value'],
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$AmountToJson(Amount instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'currencyCode': instance.currencyCode,
      'value': instance.value,
    };

PaymentMethods _$PaymentMethodsFromJson(Map<String, dynamic> json) =>
    PaymentMethods(
      card: (json['card'] as List<dynamic>?)?.map((e) => e as String).toList(),
      apm: (json['apm'] as List<dynamic>?)?.map((e) => e as String).toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentMethodsToJson(PaymentMethods instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'card': instance.card,
      'apm': instance.apm,
    };

MerchantDetails _$MerchantDetailsFromJson(Map<String, dynamic> json) =>
    MerchantDetails(
      reference: json['reference'] as String?,
      name: json['name'] as String?,
      companyUrl: json['companyUrl'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$MerchantDetailsToJson(MerchantDetails instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'reference': instance.reference,
      'name': instance.name,
      'companyUrl': instance.companyUrl,
    };

Embedded _$EmbeddedFromJson(Map<String, dynamic> json) => Embedded(
      payment: (json['payment'] as List<dynamic>?)
          ?.map((e) => PaymentData.fromJson(e as Map<String, dynamic>))
          .toList(),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$EmbeddedToJson(Embedded instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'payment': instance.payment,
    };

PaymentData _$PaymentDataFromJson(Map<String, dynamic> json) => PaymentData(
      id: json['_id'] as String?,
      paymentLinksData: json['_links'] == null
          ? null
          : PaymentLinksData.fromJson(json['_links'] as Map<String, dynamic>),
      reference: json['reference'] as String?,
      state: json['state'] as String?,
      amount: json['amount'] == null
          ? null
          : Amount.fromJson(json['amount'] as Map<String, dynamic>),
      updateDateTime: json['updateDateTime'] as String?,
      outletId: json['outletId'] as String?,
      orderReference: json['orderReference'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentDataToJson(PaymentData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      '_id': instance.id,
      '_links': instance.paymentLinksData,
      'reference': instance.reference,
      'state': instance.state,
      'amount': instance.amount,
      'updateDateTime': instance.updateDateTime,
      'outletId': instance.outletId,
      'orderReference': instance.orderReference,
    };

PaymentLinksData _$PaymentLinksDataFromJson(Map<String, dynamic> json) =>
    PaymentLinksData(
      cnpChinaUnionPayTimeout: json['cnpChinaUnionPayTimeout'] == null
          ? null
          : CnpChinaUnionPayTimeout.fromJson(
              json['cnpChinaUnionPayTimeout'] as Map<String, dynamic>),
      cnpChinaUnionPayResults: json['cnpChinaUnionPayResults'] == null
          ? null
          : CnpChinaUnionPayResults.fromJson(
              json['cnpChinaUnionPayResults'] as Map<String, dynamic>),
      paymentCard: json['paymentCard'] == null
          ? null
          : PaymentCard.fromJson(json['paymentCard'] as Map<String, dynamic>),
      paymentSavedCard: json['paymentSavedCard'] == null
          ? null
          : PaymentSavedCard.fromJson(
              json['paymentSavedCard'] as Map<String, dynamic>),
      self: json['self'] == null
          ? null
          : Self.fromJson(json['self'] as Map<String, dynamic>),
      curies: (json['curies'] as List<dynamic>?)
          ?.map((e) => Curies.fromJson(e as Map<String, dynamic>))
          .toList(),
      paymentChinaUnionPay: json['paymentChinaUnionPay'] == null
          ? null
          : PaymentChinaUnionPay.fromJson(
              json['paymentChinaUnionPay'] as Map<String, dynamic>),
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentLinksDataToJson(PaymentLinksData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'cnpChinaUnionPayTimeout': instance.cnpChinaUnionPayTimeout,
      'paymentChinaUnionPay': instance.paymentChinaUnionPay,
      'self': instance.self,
      'cnpChinaUnionPayResults': instance.cnpChinaUnionPayResults,
      'paymentCard': instance.paymentCard,
      'paymentSavedCard': instance.paymentSavedCard,
      'curies': instance.curies,
    };

CnpChinaUnionPayTimeout _$CnpChinaUnionPayTimeoutFromJson(
        Map<String, dynamic> json) =>
    CnpChinaUnionPayTimeout(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CnpChinaUnionPayTimeoutToJson(
        CnpChinaUnionPayTimeout instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

PaymentChinaUnionPay _$PaymentChinaUnionPayFromJson(
        Map<String, dynamic> json) =>
    PaymentChinaUnionPay(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentChinaUnionPayToJson(
        PaymentChinaUnionPay instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

CnpChinaUnionPayResults _$CnpChinaUnionPayResultsFromJson(
        Map<String, dynamic> json) =>
    CnpChinaUnionPayResults(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CnpChinaUnionPayResultsToJson(
        CnpChinaUnionPayResults instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

PaymentCard _$PaymentCardFromJson(Map<String, dynamic> json) => PaymentCard(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentCardToJson(PaymentCard instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

PaymentSavedCard _$PaymentSavedCardFromJson(Map<String, dynamic> json) =>
    PaymentSavedCard(
      href: json['href'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$PaymentSavedCardToJson(PaymentSavedCard instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
    };

Curies _$CuriesFromJson(Map<String, dynamic> json) => Curies(
      href: json['href'] as String?,
      name: json['name'] as String?,
      templated: json['templated'] as bool?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$CuriesToJson(Curies instance) => <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'href': instance.href,
      'name': instance.name,
      'templated': instance.templated,
    };

MerchantAttributes _$MerchantAttributesFromJson(Map<String, dynamic> json) =>
    MerchantAttributes(
      redirectUrl: json['redirectUrl'] as String?,
      skipConfirmationPage: json['skipConfirmationPage'] as String?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt();

Map<String, dynamic> _$MerchantAttributesToJson(MerchantAttributes instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'redirectUrl': instance.redirectUrl,
      'skipConfirmationPage': instance.skipConfirmationPage,
    };
