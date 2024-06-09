import 'package:lelangkuy/app/modules/auction_detail_module/auction_detail_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AuctionDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionDetailController());
  }
}