import 'package:lelangkuy/app/modules/add_auction_module/add_auction_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AddAuctionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AddAuctionController());
  }
}