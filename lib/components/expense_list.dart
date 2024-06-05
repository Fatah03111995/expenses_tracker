// ignore_for_file: use_build_context_synchronously

import 'package:expenses_tracker/components/expense_item.dart';
import 'package:expenses_tracker/model/expense.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatelessWidget {
  final List<Expense>? allExpenses;
  final Function onUpdate;
  final Function onDelete;
  const ExpenseList(
      {super.key,
      this.allExpenses,
      required this.onDelete,
      required this.onUpdate});

  @override
  Widget build(BuildContext context) {
    return allExpenses == null
        ? const Center(
            child: CircularProgressIndicator(
              color: Colors.purple,
            ),
          )
        : allExpenses!.isEmpty
            ? Expanded(
                child: Center(
                  child: Text(
                    'No Data Here',
                    style: TextStyles.mBold.copyWith(color: Colors.white),
                  ),
                ),
              )
            : Expanded(
                child: ListView.builder(
                    itemCount: allExpenses!.length,
                    itemBuilder: (context, index) {
                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (direction) {
                          onDelete(allExpenses![index].id, context);
                        },
                        child: ExpenseItem(
                          expenseDataItem: allExpenses![index],
                          onUpdate: onUpdate,
                        ),
                      );
                    }),
              );
  }
}
