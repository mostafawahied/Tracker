import 'package:hive/hive.dart';

part 'expense.g.dart';

@HiveType(typeId: 0)
class Expense extends HiveObject {
  @HiveField(0)
  final String category;

  @HiveField(1)
  final num amount;

  @HiveField(2)
  final num usdAmount;

  @HiveField(3)
  final DateTime date;

  @HiveField(4)
  final String? receiptPath;

  @HiveField(5)
  final String? currency;

  Expense({
    required this.category,
    required this.amount,
    required this.usdAmount,
    required this.date,
    this.receiptPath,
    this.currency,
  });
}
