import 'package:seers_assignment2/redux/models/filter_options_model.dart';
import 'package:seers_assignment2/redux/models/transaction_model.dart';

class AppState {
  final List<Transaction> transactions;
  final FilterOptions filterOptions;
  final bool isLoading;
  final String? error;

  AppState({
    this.transactions = const [],
    this.isLoading = false,
    this.error,
    FilterOptions? filterOptions,
  }) : filterOptions = filterOptions ?? FilterOptions();

  AppState copyWith({
    List<Transaction>? transactions,
    bool? isLoading,
    String? error,
    FilterOptions? filterOptions,
  }) {
    return AppState(
      transactions: transactions ?? this.transactions,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
      filterOptions: filterOptions ?? this.filterOptions,
    );
  }

  List<Transaction> get filteredTransactions {
    List<Transaction> filtered = List.from(transactions);

    // Filter by type
    if (filterOptions.type != null) {
      filtered = filtered.where((t) => t.type == filterOptions.type).toList();
    }

    // Filter by date range
    if (filterOptions.startDate != null) {
      filtered =
          filtered
              .where((t) => t.date.isAfter(filterOptions.startDate!))
              .toList();
    }
    if (filterOptions.endDate != null) {
      filtered =
          filtered
              .where((t) => t.date.isBefore(filterOptions.endDate!))
              .toList();
    }

    // Sort
    switch (filterOptions.sortBy) {
      case SortBy.date:
        filtered.sort((a, b) => a.date.compareTo(b.date));
        break;
      case SortBy.amount:
        filtered.sort((a, b) => a.amount.compareTo(b.amount));
        break;
    }

    if (!filterOptions.ascending) {
      filtered = filtered.reversed.toList();
    }

    return filtered;
  }
}
