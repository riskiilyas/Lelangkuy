import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/data/model/auction_participation.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';

class MyAuctionController extends GetxController {
  var createdAuctions = <Auction>[].obs;
  var participatedAuctions = <Auction>[].obs;
  var listParticipated = <AuctionParticipation>[].obs;

  var isLoading = true.obs;
  final db = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    fetchAuctions();
  }

  void fetchAuctions() async {
    isLoading(true);
    try {
      final userId = await PrefManager.getUid();
      if (userId != null) {
        var created = await db.getAuctionsByUserId(userId);
        var participated = await db.getParticipatedAuctions(userId);
        var listsParticipated = await db.getParticipationsByUserId(userId);

        listParticipated.assignAll(listsParticipated);
        createdAuctions.assignAll(created);
        participatedAuctions.assignAll(participated);
      }
    } finally {
      isLoading(false);
    }
  }

  void deleteAuction(int auctionId) async {
    final participated =
        listParticipated.firstWhere((p) => p.auctionId == auctionId);
    await db.deleteAuctionParticipation(participated.id);
    fetchAuctions();
  }

  String getUserBidAmount(int auctionId) {
    // Fetch the user's bid amount for the given auction
    // This is a placeholder implementation, adjust according to your data structure
    var participation =
        listParticipated.firstWhere((_) => _.auctionId == auctionId);
    return participation.bidAmount;
  }
}
