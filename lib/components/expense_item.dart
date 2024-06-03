import 'package:expenses_tracker/controller/category.dart';
import 'package:expenses_tracker/model/expense.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expenseDataItem;
  final void Function(String id) onDelete;
  const ExpenseItem({
    super.key,
    required this.expenseDataItem,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Card(
        color: categoryColor[expenseDataItem.category],
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Icon(
                  categoryIcon[expenseDataItem.category],
                  size: 15,
                ),
                const SizedBox(width: 12),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      expenseDataItem.title,
                      style: TextStyles.sBold,
                    ),
                    const SizedBox(height: 5),
                    Text(expenseDataItem.amount.toStringAsFixed(1))
                  ],
                )
              ],
            ),
            IconButton(
                onPressed: () {
                  onDelete(expenseDataItem.id!);
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.white,
                  size: 15,
                ))
          ],
        ),
      ),
    );
  }
}
