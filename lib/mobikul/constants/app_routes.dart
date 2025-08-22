

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
import 'package:page_transition/page_transition.dart';
import 'package:test_new/mobikul/app_widgets/Tabbar/bottom_tabbar.dart';
import 'package:test_new/mobikul/models/order_details/order_detail_model.dart';

import 'package:test_new/mobikul/screens/address/add_edit_address_screen.dart';
import 'package:test_new/mobikul/screens/address/bloc/add_edit_address_screen_bloc.dart';
import 'package:test_new/mobikul/screens/address_book/address_book_screen.dart';
import 'package:test_new/mobikul/screens/address_book/bloc/address_book_screen_bloc.dart';
import 'package:test_new/mobikul/screens/address_book/bloc/address_book_screen_repository.dart';
import 'package:test_new/mobikul/screens/cart/bloc/cart_screen_bloc.dart';
import 'package:test_new/mobikul/screens/cart/bloc/cart_screen_repository.dart';
import 'package:test_new/mobikul/screens/cart/cart_screen.dart';
import 'package:test_new/mobikul/screens/compare_products/bloc/compare_product_bloc.dart';
import 'package:test_new/mobikul/screens/compare_products/bloc/compare_product_repository.dart';
import 'package:test_new/mobikul/screens/compare_products/compare_product_screen.dart';
import 'package:test_new/mobikul/screens/contact_us/bloc/contact_us_screen_bloc.dart';
import 'package:test_new/mobikul/screens/contact_us/bloc/contact_us_screen_repository.dart';
import 'package:test_new/mobikul/screens/downloadable_products/bloc/downloadable_products_screen_bloc.dart';
import 'package:test_new/mobikul/screens/downloadable_products/bloc/downloadable_products_screen_repository.dart';
import 'package:test_new/mobikul/screens/downloadable_products/downloadable_products_screen.dart';
import 'package:test_new/mobikul/screens/notifications/bloc/notification_screen_repository.dart';
import 'package:test_new/mobikul/screens/notifications/bloc/splash_screen_bloc.dart';
import 'package:test_new/mobikul/screens/notifications/notification_screen.dart';
import 'package:test_new/mobikul/screens/review_details/block/review_details_screen_bloc.dart';
import 'package:test_new/mobikul/screens/review_details/block/review_details_screen_repository.dart';
import 'package:test_new/mobikul/screens/review_details/review_details.dart';
import 'package:test_new/mobikul/screens/search/advance_search/advance_search.dart';
import 'package:test_new/mobikul/screens/search/advance_search/bloc/advance_search_bloc.dart';
import 'package:test_new/mobikul/screens/search/advance_search/bloc/advance_search_repository.dart';
import 'package:test_new/mobikul/screens/search/simple_search/bloc/search_bloc.dart';
import 'package:test_new/mobikul/screens/search/simple_search/bloc/search_repository.dart';

import 'package:test_new/mobikul/screens/search/simple_search/search_screen.dart';
import 'package:test_new/mobikul/screens/order_shipment/bloc/order_shipment_screen_bloc.dart';
import 'package:test_new/mobikul/screens/order_shipment/bloc/order_shipment_screen_repository.dart';
import 'package:test_new/mobikul/screens/order_shipment/order_shipment_screen.dart';
// import 'package:test_new/mobikul/screens/invoice_screen/bloc/invoice_screen_bloc.dart';
// import 'package:test_new/mobikul/screens/invoice_screen/bloc/invoice_screen_repository.dart';
// import 'package:test_new/mobikul/screens/invoice_screen/invoice_screen.dart';
import 'package:test_new/mobikul/screens/settings/bloc/settings_screen_bloc.dart';
import 'package:test_new/mobikul/screens/settings/bloc/settings_screen_repository.dart';
import 'package:test_new/mobikul/screens/settings/settings_screen.dart';
import 'package:test_new/mobikul/screens/view_invoice/bloc/view_invoice_screen_bloc.dart';
import 'package:test_new/mobikul/screens/view_invoice/bloc/view_invoice_screen_repository.dart';
import 'package:test_new/mobikul/screens/view_invoice/view_invoice_screen.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_bloc.dart';
import 'package:test_new/mobikul/screens/wishlist/bloc/wishlist_screen_repository.dart';
import 'package:test_new/mobikul/screens/wishlist/wishlist_screen.dart';
import 'package:test_new/mobikul/screens/wishlist_comment/wishlist_comment_bloc/whishlist_comment_screen_bloc.dart';
import 'package:test_new/mobikul/screens/wishlist_comment/wishlist_comment_bloc/wishlist_comment_screen_repository.dart';
import 'package:test_new/mobikul/screens/wishlist_comment/wishlist_comment_screen.dart';
import 'package:test_new/mobikul/screens/wishlist_sharing/bloc/whishlist_sharing_screen_bloc.dart';
import 'package:test_new/mobikul/screens/wishlist_sharing/bloc/wishlist_sharing_screen_repository.dart';
import 'package:test_new/mobikul/screens/wishlist_sharing/wishlist_sharing.dart';

