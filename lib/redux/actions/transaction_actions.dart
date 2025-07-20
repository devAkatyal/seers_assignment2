import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:redux/redux.dart';
import 'package:redux_thunk/redux_thunk.dart';
import 'package:seers_assignment2/redux/models/app_state.dart';
import 'package:seers_assignment2/redux/models/transaction_model.dart';

// Action to signal the start of a network request
class FetchTransactionsRequestAction {}

// Action to handle successful fetching of transactions
class FetchTransactionsSuccessAction {
  final List<Transaction> transactions;

  FetchTransactionsSuccessAction(this.transactions);
}

// Action to handle errors during fetching
class FetchTransactionsFailureAction {
  final String error;

  FetchTransactionsFailureAction(this.error);
}

// Thunk action to fetch transactions from the API
ThunkAction<AppState> fetchTransactionsAction() {
  return (Store<AppState> store) async {
    store.dispatch(FetchTransactionsRequestAction());
    try {
      final response = await http.get(
        Uri.parse(
          'https://687c9a24918b6422432ec326.mockapi.io/api/transactions/api',
        ),
      );
      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        final transactions =
            data.map((json) => Transaction.fromJson(json)).toList();
        store.dispatch(FetchTransactionsSuccessAction(transactions));
      } else {
        store.dispatch(
          FetchTransactionsFailureAction('Failed to load transactions'),
        );
      }
    } catch (e) {
      store.dispatch(FetchTransactionsFailureAction(e.toString()));
    }
  };
}

// Action to add a transaction
class AddTransactionAction {
  final Transaction transaction;

  AddTransactionAction(this.transaction);
}

// Thunk action to add a transaction
ThunkAction<AppState> addTransaction(Transaction transaction) {
  return (Store<AppState> store) async {
    try {
      final response = await http.post(
        Uri.parse(
          'https://687c9a24918b6422432ec326.mockapi.io/api/transactions/api',
        ),
        headers: {'Content-Type': 'application/json'},
        body: json.encode(transaction.toJson()),
      );
      if (response.statusCode == 201) {
        final newTransaction = Transaction.fromJson(json.decode(response.body));
        store.dispatch(AddTransactionAction(newTransaction));
        // After adding, fetch the whole list again to ensure consistency
        store.dispatch(fetchTransactionsAction());
      } else {
        store.dispatch(
          FetchTransactionsFailureAction('Failed to add transaction'),
        );
      }
    } catch (e) {
      store.dispatch(FetchTransactionsFailureAction(e.toString()));
    }
  };
}
