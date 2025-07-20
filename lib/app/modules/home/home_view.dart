import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seers_assignment2/app/modules/home/home_controller.dart';
import 'package:seers_assignment2/app/routes/app_pages.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => Get.toNamed(Routes.TRANSACTIONS),
          child: const Text('Go to Transactions'),
        ),
      ),
    );
  }
}
