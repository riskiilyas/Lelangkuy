import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';

class BookmarkedAuctionsController extends GetxController {
  final isLoading = true.obs;
  final bookmarkedAuctions = <Auction>[].obs;

  @override
  void onInit() {
    super.onInit();
    fetchBookmarkedAuctions();
  }

  Future<void> fetchBookmarkedAuctions() async {
    try {
      isLoading(true);
      final db = await DatabaseHelper();
      final userId = await PrefManager.getUid();
      final auctions = await db.getBookmarkAuctionsByUserId(userId ?? 0);
      bookmarkedAuctions.assignAll(auctions);
      isLoading(false);
    } catch (error) {
      print('Error fetching bookmarked auctions: $error');
    } finally {
      isLoading(false);
    }
  }
}
