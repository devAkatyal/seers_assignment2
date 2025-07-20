import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:intl/intl.dart';
import 'package:redux/redux.dart';
import 'package:seers_assignment2/app/modules/transactions/transactions_controller.dart';
import 'package:seers_assignment2/redux/actions/transaction_actions.dart';
import 'package:seers_assignment2/redux/models/app_state.dart';
import 'package:get/get.dart';
import 'package:seers_assignment2/redux/models/transaction_model.dart';

class TransactionsView extends GetView<TransactionsController> {
  const TransactionsView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Transactions')),
      body: StoreConnector<AppState, _ViewModel>(
        converter: (store) => _ViewModel.fromStore(store),
        onInit: (store) => store.dispatch(fetchTransactionsAction()),
        builder: (context, vm) {
          if (vm.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (vm.error != null) {
            return Center(child: Text('Error: ${vm.error}'));
          }
          return ListView.builder(
            itemCount: vm.transactions.length,
            itemBuilder: (context, index) {
              final transaction = vm.transactions[index];
              final isCredit = transaction.type == 'credit';
              final color = isCredit ? Colors.green : Colors.red;
              final currencyFormat = NumberFormat.currency(
                locale: 'en_US',
                symbol: '\$',
              );
              final dateFormat = DateFormat.yMMMd();

              return ListTile(
                leading: Icon(
                  isCredit ? Icons.arrow_upward : Icons.arrow_downward,
                  color: color,
                ),
                title: Text(transaction.title),
                subtitle: Text(
                  '${transaction.category} - ${dateFormat.format(transaction.date)}',
                ),
                trailing: Text(
                  currencyFormat.format(transaction.amount),
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTransactionDialog(context),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _showAddTransactionDialog(BuildContext context) {
    final store = StoreProvider.of<AppState>(context);
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final amountController = TextEditingController();
    final categoryController = TextEditingController();
    String type = 'debit';

    Get.dialog(
      AlertDialog(
        title: const Text('Add Transaction'),
        content: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormField(
                  controller: titleController,
                  decoration: const InputDecoration(labelText: 'Title'),
                  validator:
                      (value) => value!.isEmpty ? 'Please enter a title' : null,
                ),
                TextFormField(
                  controller: amountController,
                  decoration: const InputDecoration(labelText: 'Amount'),
                  keyboardType: TextInputType.number,
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Please enter an amount' : null,
                ),
                TextFormField(
                  controller: categoryController,
                  decoration: const InputDecoration(labelText: 'Category'),
                  validator:
                      (value) =>
                          value!.isEmpty ? 'Please enter a category' : null,
                ),
                DropdownButtonFormField<String>(
                  value: type,
                  items:
                      ['debit', 'credit']
                          .map(
                            (label) => DropdownMenuItem(
                              child: Text(label),
                              value: label,
                            ),
                          )
                          .toList(),
                  onChanged: (value) {
                    if (value != null) {
                      type = value;
                    }
                  },
                  decoration: const InputDecoration(labelText: 'Type'),
                ),
              ],
            ),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Get.back(), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState!.validate()) {
                final newTransaction = Transaction(
                  id:
                      DateTime.now().millisecondsSinceEpoch
                          .toString(), // Mock ID
                  title: titleController.text,
                  amount: double.parse(amountController.text),
                  category: categoryController.text,
                  date: DateTime.now(),
                  type: type,
                );
                store.dispatch(addTransaction(newTransaction));
                Get.back();
              }
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

class _ViewModel {
  final List<Transaction> transactions;
  final bool isLoading;
  final String? error;
  final Function(Transaction) onAddTransaction;

  _ViewModel({
    required this.transactions,
    required this.isLoading,
    this.error,
    required this.onAddTransaction,
  });

  static _ViewModel fromStore(Store<AppState> store) {
    return _ViewModel(
      transactions: store.state.transactions,
      isLoading: store.state.isLoading,
      error: store.state.error,
      onAddTransaction: (transaction) {
        store.dispatch(addTransaction(transaction));
      },
    );
  }
}
