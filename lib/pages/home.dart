// ignore_for_file: use_build_context_synchronously

import 'package:expenses_tracker/components/chart/chart_master.dart';
import 'package:expenses_tracker/components/expense/expense_list.dart';
import 'package:expenses_tracker/components/expense/new_expense.dart';
import 'package:expenses_tracker/components/util_component.dart';
import 'package:expenses_tracker/controller/expense_db.dart';
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
  bool isChartDisplay = false;

  //---------- FUNCTION FOR ALL APPS
  void showAlertDelete(String id, BuildContext context) {
    UtilComponent.showAlert(
        context: context,
        content: Text(
          'Are you sure deletting this data ?',
          style: TextStyles.s,
        ),
        action: [
          TextButton(
            onPressed: () {
              onDelete(id, context);
              Navigator.pop(context);
            },
            child: Text(
              'Delete',
              style: TextStyles.s.copyWith(color: Colors.white),
            ),
          ),
          ElevatedButton(
            style: const ButtonStyle(
                elevation: WidgetStatePropertyAll(5),
                backgroundColor: WidgetStatePropertyAll(Colors.white)),
            onPressed: () {
              Navigator.pop(context);
              getAllExpenses();
            },
            child: Text(
              'Cancel',
              style: TextStyles.s.copyWith(color: Colors.deepPurple),
            ),
          )
        ]);
  }

  void getAllExpenses() async {
    final data = await ExpenseController().getAllExpenses();
    setState(() {
      allExpenses = data;
    });
  }

  void onDelete(String id, BuildContext context) async {
    try {
      await ExpenseController().deleteExpenseById(id, context);
      getAllExpenses();
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

  double summing() {
    if (allExpenses == null || allExpenses!.isEmpty) return 0;
    List<double> allAmountData = List.generate(allExpenses!.length, (index) {
      return allExpenses![index].amount;
    });
    return allAmountData.reduce((value, element) => value + element);
  }

  // ------------- END  ALL FUNCTION FOR APP

  @override
  void initState() {
    super.initState();
    getAllExpenses();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget> fitur = [
      ExpenseList(
        allExpenses: allExpenses,
        onDelete: showAlertDelete,
        onUpdate: onUpdate,
      )
    ];

    if (isChartDisplay) {
      fitur.insert(
          0,
          Expanded(
            child: Chart(
              expenses: allExpenses!,
            ),
          ));
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        title: Text(
          'Expense Tracker',
          style: TextStyles.sm,
        ),
        actions: [
          IconButton.filled(
            onPressed: () {
              setState(() {
                isChartDisplay = !isChartDisplay;
              });
            },
            icon: Icon(
              Icons.bar_chart,
              color: isChartDisplay ? Colors.purple : Colors.grey,
            ),
            style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(Colors.white)),
          )
        ],
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
        child: Stack(
          children: [
            Column(children: fitur),

            //------- TOTAL EXPENSES

            Align(
              alignment: Alignment.bottomLeft,
              child: Container(
                width: double.infinity,
                height: 50,
                decoration: BoxDecoration(
                    color: Colors.deepPurple[400],
                    borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20))),
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Total : Rp ${summing().toStringAsFixed(0)} ,-',
                      style: TextStyles.smBold,
                    ),
                  ),
                ),
              ),
            )

            //------------- END TOTAL EXPENSES
          ],
        ),
      ),
    );
  }
}
