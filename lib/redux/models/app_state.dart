import 'package:seers_assignment2/redux/models/transaction_model.dart';

class AppState {
  final List<Transaction> transactions;
  final bool isLoading;
  final String? error;

  AppState({this.transactions = const [], this.isLoading = false, this.error});

  AppState copyWith({
    List<Transaction>? transactions,
    bool? isLoading,
    String? error,
  }) {
    return AppState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}
