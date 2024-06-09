import 'package:get/get.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfileController extends GetxController {
  final isLoading = true.obs;
  final name = "user123".obs;
  final email = "user123@mail.com".obs;
  final db = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchUserData();
  }

  void fetchUserData() async {
     name.value = await PrefManager.getName() ?? "-";
     email.value = await PrefManager.getEmail() ?? "-";
     isLoading(false);
  }

  Future<void> logout() async {
    try {
      final pref = await SharedPreferences.getInstance();
      final a = await pref.clear();
      print("logout $a");
      Get.offAllNamed(Routes.LOGIN);
    } catch (e) {
      print('Error while logging out: $e');
      // Handle error, if any
    }
  }


  Future<void> deleteAccount() async {
    final id = await PrefManager.getUid();
    final pref = await SharedPreferences.getInstance();
    await pref.clear();
    db.deleteUser(id??0);
    Get.offAllNamed(Routes.LOGIN);
  }
}