import '../models/address/address_form_data.dart';
import '../models/deliveryBoyDetails/delivery_boy_details_model.dart';
import '../screens/account_info/account_info_screen.dart';
import '../screens/account_info/bloc/account_info_bloc.dart';
import '../screens/account_info/bloc/account_info_repository.dart';
import '../screens/address/bloc/add_edit_address_repository_screen.dart';
import '../screens/cms_page/bloc/cms_page_bloc.dart';
import '../screens/cms_page/bloc/cms_page_repository.dart';
import '../screens/cms_page/cms_page_screen.dart';
import '../screens/contact_us/contact_us_screen.dart';

import 'package:test_new/mobikul/screens/category/bloc/category_screen_bloc.dart';
import 'package:test_new/mobikul/screens/category/bloc/category_screen_repository.dart';
import 'package:test_new/mobikul/screens/category/category_screen.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/Payment_info_bloc.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/bloc/payment_info_repository.dart';
import 'package:test_new/mobikul/screens/checkout/payment_info/payment_info_screen.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/bloc/shipping_screen_bloc.dart';
import 'package:test_new/mobikul/screens/checkout/shipping_info/bloc/shipping_screen_repository.dart';
import 'package:test_new/mobikul/screens/home/bloc/home_screen_bloc.dart';
import 'package:test_new/mobikul/screens/home/bloc/home_screen_repository.dart';
import 'package:test_new/mobikul/screens/home/home_screen.dart';
import 'package:test_new/mobikul/screens/product_detail/bloc/product_detail_screen_bloc.dart';
import 'package:test_new/mobikul/screens/product_detail/bloc/product_detail_screen_repository.dart';
import 'package:test_new/mobikul/screens/subcategory/bloc/subcategory_screen_bloc.dart';
import 'package:test_new/mobikul/screens/subcategory/bloc/subcategory_screen_repository.dart';
import 'package:test_new/mobikul/screens/subcategory/subcategory_screen.dart';

import '../app_widgets/lottie_animation.dart';
import '../screens/catalog/bloc/catalog_screen_bloc.dart';
import '../screens/catalog/bloc/catalog_screen_repository.dart';
import '../screens/catalog/catalog_screen.dart';
import '../screens/checkout/shipping_info/shipping_screen.dart';
import '../screens/dashboard/bloc/dashboard_bloc.dart';
import '../screens/dashboard/bloc/dashboard_repository.dart';
import '../screens/dashboard/dashboard_screen.dart';
import '../screens/deliverboy_admin_chat/bloc/deliveryboy_help_chat_bloc.dart';
import '../screens/deliverboy_admin_chat/bloc/deliveryboy_help_chat_repository.dart';
import '../screens/deliverboy_admin_chat/widgets/deliveryboy_help_chat_screen.dart';
import '../screens/delivery_tracking/delivery_tracking_screen.dart';
import '../screens/deliveryboy_track_screen/bloc/deliveryboy_track_bloc.dart';
import '../screens/deliveryboy_track_screen/bloc/deliveryboy_track_repository.dart';
import '../screens/deliveryboy_track_screen/deliveryboy_track_screen.dart';
import '../screens/invoice_screen/bloc/invoice_screen_bloc.dart';
import '../screens/invoice_screen/bloc/invoice_screen_repository.dart';
import '../screens/invoice_screen/invoice_screen.dart';
import '../screens/login_signup/bloc/signin_signup_screen_bloc.dart';
import '../screens/login_signup/bloc/signin_signup_screen_repository.dart';
import '../screens/login_signup/signin_signup_screen.dart';
import '../screens/order_details/bloc/order_detail_screen_bloc.dart';
import '../screens/order_details/bloc/order_detail_screen_repository.dart';
import '../screens/order_details/order_detail_screen.dart';
import '../screens/orders_and_returns/bloc/orders_and_returns_screen_bloc.dart';
import '../screens/orders_and_returns/bloc/orders_and_returns_screen_repository.dart';
import '../screens/orders_and_returns/orders_and_returns_screen.dart';
import '../screens/orders_list/bloc/order_screen_bloc.dart';
import '../screens/orders_list/bloc/order_screen_repository.dart';
import '../screens/orders_list/orders_screen.dart';
import '../screens/product_detail/product_details.dart';
import '../screens/qr_scanner_screen/bloc/qr_screen_bloc.dart';
import '../screens/qr_scanner_screen/bloc/qr_screen_repository.dart';
import '../screens/qr_scanner_screen/widget/qr_screen.dart';
import '../screens/refund_screen/bloc/refund_screen_bloc.dart';
import '../screens/refund_screen/bloc/refund_screen_repository.dart';
import '../screens/refund_screen/refund_screen.dart';
import '../screens/reviews/block/reviews_screen_bloc.dart';
import '../screens/reviews/block/reviews_screen_repository.dart';
import '../screens/reviews/reviews_screen.dart';
import '../screens/splash/bloc/splash_screen_bloc.dart';
import '../screens/splash/bloc/splash_screen_repository.dart';
import '../screens/splash/splash_screen.dart';
import '../screens/view_track_info/bloc/view_order_tack_repository.dart';
import '../screens/view_track_info/bloc/view_order_track_bloc.dart';
import '../screens/view_track_info/view_track_screen.dart';
import '../screens/walk_through/bloc/walk_through_bloc.dart';
import '../screens/walk_through/bloc/walk_through_repository.dart';
import '../screens/walk_through/walk_through_screen.dart';
import 'app_constants.dart';
import 'arguments_map.dart';

