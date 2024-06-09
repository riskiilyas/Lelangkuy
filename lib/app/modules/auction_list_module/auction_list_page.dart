import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/data/provider/pref.dart';
import 'package:lelangkuy/app/modules/auction_list_module/auction_list_controller.dart';
import 'package:lelangkuy/app/routes/app_pages.dart';

class AuctionListPage extends GetView<AuctionListController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed(Routes.ADD_AUCTION);
        },
      ),
      appBar: AppBar(
        title: const Text('Auctions'),
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              showSearch(
                context: context,
                delegate: AuctionSearch(controller),
              );
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        if (controller.auctions.isEmpty) {
          return const Center(child: Text('No auctions available'));
        }

        return ListView.builder(
          itemCount: controller.auctions.length,
          itemBuilder: (context, index) {
            Auction auction = controller.auctions[index];
            return FutureBuilder<int?>(
              future: PrefManager.getUid(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                int? currentUserId = snapshot.data;

                return Card(
                  margin: const EdgeInsets.symmetric(
                      vertical: 8.0, horizontal: 16.0),
                  child: ListTile(
                    leading: Image.asset('assets/bid.png'),
                    title: Text(auction.title),
                    subtitle: Text('Starting Price: ${auction.startingPrice}'),
                    trailing: currentUserId == auction.userId
                        ? IconButton(
                            icon: const Icon(Icons.delete),
                            onPressed: () {
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: const Text('Confirm Delete'),
                                    content: const Text(
                                        'Are you sure you want to delete this auction?'),
                                    actions: <Widget>[
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                        },
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.of(context)
                                              .pop(); // Close the dialog
                                          controller.deleteAuction(auction.id);
                                        },
                                        child: const Text('Delete'),
                                      ),
                                    ],
                                  );
                                },
                              );
                            },
                          )
                        : Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              IconButton(
                                icon: controller.isAuctionBookmarked(auction.id)
                                    ? const Icon(Icons.bookmark)
                                    : const Icon(Icons.bookmark_border),
                                onPressed: () {
                                  controller.toggleBookmarkAuction(auction.id);
                                },
                              ),
                              IconButton(
                                icon: const Icon(Icons.gavel),
                                onPressed: () {
                                  final TextEditingController bidController =
                                      TextEditingController();

                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text('Place Bid'),
                                        content: TextField(
                                          controller: bidController,
                                          keyboardType: TextInputType.number,
                                          decoration: const InputDecoration(
                                            labelText: 'Bid Amount',
                                          ),
                                        ),
                                        actions: <Widget>[
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                            },
                                            child: const Text('Cancel'),
                                          ),
                                          TextButton(
                                            onPressed: () {
                                              Navigator.of(context)
                                                  .pop(); // Close the dialog
                                              final bidAmount = double.tryParse(
                                                  bidController.text);
                                              if (bidAmount != null) {
                                                controller.addBid(
                                                    auction.id, bidAmount.toString());
                                              } else {
                                                // Show an error if the bid amount is invalid
                                                Get.snackbar('Error',
                                                    'Please enter a valid bid amount');
                                              }
                                            },
                                            child: const Text('Bid'),
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                              ),
                            ],
                          ),
                    onTap: () {
                      // Handle auction item tap if needed
                    },
                  ),
                );
              },
            );
          },
        );
      }),
    );
  }
}

class AuctionSearch extends SearchDelegate<String> {
  final AuctionListController controller;

  AuctionSearch(this.controller);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          controller.filterAuctions('');
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, '');
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    controller.filterAuctions(query);
    return Obx(() {
      if (controller.filteredAuctions.isEmpty) {
        return const Center(child: Text('No results found'));
      }

      return ListView.builder(
        itemCount: controller.filteredAuctions.length,
        itemBuilder: (context, index) {
          Auction auction = controller.filteredAuctions[index];
          return ListTile(
            leading: Image.asset('assets/bid.png'),
            title: Text(auction.title),
            subtitle: Text('Starting Price: ${auction.startingPrice}'),
            onTap: () {
              // Handle auction item tap if needed
            },
          );
        },
      );
    });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    controller.filterAuctions(query);
    return Obx(() {
      if (controller.filteredAuctions.isEmpty) {
        return const Center(child: Text('No suggestions'));
      }

      return ListView.builder(
        itemCount: controller.filteredAuctions.length,
        itemBuilder: (context, index) {
          Auction auction = controller.filteredAuctions[index];
          return ListTile(
            leading: Image.asset('assets/bid.png'),
            title: Text(auction.title),
            subtitle: Text('Starting Price: ${auction.startingPrice}'),
            onTap: () {
              query = auction.title;
              showResults(context);
            },
          );
        },
      );
    });
  }
}
