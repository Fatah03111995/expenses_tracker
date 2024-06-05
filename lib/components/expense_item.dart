import 'package:expenses_tracker/utility/time.dart';
import 'package:expenses_tracker/controller/category.dart';
import 'package:expenses_tracker/model/expense.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class ExpenseItem extends StatelessWidget {
  final Expense expenseDataItem;
  const ExpenseItem({
    super.key,
    required this.expenseDataItem,
  });

  @override
  Widget build(BuildContext context) {
    String formattedDate = Time.dateFormatYmd(expenseDataItem.createdAt);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 1.0),
      child: Card(
        color: categoryColor[expenseDataItem.category],
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    formattedDate,
                    style: TextStyles.s,
                  ),
                  const SizedBox(width: 12),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        expenseDataItem.title,
                        style: TextStyles.sBold,
                      ),
                      const SizedBox(height: 5),
                      Row(children: [
                        Icon(
                          categoryIcon[expenseDataItem.category],
                          size: 15,
                        ),
                        const SizedBox(width: 5),
                        Text(
                          expenseDataItem.category.name,
                          style: TextStyles.s,
                        ),
                      ]),
                    ],
                  )
                ],
              ),
              Text('Rp ${expenseDataItem.amount.toStringAsFixed(0)}')
            ],
          ),
        ),
      ),
    );
  }
}
