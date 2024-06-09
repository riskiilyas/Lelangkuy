import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';

class AddAuctionController extends GetxController {
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final startingPriceController = TextEditingController();

  final db = DatabaseHelper();

  final RxBool isLoading = false.obs;

  void addAuction() async {
    try {
      isLoading.value = true;

      // Retrieve user ID from SharedPreferences
      final userId = await PrefManager.getUid();

      final auction = Auction(
        id: 0,
        title: titleController.text,
        description: descriptionController.text,
        startingPrice: double.parse(startingPriceController.text),
        userId: userId??0,
      );

      // Call the repository method to add the auction
      await db.insertAuction(auction);

      // Reset the text controllers
      titleController.clear();
      descriptionController.clear();
      startingPriceController.clear();

      isLoading.value = false;

      Get.snackbar(
        'Success',
        'Auction Created successfully',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      
      Get.offAllNamed(Routes.HOME);
    } catch (e) {
      print('Error adding auction: $e');
      isLoading.value = false;
      Get.snackbar('Error', 'Failed to add auction');
    }
  }

  @override
  void onClose() {
    // Clean up text controllers
    titleController.dispose();
    descriptionController.dispose();
    startingPriceController.dispose();
    super.onClose();
  }
}
