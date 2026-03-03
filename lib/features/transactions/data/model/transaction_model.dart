import 'package:finance/core/database/hive_type_id.dart';
import 'package:finance/features/transactions/domain/entities/transaction.dart';
import 'package:hive_ce_flutter/hive_ce_flutter.dart';

part 'transaction_model.g.dart';

@HiveType(typeId: HiveTypeId.transaction)
class TransactionModel {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final double amount;
  @HiveField(3)
  final int type;
  @HiveField(4)
  final String categoryId;
  @HiveField(5)
  final String description;
  @HiveField(6)
  final DateTime date;

  TransactionModel({
    required this.id,
    required this.title,
    required this.amount,
    required this.type,
    required this.categoryId,
    required this.description,
    required this.date,
  });

  factory TransactionModel.fromEntity(Transaction entity) {
    return TransactionModel(
      id: entity.id,
      title: entity.title,
      amount: entity.amount,
      type: entity.type == TransactionType.expense ? 0 : 1,
      categoryId: entity.categoryId,
      description: entity.description,
      date: entity.date,
    );
  }

  Transaction toEntity() {
    return Transaction(
      id: id,
      amount: amount,
      title: title,
      type: type == 0 ? TransactionType.expense : TransactionType.income,
      categoryId: categoryId,
      description: description,
      date: date,
    );
  }
}
