
import 'package:hive/hive.dart';
import 'package:test_new/mobikul/constants/app_constants.dart';

import '../models/catalog/request/catalog_product_request.dart';
import '../network_manager/api_client.dart';

// Remove the 'late' keyword and make mainBox nullable
Box<Map<dynamic, dynamic>?>? mainBox;

// Initialize mainBox
Future<void> initializeMainBox() async {
  mainBox ??= await Hive.openBox<Map<dynamic, dynamic>>('mainBox');
}

Future<void> precCacheCategoryPage(int categoryId) async {
  await initializeMainBox();

  if (AppConstant.enablePrecache) {
    try {
      if (mainBox?.containsKey("CategoryPageData:$categoryId") == true) {
        // Data already cached
      } else if (mainBox?.containsKey("Categories:$categoryId") == true) {
        // Categories data already cached
      } else if (mainBox?.containsKey("ChildCategories:$categoryId") == true) {
        // Child categories data already cached
      } else {
        await ApiClient().getCategoryPageData(categoryId);
      }
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

Future<void> preCacheGetCatalogProducts(CatalogProductRequest request) async {
  await initializeMainBox();

  if (AppConstant.enablePrecache) {
    try {
      if (mainBox?.containsKey("CategoryPageData:${request.id}") == true) {
        // Data already cached
      } else if (mainBox?.containsKey("Categories:${request.id}") == true) {
        // Categories data already cached
      } else if (mainBox?.containsKey("ChildCategories:${request.id}") == true) {
        // Child categories data already cached
      } else {
        await ApiClient().getProductCollectionData(
          request.type ?? "",
          request.id ?? "",
          request.page ?? 1,
          request.filterData ?? [],
          request.sortData,
        );
      }
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

Future<void> precCacheProductPage(String id) async {
  await initializeMainBox();

  if (AppConstant.enablePrecache) {
    try {
      if (mainBox?.containsKey("ProductPageData:$id") == true) {
        print("Data already cached");
      } else {
        print("Caching data");
        await ApiClient().productPageDataPrecache(id);
      }
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

Future<void> precCacheHomePage(bool isRefresh) async {
  if (AppConstant.enablePrecache) {
    try {
      await ApiClient().getHomePageData(isRefresh);
    } catch (error, stacktrace) {
      print("Error --> $error");
      print("StackTrace --> $stacktrace");
    }
  }
}

Future<void> preCacheBannerData(String type, String id) async {
  if (AppConstant.enablePrecache) {
    if (type == "category") {
      Map<String, String> sort = {};
      var req = CatalogProductRequest(page: 1, id: id, type: "category", sortData: sort, filterData: []);
      await preCacheGetCatalogProducts(req);
    } else if (type == "product") {
      await precCacheProductPage(id);
    }
  }
}