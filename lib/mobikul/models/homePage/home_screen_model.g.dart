// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'home_screen_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HomePageData _$HomePageDataFromJson(Map<String, dynamic> json) => HomePageData(
      defaultCurrency: json['defaultCurrency'] as String?,
      allowedCurrencies: (json['allowedCurrencies'] as List<dynamic>?)
          ?.map((e) => AllowedCurrencies.fromJson(e as Map<String, dynamic>))
          .toList(),
      priceFormat: json['priceFormat'] == null
          ? null
          : PriceFormat.fromJson(json['priceFormat'] as Map<String, dynamic>),
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
      featuredCategories: (json['featuredCategories'] as List<dynamic>?)
          ?.map((e) => FeaturedCategories.fromJson(e as Map<String, dynamic>))
          .toList(),
      bannerImages: (json['bannerImages'] as List<dynamic>?)
          ?.map((e) => Banners.fromJson(e as Map<String, dynamic>))
          .toList(),
      carousel: (json['carousel'] as List<dynamic>?)
          ?.map((e) => Carousel.fromJson(e as Map<String, dynamic>))
          .toList(),
      websiteData: (json['websiteData'] as List<dynamic>?)
          ?.map((e) => WebsiteData.fromJson(e as Map<String, dynamic>))
          .toList(),
      storeData: (json['storeData'] as List<dynamic>?)
          ?.map((e) => LanguageData.fromJson(e as Map<String, dynamic>))
          .toList(),
      wishlistEnable: json['wishlistEnable'] as String?,
      customerName: json['customerName'] as String?,
      customerEmail: json['customerEmail'] as String?,
      themeType: (json['themeType'] as num?)?.toInt(),
      tabCategoryView: json['tabCategoryView'] as String?,
      productId: json['productId'] as String?,
      productName: json['productName'] as String?,
      categoryId: json['categoryId'] as String?,
      categoryName: json['categoryName'] as String?,
      sortOrder: (json['sortOrder'] as List<dynamic>?)
          ?.map((e) => SortOrder.fromJson(e as Map<String, dynamic>))
          .toList(),
      walkthroughVersion: json['walkthroughVersion'] as String?,
      websiteId: json['websiteId'],
      watchEnabled: json['watchEnabled'] as bool?,
      darkAppThemeColor: json['darkAppThemeColor'] as String?,
      darkAppButtonColor: json['darkAppButtonColor'] as String?,
      appThemeColor: json['appThemeColor'] as String?,
      appButtonColor: json['appButtonColor'] as String?,
      buttonTextColor: json['buttonTextColor'] as String?,
      darkButtonTextColor: json['darkButtonTextColor'] as String?,
      launcherIconType: json['launcherIconType'] as String?,
      customerWishlist: json['customerWishlist'] as List<dynamic>?,
    )
      ..success = json['success'] as bool?
      ..message = json['message'] as String?
      ..otherError = json['otherError'] as String?
      ..redirect = json['redirect'] as String?
      ..eTag = json['eTag'] as String?
      ..cartCount = (json['cartCount'] as num?)?.toInt()
      ..cmsData = (json['cmsData'] as List<dynamic>?)
          ?.map((e) => CmsData.fromJson(e as Map<String, dynamic>))
          .toList()
      ..appLogo = json['appLogo'] as String?
      ..darkAppLogo = json['darkAppLogo'] as String?
      ..splashImage = json['splashImage'] as String?
      ..darkSplashImage = json['darkSplashImage'] as String?
      ..darkAppThemeTextColor = json['darkAppThemeTextColor'] as String?
      ..appThemeTextColor = json['appThemeTextColor'] as String?;

Map<String, dynamic> _$HomePageDataToJson(HomePageData instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'otherError': instance.otherError,
      'redirect': instance.redirect,
      'eTag': instance.eTag,
      'cartCount': instance.cartCount,
      'defaultCurrency': instance.defaultCurrency,
      'customerWishlist': instance.customerWishlist,
      'allowedCurrencies': instance.allowedCurrencies,
      'priceFormat': instance.priceFormat,
      'categories': instance.categories,
      'featuredCategories': instance.featuredCategories,
      'bannerImages': instance.bannerImages,
      'carousel': instance.carousel,
      'websiteData': instance.websiteData,
      'storeData': instance.storeData,
      'cmsData': instance.cmsData,
      'wishlistEnable': instance.wishlistEnable,
      'customerName': instance.customerName,
      'customerEmail': instance.customerEmail,
      'watchEnabled': instance.watchEnabled,
      'themeType': instance.themeType,
      'tabCategoryView': instance.tabCategoryView,
      'productId': instance.productId,
      'productName': instance.productName,
      'categoryId': instance.categoryId,
      'categoryName': instance.categoryName,
      'sortOrder': instance.sortOrder,
      'walkthroughVersion': instance.walkthroughVersion,
      'appLogo': instance.appLogo,
      'darkAppLogo': instance.darkAppLogo,
      'splashImage': instance.splashImage,
      'darkSplashImage': instance.darkSplashImage,
      'websiteId': instance.websiteId,
      'darkAppThemeColor': instance.darkAppThemeColor,
      'darkAppButtonColor': instance.darkAppButtonColor,
      'darkAppThemeTextColor': instance.darkAppThemeTextColor,
      'appThemeTextColor': instance.appThemeTextColor,
      'appThemeColor': instance.appThemeColor,
      'appButtonColor': instance.appButtonColor,
      'darkButtonTextColor': instance.darkButtonTextColor,
      'buttonTextColor': instance.buttonTextColor,
      'launcherIconType': instance.launcherIconType,
    };
