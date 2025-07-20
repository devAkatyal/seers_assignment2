class Transaction {
  final String id;
  final double amount;
  final String title;
  final String type; // 'credit' or 'debit'
  final DateTime date;
  final String category;

  Transaction({
    required this.id,
    required this.amount,
    required this.title,
    required this.type,
    required this.date,
    required this.category,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) {
    return Transaction(
      id: json['id'],
      amount: double.parse(json['amount'].toString()),
      title: json['title'],
      type: json['type'],
      date: DateTime.parse(json['date']),
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'amount': amount,
      'title': title,
      'type': type,
      'date': date.toIso8601String(),
      'category': category,
    };
  }
}
