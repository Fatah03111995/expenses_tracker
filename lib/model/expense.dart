import 'package:uuid/uuid.dart';

enum Category { work, food, leisure, baby, others }

class Expense {
  final String id;
  String title;
  double amount;
  final DateTime createdAt;
  DateTime? editedAt;
  Category category;

  Expense({
    required this.title,
    required this.amount,
    required this.category,
  })  : id = const Uuid().v4(),
        createdAt = DateTime.now();
  // : propertyA = value, propertyB = value (to initialize parameter that is never fill)

  void editExpense({String? title, double? amount}) {
    this.title = title ?? this.title;
    this.amount = amount ?? this.amount;
    editedAt = DateTime.now();
  }
}
