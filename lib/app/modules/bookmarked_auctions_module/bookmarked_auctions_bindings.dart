import 'package:lelangkuy/app/modules/bookmarked_auctions_module/bookmarked_auctions_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class BookmarkedAuctionsBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookmarkedAuctionsController());
  }
}