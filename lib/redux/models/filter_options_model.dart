enum SortBy { date, amount }

class FilterOptions {
  final SortBy sortBy;
  final bool ascending;
  final String? type; // 'credit' or 'debit'
  final DateTime? startDate;
  final DateTime? endDate;

  FilterOptions({
    this.sortBy = SortBy.date,
    this.ascending = false, // Default to newest first
    this.type,
    this.startDate,
    this.endDate,
  });

  FilterOptions copyWith({
    SortBy? sortBy,
    bool? ascending,
    String? type,
    DateTime? startDate,
    DateTime? endDate,
    bool clearType = false,
    bool clearDateRange = false,
  }) {
    return FilterOptions(
      sortBy: sortBy ?? this.sortBy,
      ascending: ascending ?? this.ascending,
      type: clearType ? null : type ?? this.type,
      startDate: clearDateRange ? null : startDate ?? this.startDate,
      endDate: clearDateRange ? null : endDate ?? this.endDate,
    );
  }
}
