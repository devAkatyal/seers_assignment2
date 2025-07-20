import 'package:get/get.dart';
import 'package:seers_assignment2/app/modules/home/home_binding.dart';
import 'package:seers_assignment2/app/modules/home/home_view.dart';
import 'package:seers_assignment2/app/modules/transactions/transactions_binding.dart';
import 'package:seers_assignment2/app/modules/transactions/transactions_view.dart';

part 'app_routes.dart';

class AppPages {
  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.TRANSACTIONS,
      page: () => const TransactionsView(),
      binding: TransactionsBinding(),
    ),
  ];
}
