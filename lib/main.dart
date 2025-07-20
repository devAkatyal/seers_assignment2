import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:seers_assignment2/app/routes/app_pages.dart';

void main() {
  runApp(
    GetMaterialApp(
      title: "GetX Application",
      initialRoute: AppPages.INITIAL,
      getPages: AppPages.routes,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
    ),
  );
}
