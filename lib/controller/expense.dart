import 'package:expenses_tracker/constants/constants.dart' as constant;
import 'package:expenses_tracker/controller/category.dart';
import 'package:expenses_tracker/controller/localdata_source.dart';
import 'package:expenses_tracker/model/expense.dart';
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

  Future<int> addExpense(Map<String, dynamic> data) async {
    Map<String, dynamic> addEntry = {
      'id': const Uuid().v4(),
      'editedAt': DateTime.now().millisecondsSinceEpoch
    };
    data.addEntries(addEntry.entries);
    return await _localDataSource.addData(data);
  }

  Future<int> deleteExpenseById(String id) async {
    return await _localDataSource.deleteDataById(id);
  }

  Future<int> updateExpenseById(String id, Map<String, dynamic> data) async {
    data['editedAt'] = DateTime.now().millisecondsSinceEpoch;
    return await _localDataSource.updateDataById(id, data);
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
