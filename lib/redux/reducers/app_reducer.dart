import 'package:seers_assignment2/redux/actions/transaction_actions.dart';
import 'package:seers_assignment2/redux/models/app_state.dart';

AppState appReducer(AppState state, dynamic action) {
  if (action is FetchTransactionsRequestAction) {
    return state.copyWith(isLoading: true, error: null);
  } else if (action is FetchTransactionsSuccessAction) {
    return state.copyWith(isLoading: false, transactions: action.transactions);
  } else if (action is FetchTransactionsFailureAction) {
    return state.copyWith(isLoading: false, error: action.error);
  } else if (action is AddTransactionAction) {
    // The list is refreshed by fetchTransactionsAction, but you could also manually add it:
    // final newTransactions = List<Transaction>.from(state.transactions)..add(action.transaction);
    // return state.copyWith(transactions: newTransactions);
    return state; // State is updated by the subsequent fetch action
  }
  return state;
}
