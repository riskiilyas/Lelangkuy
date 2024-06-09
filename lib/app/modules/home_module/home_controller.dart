import 'package:get/get.dart';
import 'package:lelangkuy/app/modules/auction_list_module/auction_list_controller.dart';
import 'package:lelangkuy/app/modules/my_auction_module/my_auction_controller.dart';
import 'package:lelangkuy/app/modules/profile_module/profile_controller.dart';

class HomeController extends GetxController {
  var currentIndex = 0.obs;


  @override
  void onInit() {
    super.onInit();
    Get.lazyPut(() => ProfileController());
    Get.lazyPut(() => AuctionListController());
    Get.lazyPut(() => MyAuctionController());
  }

  void changeTabIndex(int index) {
    currentIndex.value = index;
  }
}
