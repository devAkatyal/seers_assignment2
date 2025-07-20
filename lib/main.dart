import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:get/get.dart';
import 'package:seers_assignment2/app/routes/app_pages.dart';
import 'package:seers_assignment2/redux/store.dart';

void main() {
  final store = createStore();

  runApp(
    StoreProvider(
      store: store,
      child: GetMaterialApp(
        title: "GetX Application",
        initialRoute: AppPages.INITIAL,
        getPages: AppPages.routes,
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
      ),
    ),
  );
}
