import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/modules/bookmarked_auctions_module/bookmarked_auctions_controller.dart';

class BookmarkedAuctionsPage extends GetView<BookmarkedAuctionsController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Bookmarked Auctions')),
      body: Obx(() {
        if (controller.isLoading.value) {
          return Center(child: CircularProgressIndicator());
        }

        if (controller.bookmarkedAuctions.isEmpty) {
          return Center(child: Text('No bookmarked auctions available'));
        }

        return ListView.builder(
          itemCount: controller.bookmarkedAuctions.length,
          itemBuilder: (context, index) {
            Auction auction = controller.bookmarkedAuctions[index];
            return ListTile(
              title: Text(auction.title),
              subtitle: Text('Starting Price: \$${auction.startingPrice}'),
              onTap: () {
                // Handle tapping on the bookmarked auction if needed
              },
            );
          },
        );
      }),
    );
  }
}
