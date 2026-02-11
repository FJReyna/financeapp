enum TransactionType { income, expense }

class Transaction {
  final String id;
  final String title;
  final double amount;
  final TransactionType type;
  final String categoryId;
  final String description;
  final DateTime date;

  Transaction({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.description,
    required this.date,
  });

  Transaction copyWith({
    String? id,
    String? title,
    double? amount,
    TransactionType? type,
    String? categoryId,
    String? description,
    DateTime? date,
  }) {
    return Transaction(
      id: id ?? this.id,
      title: title ?? this.title,
      amount: amount ?? this.amount,
      type: type ?? this.type,
      categoryId: categoryId ?? this.categoryId,
      description: description ?? this.description,
      date: date ?? this.date,
    );
  }
}
