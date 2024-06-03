// ignore_for_file: use_build_context_synchronously

import 'package:expenses_tracker/components/expense_item.dart';
import 'package:expenses_tracker/components/util_component.dart';
import 'package:expenses_tracker/controller/expense.dart';
import 'package:expenses_tracker/model/expense.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class ExpenseList extends StatefulWidget {
  const ExpenseList({super.key});

  @override
  State<ExpenseList> createState() => _ExpenseListState();
}

class _ExpenseListState extends State<ExpenseList> {
  List<Expense>? allExpenses;
  void getAllExpenses() async {
    final data = await ExpenseController().getAllExpenses();
    setState(() {
      allExpenses = data;
    });
  }

  void onDelete(String id) async {
    final response = await ExpenseController().deleteExpenseById(id);
    if (response != 0) {
      UtilComponent.showSnackBar(
          context, 'Data has been deleted', Colors.green);
      getAllExpenses();
    } else {
      UtilComponent.showSnackBar(context, 'Please Try Again', Colors.red);
    }
  }

  @override
  void initState() {
    super.initState();
    getAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return allExpenses == null
        ? const CircularProgressIndicator(
            color: Colors.purple,
          )
        : allExpenses == []
            ? Center(
                child: Text(
                  'No Data Here',
                  style: TextStyles.mBold,
                ),
              )
            : ListView.builder(itemBuilder: (context, index) {
                return ExpenseItem(
                    expenseDataItem: allExpenses![index], onDelete: onDelete);
              });
  }
}
