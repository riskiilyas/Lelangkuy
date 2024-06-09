import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lelangkuy/app/modules/add_auction_module/add_auction_controller.dart';
import 'package:date_time_picker/date_time_picker.dart'; // Import DateTimePicker

class AddAuctionPage extends GetView<AddAuctionController> {
  final _formKey = GlobalKey<FormState>();

  AddAuctionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Add Auction',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.blueGrey,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: controller.titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a title';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.descriptionController,
                maxLines: 3,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a description';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16.0),
              TextFormField(
                controller: controller.startingPriceController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  labelText: 'Starting Price',
                ),
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Please enter a starting price';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 24.0),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    controller.addAuction();
                  }
                },
                child: const Text('Add Auction'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
