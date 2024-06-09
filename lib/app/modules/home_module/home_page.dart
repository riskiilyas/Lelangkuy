import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/data/model/auction.dart';
import 'package:lelangkuy/app/modules/auction_list_module/auction_list_page.dart';
import 'package:lelangkuy/app/modules/home_module/home_controller.dart';
import 'package:lelangkuy/app/modules/my_auction_module/my_auction_page.dart';
import 'package:lelangkuy/app/modules/profile_module/profile_controller.dart';
import 'package:lelangkuy/app/modules/profile_module/profile_page.dart';

/**
 * GetX Template Generator - fb.com/htngu.99
 * */

class HomePage extends GetView<HomeController> {
  final List<Widget> _pages = [
    AuctionListPage(),
    MyAuctionPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'LelangKuy',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Obx(() => IndexedStack(
            index: controller.currentIndex.value,
            children: _pages,
          )),
      bottomNavigationBar: Obx(() => BottomNavigationBar(
            currentIndex: controller.currentIndex.value,
            onTap: controller.changeTabIndex,
            items: const [
              BottomNavigationBarItem(
                icon: Icon(Icons.gavel),
                label: 'Auctions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.list),
                label: 'Participated Auctions',
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.person),
                label: 'Profile',
              ),
            ],
          )),
    );
  }
}