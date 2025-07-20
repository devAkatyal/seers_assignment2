import 'package:get/get.dart';
import 'package:seers_assignment2/app/modules/home/home_binding.dart';
import 'package:seers_assignment2/app/modules/home/home_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
  ];
} 