import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/data/model/auction_participation.dart';
import 'package:lelangkuy/app/data/provider/db.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';

class AuctionListController extends GetxController {
  final db = DatabaseHelper();

  RxList<Auction> auctions = <Auction>[].obs;
  RxList<Auction> bookmarkedAauctions = <Auction>[].obs;

  var filteredAuctions = <Auction>[].obs;
  RxBool isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    fetchAuctions();
  }

  void fetchAuctions() async {
    try {
      isLoading.value = true;
      List<Auction> fetchedAuctions = await db.getAllAuctions();
      List<Auction> bookmarks =
          await db.getBookmarkAuctionsByUserId(await PrefManager.getUid() ?? 0);
      bookmarkedAauctions.assignAll(bookmarks);
      auctions.assignAll(fetchedAuctions);
    } catch (e) {
      print('Error fetching auctions: $e');
    } finally {
      isLoading.value = false;
    }
  }

  void filterAuctions(String query) {
    if (query.isEmpty) {
      filteredAuctions.assignAll(auctions);
    } else {
      filteredAuctions.assignAll(
        auctions
            .where((auction) =>
                auction.title.toLowerCase().contains(query.toLowerCase()))
            .toList(),
      );
    }
  }

  void bookmarkAuction(int auctionId) {}

  Future<void> addBid(int auctionId, String amount) async {
    await db.insertAuctionParticipation(AuctionParticipation(
        id: 0,
        userId: await PrefManager.getUid() ?? 0,
        auctionId: auctionId,
        bidAmount: amount));

    Get.snackbar(
      'Success',
      'Bid Added successfully',
      backgroundColor: Colors.green,
      colorText: Colors.white,
    );
    Get.offAllNamed(Routes.HOME);
  }

  Future<void> deleteAuction(int id) async {
    await db.deleteAuction(id);
    fetchAuctions();
  }

  bool isAuctionBookmarked(int auctionId) {
    final mAuction = auctions.firstWhere((auction) => auction.id == auctionId);
    return bookmarkedAauctions
        .any((auction) => auction.title == mAuction.title);
  }

  void toggleBookmarkAuction(int auctionId) async {
    try {
      if (isAuctionBookmarked(auctionId)) {
        final mAuction =
            auctions.firstWhere((auction) => auction.id == auctionId);
        final id = bookmarkedAauctions
            .firstWhere((auction) => auction.title == mAuction.title)
            .id;
        await db.deleteBookmarkAuction(id);
      } else {
        final auction =
            auctions.firstWhere((auction) => auction.id == auctionId);
        if (bookmarkedAauctions.contains(auction)) return;
        await db.insertBookmarkAuction(
            auctions.firstWhere((auction) => auction.id == auctionId),
            await PrefManager.getUid() ?? 0);
      }
      fetchAuctions();
    } catch (error) {
      print('Error occurred: $error');
    }
  }
}
