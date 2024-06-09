import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/modules/auction_detail_module/auction_detail_controller.dart';

class AuctionDetailPage extends GetView<AuctionDetailController> {
  final Auction auction = Get.arguments;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: MediaQuery.of(context).size.height * 0.45),
            child: Container(
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.vertical(
                  top: Radius.circular(32),
                ),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    auction.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Starting Price: \$${auction.startingPrice}',
                    style: const TextStyle(fontSize: 18),
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'Description:',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    auction.description,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 24),
                  Obx(
                        () => ElevatedButton(
                      onPressed: controller.isPlacingBid.value
                          ? null
                          : () {
                        controller.placeBid(auction);
                      },
                      child: controller.isPlacingBid.value
                          ? const CircularProgressIndicator()
                          : const Text('Place Bid'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}