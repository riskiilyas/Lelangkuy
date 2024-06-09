import '../../app/modules/auction_list_module/auction_list_page.dart';
import '../../app/modules/auction_list_module/auction_list_bindings.dart';
import '../../app/modules/bookmarked_auctions_module/bookmarked_auctions_page.dart';
import '../../app/modules/bookmarked_auctions_module/bookmarked_auctions_bindings.dart';
import '../../app/modules/edit_profile_module/edit_profile_page.dart';
import '../../app/modules/edit_profile_module/edit_profile_bindings.dart';
import '../../app/modules/splash_module/splash_page.dart';
import '../../app/modules/splash_module/splash_bindings.dart';
import '../../app/modules/my_auction_module/my_auction_page.dart';
import '../../app/modules/my_auction_module/my_auction_bindings.dart';
import '../../app/modules/add_auction_module/add_auction_page.dart';
import '../../app/modules/add_auction_module/add_auction_bindings.dart';
import '../../app/modules/auction_detail_module/auction_detail_page.dart';
import '../../app/modules/auction_detail_module/auction_detail_bindings.dart';
import '../../app/modules/profile_module/profile_page.dart';
import '../../app/modules/profile_module/profile_bindings.dart';
import '../../app/modules/register_module/register_page.dart';
import '../../app/modules/register_module/register_bindings.dart';
import '../../app/modules/login_module/login_page.dart';
import '../../app/modules/login_module/login_bindings.dart';
import '../../app/modules/home_module/home_bindings.dart';
import '../../app/modules/home_module/home_page.dart';
import 'package:get/get.dart';
part './app_routes.dart';
/// GetX Generator - fb.com/htngu.99
///

abstract class AppPages {
  static final pages = [
    GetPage(
      name: Routes.HOME,
      page: () => HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: Routes.LOGIN,
      page: () => LoginPage(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: Routes.REGISTER,
      page: () => RegisterPage(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: Routes.PROFILE,
      page: () => ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: Routes.AUCTION_DETAIL,
      page: () => AuctionDetailPage(),
      binding: AuctionDetailBinding(),
    ),
    GetPage(
      name: Routes.ADD_AUCTION,
      page: () => AddAuctionPage(),
      binding: AddAuctionBinding(),
    ),
    GetPage(
      name: Routes.MY_AUCTION,
      page: () => MyAuctionPage(),
      binding: MyAuctionBinding(),
    ),
    GetPage(
      name: Routes.SPLASH,
      page: () => SplashPage(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: Routes.EDIT_PROFILE,
      page: () => EditProfilePage(),
      binding: EditProfileBinding(),
    ),
    GetPage(
      name: Routes.BOOKMARKED_AUCTIONS,
      page: () => BookmarkedAuctionsPage(),
      binding: BookmarkedAuctionsBinding(),
    ),
    GetPage(
      name: Routes.AUCTION_LIST,
      page: () => AuctionListPage(),
      binding: AuctionListBinding(),
    ),
  ];
}
