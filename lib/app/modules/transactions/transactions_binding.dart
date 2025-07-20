import 'package:get/get.dart';
import 'package:seers_assignment2/app/modules/transactions/transactions_controller.dart';

class TransactionsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<TransactionsController>(() => TransactionsController());
  }
}
