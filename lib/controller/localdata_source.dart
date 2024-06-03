import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class LocalDataSource {
  final String dbName;
  final String tableName;
  final String queryOnCreate;

  LocalDataSource(
      {required this.dbName,
      required this.tableName,
      required this.queryOnCreate});

  Future<Database> _openDatabase() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dbName);

    return await openDatabase(path,
        version: 1, onCreate: (db, version) => db.execute(queryOnCreate));
  }

  Future<int> addData(Map<String, dynamic> mapData) async {
    final db = await _openDatabase();
    return await db.insert(tableName, mapData);
  }

  Future<List<Map<String, dynamic>>> getAllData() async {
    final db = await _openDatabase();
    return await db.query(tableName, orderBy: 'createdAt DESC');
  }

  Future<List<Map<String, dynamic>>> getDataById(String id) async {
    final db = await _openDatabase();
    return await db.query(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteDataById(String id) async {
    final db = await _openDatabase();
    return db.delete(tableName, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateDataById(String id, Map<String, dynamic> mapData) async {
    final db = await _openDatabase();
    return db.update(tableName, mapData, where: 'id = ?', whereArgs: [id]);
  }
}