class AppRoutes {

  static const String splash = 'splash';
  static const String bottomTabBar = 'bottomTabBar';
  static const String cart = 'cart';
  static const String contactUs = 'contactUs';
  static const String catalog = "catalog";
  static const String productPage = 'productPage';

  static const String dashboardScreen = "dashboardScreen";
  static const String wishlist = "wishlist";
  static const String orderList = "orderList";
  static const String downloadableProducts = "downloadableProducts";
  static const String productReview = "productReview";
  static const String addressBook = "addressBook";
  static const String accountInfo = "accountInfo";
  static const String signInSignUp = 'signInSignUp';
  static const String settingsScreen = 'settingsScreen';
  static const String about = 'about';
  static const String category="category";
  static const String home="home";
  static const String subCategory = 'subCategory';
  static const String orderDetail = "orderDetail";
  static const String shippingIfo = "shippingInfo";
  static const String paymentInfo = "paymentInfo";

  static const String addEditAddress = 'addEditAddress';
  static const String wishListSharing = 'wishListSharing';
  static const String wishlistComment = 'wishlistComment';
  static const String dashboard = 'dashboard';
  static const String invoiceScreen = 'invoiceScreen';
  static const String orderShipment = 'orderShipment';
  static const String notification = 'notification';
  static const String compareProduct = 'compareProduct';
  static const String search = 'search';
  static const String advanceSearch = 'advanceSearch';
  static const String reviewDetail = 'reviewDetail';
  static const String orderTrack = "orderTrack";
  static const String ordersAndReturns = "ordersAndReturns";
  static const String cmsPage = "cmsPage";
  static const String walkThrough = "walkThrough";
  static const String refundScreen = 'refundScreen';
  static const String deliveryboyHelpChatScreen = 'deliveryboyHelpChatScreen';
  static const String deliveryboyTrackScreen = 'deliveryboyTrackScreen';
  static const String qrScreen = 'qrScreen';
  static const String deliveryTrackingScreen = 'deliveryTrackingScreen';




