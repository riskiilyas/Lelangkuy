import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/modules/my_auction_module/my_auction_controller.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';
class MyAuctionPage extends GetView<MyAuctionController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(
            () => controller.isLoading.value
            ? const Center(child: CircularProgressIndicator())
            : RefreshIndicator(
          onRefresh: () async => controller.fetchAuctions(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text(
                    'Participated Auctions',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: controller.participatedAuctions.length,
                  itemBuilder: (context, index) {
                    final auction = controller.participatedAuctions[index];
                    return ListTile(
                      leading: Hero(
                        tag: auction.id,
                        child: const CircleAvatar(
                          backgroundImage: AssetImage("assets/bid.png"),
                        ),
                      ),
                      title: Text(auction.title),
                      subtitle: Text('Your Bid: \$${controller.getUserBidAmount(auction.id)}'),
                      trailing: InkWell(
                        child: const Icon(Icons.delete),
                        onTap: () {
                          _showDeleteConfirmationDialog(context, auction.id);
                        },
                      ),
                      onTap: () {
                        Get.toNamed('/auction-detail', arguments: auction);
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showDeleteConfirmationDialog(BuildContext context, int auctionId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Confirm Delete'),
          content: const Text('Are you sure you want to delete this auction?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
              },
              child: const Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Close the dialog
                Get.find<MyAuctionController>().deleteAuction(auctionId);
              },
              child: const Text('Delete'),
            ),
          ],
        );
      },
    );
  }
}
