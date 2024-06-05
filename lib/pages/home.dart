// ignore_for_file: use_build_context_synchronously

import 'package:expenses_tracker/components/expense_list.dart';
import 'package:expenses_tracker/components/newexpense.dart';
import 'package:expenses_tracker/components/util_component.dart';
import 'package:expenses_tracker/controller/expense.dart';
import 'package:expenses_tracker/model/expense.dart';
import 'package:expenses_tracker/themes/textstyles.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<Expense>? allExpenses;

  //---------- FUNCTION FOR ALL APPS
  void getAllExpenses() async {
    final data = await ExpenseController().getAllExpenses();
    setState(() {
      allExpenses = data;
    });
  }

  void onDelete(String id, BuildContext context) async {
    try {
      final response = await ExpenseController().deleteExpenseById(id, context);
      if (response != 0) {
        getAllExpenses();
      }
    } catch (e) {
      UtilComponent.showSnackBar(
          context: context, text: 'Please Try Again', color: Colors.red);
    }
  }

  void onAdd(Map<String, dynamic> data, BuildContext context) async {
    try {
      await ExpenseController().addExpense(data, context);
      getAllExpenses();
    } catch (e) {
      UtilComponent.showSnackBar(
          context: context, text: 'Unkown Error : $e', color: Colors.red);
    }
  }

  void onUpdate(
      String id, Map<String, dynamic> data, BuildContext context) async {
    try {
      await ExpenseController().updateExpenseById(id, data, context);
      getAllExpenses();
    } catch (e) {
      UtilComponent.showSnackBar(
          context: context, text: 'Unkown Error : $e', color: Colors.red);
    }
  }

  // ------------- END  ALL FUNCTION FOR APP

  @override
  void initState() {
    super.initState();
    getAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Expense Tracker',
          style: TextStyles.sm,
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context, builder: (context) => NewExpense(onAdd: onAdd));
        },
        backgroundColor: Colors.deepPurple,
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(children: [
          Text(
            'Chart Here',
            style: TextStyles.m,
          ),
          // ignore: prefer_const_constructors
          ExpenseList(
            allExpenses: allExpenses,
            onDelete: onDelete,
            onUpdate: onUpdate,
          )
        ]),
      ),
    );
  }
}
