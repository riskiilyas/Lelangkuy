import 'package:get/get.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';
/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class SplashController extends GetxController{

  final hasUID = Rx<bool?>(null);

  @override
  void onReady() async {
    super.onReady();

    var uid = await PrefManager.getUid();
    if(uid == null) {
      hasUID.value = false;
    } else {
      hasUID.value = true;
    }
  }
}
