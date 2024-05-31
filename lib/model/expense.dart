import 'package:uuid/uuid.dart';

class Expense {
  final String id;
  String title;
  double amount;
  final DateTime createdAt;
  DateTime? editedAt;

  Expense({
    required this.title,
    required this.amount,
    required this.createdAt,
  }) : id = const Uuid().v4();
  // : propertyA = value, propertyB = value (to initialize parameter that is never fill)

  void editExpense({String? title, double? amount}) {
    this.title = title ?? this.title;
    this.amount = amount ?? this.amount;
    editedAt = DateTime.now();
  }
}
