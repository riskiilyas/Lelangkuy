import 'package:lelangkuy/app/modules/auction_list_module/auction_list_controller.dart';
import 'package:get/get.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class AuctionListBinding implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => AuctionListController());
  }
}