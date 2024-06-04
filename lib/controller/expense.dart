// ignore_for_file: use_build_context_synchronously

import 'package:expenses_tracker/components/util_component.dart';
import 'package:expenses_tracker/constants/constants.dart' as constant;
import 'package:expenses_tracker/controller/category.dart';
import 'package:expenses_tracker/controller/localdata_source.dart';
import 'package:expenses_tracker/model/expense.dart';
import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

class ExpenseController {
  final LocalDataSource _localDataSource = LocalDataSource(
      dbName: constant.db,
      tableName: constant.expenseDataTable,
      queryOnCreate:
          '''CREATE TABLE ${constant.expenseDataTable}(id TEXT PRIMARY KEY,
        title TEXT,
        amount TEXT,
        category TEXT,
        createdAt INTEGER,
        editedAt INTEGER
      )''');

  Future<int> addExpense(
      Map<String, dynamic> data, BuildContext context) async {
    Map<String, dynamic> addEntry = {
      'id': const Uuid().v4(),
      'editedAt': DateTime.now().millisecondsSinceEpoch
    };
    data.addEntries(addEntry.entries);
    final response = await _localDataSource.addData(data);
    UtilComponent.showSnackBar(context, 'Data has been added', Colors.green);
    return response;
  }

  Future<int> deleteExpenseById(String id, BuildContext context) async {
    final response = await _localDataSource.deleteDataById(id);
    UtilComponent.showSnackBar(context, 'Data has been deleted', Colors.green);
    return response;
  }

  Future<int> updateExpenseById(
      String id, Map<String, dynamic> data, BuildContext context) async {
    data['editedAt'] = DateTime.now().millisecondsSinceEpoch;
    final response = await _localDataSource.updateDataById(id, data);
    UtilComponent.showSnackBar(context, 'Data has been updated', Colors.green);
    return response;
  }

  Future<List<Expense>> getAllExpenses() async {
    final mapDatas = await _localDataSource.getAllData();
    return List.generate(mapDatas.length, (i) {
      return Expense.fromMap(mapDatas[i]);
    });
  }

  Future<Expense> getExpenseById(String id) async {
    final data = await _localDataSource.getDataById(id);
    return Expense.fromMap(data[0]);
  }

  static final List<Expense> dummyData = [
    Expense(
        id: '001',
        title: 'Bakso',
        amount: '30000',
        category: Category.food,
        createdAt: DateTime.now(),
        editedAt: DateTime.now()),
    Expense(
        id: '002',
        title: 'Popok',
        amount: '125000',
        category: Category.baby,
        createdAt: DateTime.now(),
        editedAt: DateTime.now()),
    Expense(
        id: '003',
        title: 'Jalan Jalan ke MAll',
        amount: '700000',
        category: Category.leisure,
        createdAt: DateTime.now(),
        editedAt: DateTime.now()),
    Expense(
        id: '004',
        title: 'Bensin 1 bulan',
        amount: '30000',
        category: Category.work,
        createdAt: DateTime.now(),
        editedAt: DateTime.now()),
  ];
}