  static Route<dynamic> generateRoute(RouteSettings settings){
    switch(settings.name) {
      case splash:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SplashScreenBloc>(
              create: (context) => SplashScreenBloc(
                  splashScreenRepository: SplashscreenRepositoryImp()),
              child: const SplashScreen(),
            ));
      case bottomTabBar:
        return MaterialPageRoute(
          builder: (_) => const BottomTabBarWidget(),
        );

      case category:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => CategoryScreenBloc(
              repository: CategoryScreenRepositoryImp(),
            ),
            child: const CategoryScreen(),
          ),
        );

      case home:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => HomeScreenBloc(
              repository: HomeScreenRepositoryImp(),
            ),
            child: const HomeScreen(),
          ),
        );
      case signInSignUp:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) => SigninSignupScreenBloc(
                    repository: SigninSignupScreenRepositoryImp()),
                child: const SignInSignUpScreen()));

      case contactUs:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) =>
                    ContactUsBloc(repository: ContactUsRepositoryImp()),
                child: const ContactUs()));

      case ordersAndReturns:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) =>
                    OrdersAndReturnsBloc(repository: OrdersAndReturnsRepositoryImp()),
                child: const OrdersAndReturns()));

      case addEditAddress:
        String? id;
        AddressDataModel? addressDataModel;
        bool? isFromCheckout;
        bool? isDefault;
        if (settings.arguments != null) {
          id = (settings.arguments as Map<String, dynamic>)[addressId];
          addressDataModel = (settings.arguments as Map<String, dynamic>)[address];
          isFromCheckout = (settings.arguments as Map<String, dynamic>)[isCheckout]??false;
          isDefault = (settings.arguments as Map<String, dynamic>)[isDefaultAddress] ?? false;
        }
        return MaterialPageRoute(
          builder: (_) => BlocProvider<AddEditAddressScreenBloc>(
              create: (context) => AddEditAddressScreenBloc(repository: AddEditAddressScreenRepositoryImp()),
              child: AddEditAddressScreen(id, addressDataModel, isFromCheckout, isDefault)));

      case wishlist:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<WishlistScreenBloc>(
              create: (context) => WishlistScreenBloc(repository: WishlistScreenRepositoryImp()),
              child: const WishlistScreen()));

      case wishlistComment:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<WishlistCommentScreenBloc>(
              create: (context) => WishlistCommentScreenBloc(repository: WishlistCommentScreenRepositoryImp()),
              child: const WishlistCommentScreen()));

      case wishListSharing:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<WishlistSharingBloc>(
              create: (context) => WishlistSharingBloc(repository: WishlistSharingRepositoryImp()),
              child: const WishlistSharing()));

      case settingsScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SettingsScreenBloc>(
              create: (context) => SettingsScreenBloc(repository: SettingsScreenRepositoryImp()),
              child: const SettingsScreen()));

      case cart:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<CartScreenBloc>(
              create: (context) => CartScreenBloc(repository: CartScreenRepositoryImp()),
              child: const CartScreen()));

      case addressBook:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<AddressBookScreenBloc>(
                create: (context) =>
                    AddressBookScreenBloc(repository: AddressBookRepositoryScreenImp()),
                child:
                AddressBookScreen()));

      case downloadableProducts:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<DownloadableProductsScreenBloc>(
                create: (context) =>
                    DownloadableProductsScreenBloc(repository: DownloadableProductsScreenRepositoryImp()),
                child:
                DownloadableProductsScreen(settings.arguments as bool)));

      case subCategory:
        return MaterialPageRoute(
            builder: (_) => BlocProvider<SubCategoryScreenBloc>(
                create: (context) =>
                    SubCategoryScreenBloc(repository: SubCategoryScreenRepositoryImp()),
                child:
                SubCategoryScreen(settings.arguments as Map<String, dynamic>)));

      case orderList:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  OrderScreenBloc(repository: OrderScreenRepositoryImp()),
              child: OrderScreen(settings.arguments as bool),
            ));

      case orderDetail:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                OrderDetailsBloc(repository: OrderDetailRepositoryImp()),
            child: OrderDetails(settings.arguments as String),
          ),
          settings: settings,
        );

      case productPage:
      // return   MaterialPageRoute(
      //   builder: (_) => BlocProvider(
      //       create: (context) =>
      //           ProductDetailScreenBloc(repository: ProductDetailScreenRepositoryImp()),
      //       child: ProductDetails(
      //           settings.arguments as Map<String, dynamic>
      //       )
      //   ),
      // );
      return  PageTransition(
          duration: const Duration(milliseconds: 0),
          type: PageTransitionType.leftToRight,

          child:
          BlocProvider(
              create: (context) =>
                  ProductDetailScreenBloc(repository: ProductDetailScreenRepositoryImp()),
              child: ProductDetails(
                  settings.arguments as Map<String, dynamic>
              )
        ));


      case catalog:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) =>
                CatalogScreenBloc(repository: CatalogRepositoryImpl()),
            child: CatalogScreen(
              settings.arguments as Map<String, dynamic>,
            ),
          ),
          settings: settings,
        );

      case dashboard:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                DashboardBloc(repository: DashboardRepositoryImp()),
            child: const DashboardScreen(),
          ),
          settings: settings,
        );
      case accountInfo:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
                create: (context) =>
                    AccountInfoBloc(repository: AccountInfoRepositoryImp()),
                child: const AccountInfoScreen()));

      case productReview:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  ReviewsScreenBloc(repository: ReviewsScreenRepositoryImp()),
              child: ReviewsScreen(settings.arguments as bool),
            ));

      case shippingIfo:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  ShippingScreenBloc(repository: ShippingScreenRepositoryImp()),
              child: ShippingScreen(settings.arguments as String),
            ));
        case paymentInfo:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  PaymentInfoScreenBloc(repository: PaymentInfoScreenRepositoryImp()),
              child: PaymentInfoScreen(settings.arguments as Map<String, dynamic>),
            ));
      case notification:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  NotificationScreenBloc(repository: NotificationScreenRepositoryImp()),
              child: const NotificationScreen(),
            ));
      case compareProduct:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  CompareProductBloc(repository: CompareProductRepositoryImp()),
              child:  CompareProducts(),
            ));
      case search:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  SearchScreenBloc(repository: SearchRepositoryImp()),
              child:  const SearchScreen(),

            ));
        case advanceSearch:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  AdvanceSearchScreenBloc(repository: AdvanceSearchRepositoryImp()),
              child:   AdvanceSearchScreen(),

            ));


      case invoiceScreen:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) =>
                InvoiceScreenBloc(repository: InvoiceScreenRepositoryImp()),
            child: InvoiceScreen(
              settings.arguments as OrderDetailModel,
            ),
          ),
          settings: settings,
        );

      case orderShipment:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) =>
                OrderShipmentScreenBloc(repository: OrderShipmentScreenRepositoryImp()),
            child: OrderShipmentScreen(
              settings.arguments as OrderDetailModel,
            ),
          ),
          settings: settings,
        );
      case reviewDetail:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ReviewDetailsScreenBloc(repository: ReviewDetailsScreenRepositoryImp()),
            child: ReviewDetailsScreen(settings.arguments as String),
          ),
          settings: settings,
        );

      case orderTrack:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                ViewOrderTrackBloc(repository: ViewOrderTrackRepositoryImp()),
            child: ViewTrackScreen(settings.arguments as String),
          ),
          settings: settings,
        );

      case walkThrough:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) =>
                WalkThroughBloc(repository: WalkThroughRepositoryImp()),
            child: const WalkThroughScreen(),
          ),
          settings: settings,
        );

      case cmsPage:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                    CmsPageBloc(repository: CmsPageRepositoryImp()),
              child: CmsPage(settings.arguments as Map<String, dynamic>),
            ));

      case refundScreen:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) =>
                RefundScreenBloc(repository: RefundScreenRepositoryImp()),
            child: RefundScreen(
              settings.arguments as OrderDetailModel,
            ),
          ),
          settings: settings,
        );

