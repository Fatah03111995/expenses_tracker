import 'package:expenses_tracker/controller/category.dart';
import 'package:expenses_tracker/model/expense.dart';

class ExpenseData {
  final List<Expense> expenses;
  final Category category;

  ExpenseData({
    required this.expenses,
    required this.category,
  });

  ExpenseData.byCategory({
    required List<Expense> allExpenses,
    required this.category,
  }) : expenses = allExpenses
            .where((expense) => expense.category == category)
            .toList();

  ExpenseData.byDate(
      {required List<Expense> allExpenses,
      required this.category,
      required DateTime startDate,
      required DateTime endDate})
      : expenses = allExpenses
            .where((expense) =>
                expense.createdAt.millisecondsSinceEpoch >=
                    startDate.millisecondsSinceEpoch &&
                expense.createdAt.millisecondsSinceEpoch <=
                    endDate.millisecondsSinceEpoch)
            .toList();

  List<Expense> get data => expenses;

  double get totalAmount {
    double sum = 0;

    for (var expense in expenses) {
      sum += expense.amount;
    }

    return sum;
  }
}
