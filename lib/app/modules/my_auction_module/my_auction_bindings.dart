import 'package:lelangkuy/app/modules/my_auction_module/my_auction_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class MyAuctionBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyAuctionController());
  }
}