/*
      case deliveryboyHelpChatScreen:
        return MaterialPageRoute(
            builder: (context) =>
                DeliveryboyHelpChatScreen(settings.arguments as AssignedDeliveryBoyDetails)

        );
*/

      case deliveryboyTrackScreen:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) =>
                DeliveryboyTrackBloc(repository: DeliveryboyTrackRepositoryImp()),
            child: DeliveryboyTrackScreen(settings.arguments as AssignedDeliveryBoyDetails,),
          ),
          settings: settings,
        );

      case deliveryTrackingScreen:
        return MaterialPageRoute(
            builder: (context) =>
                DeliveryTrackingScreen(
                  assignedDeliveryBoyDetails: (settings.arguments as AssignedDeliveryBoyDetails),
                )

        );


      case deliveryboyHelpChatScreen:
        return MaterialPageRoute(
          builder: (ctx) => BlocProvider(
            create: (context) =>
                DeliveryboyHelpChatBloc(repository: DeliveryboyHelpChatRepositoryImp()),
            child: DeliveryboyHelpChatScreen(settings.arguments as AssignedDeliveryBoyDetails),
          ),
          settings: settings,
        );
      case qrScreen:
        return MaterialPageRoute(
            builder: (_) => BlocProvider(
              create: (context) =>
                  QrScreenBloc(repository: QrScreenRepositoryImp()),
              child: QrScreen(),
            ));


      default:
        return _errorRoute();
    }
  }

  static Route<dynamic> _errorRoute() {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: const Text('Error'),
        ),
        body: Visibility(
          visible: true,
          child: LottieAnimation(
            lottiePath: AppImages.emptyAddressLottie,
            title: "ERROR",
            subtitle: "No option found",
            buttonTitle: "This Feature is not available",
            onPressed: () {},
          ),
        ),
      );
    });
  }

}