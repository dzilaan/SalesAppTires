import 'dart:async';

import 'package:gjkl_trading/Database/models/salesDBModel.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class SalesDB {
  static final SalesDB instance = new SalesDB._init();
  static Database? _database;
  SalesDB._init();

  Future<Database> get database async {
    if (_database != null) return _database!;

    _database = await _initDB('TireSalesDBFinal.db');
    return _database!;
  }

  Future<Database> _initDB(String filepath) async {
    final dbpath = await getDatabasesPath();
    final path = join(dbpath, filepath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  FutureOr<void> _createDB(Database db, int version) async {
    final idType = 'INTEGER PRIMARY KEY AUTOINCREMENT';
    final textType = 'TEXT NOT NULL';

    await db.execute('''
      CREATE TABLE $tableName (
        ${SalesDBFields.id} $idType,
        ${SalesDBFields.customerName} $textType,
        ${SalesDBFields.description} $textType,
        ${SalesDBFields.total} $textType,
        ${SalesDBFields.dateTime} $textType,
        ${SalesDBFields.dateTimeTDT} $textType
      )
    ''');
  }

  Future<SalesDBModel> readSalesDB(int id) async {
    final db = await instance.database;

    final maps = await db.query(
      tableName,
      columns: SalesDBFields.values,
      where: '${SalesDBFields.id} = ?',
      whereArgs: [id],
    );
    if (maps.isNotEmpty) {
      return SalesDBModel.fromJson(maps.first);
    } else {
      throw Exception('ID $id not found');
    }
  }

  Future<List<SalesDBModel>> reaAlldSalesDB() async {
    final db = await instance.database;
    final orderBy = '${SalesDBFields.dateTime} DESC';
    final result = await db.query(tableName, orderBy: orderBy);
    //or Query traditional way
    // final result = await db.query('SELECT * FROM $tableName ORDER BY $orderBy');

    return result.map((json) => SalesDBModel.fromJson(json)).toList();
  }

  Future<List<SalesDBModel>> readSalesDBByDate(String from, String to) async {
    final db = await instance.database;
    final orderBy = '${SalesDBFields.dateTime} DESC';
    final result = await db.query(
      tableName,
      orderBy: orderBy,
      where:
          "date(${SalesDBFields.dateTime}) BETWEEN date('$from') AND date('$to')",
    );
    //or Query traditional way
    // final result = await db.query('SELECT * FROM $tableName ORDER BY $orderBy');

    return result.map((json) => SalesDBModel.fromJson(json)).toList();
  }

  Future<int> update(SalesDBModel salesDBModel) async {
    final db = await instance.database;

    return await db.update(tableName, salesDBModel.toJson(),
        where: '${SalesDBFields.id} = ?', whereArgs: [salesDBModel.id]);
  }

  Future<int> delete(int id) async {
    final db = await instance.database;
    return await db.rawDelete("DELETE FROM $tableName WHERE id = ?", [id]);
  }

  Future<SalesDBModel> create(SalesDBModel salesDB) async {
    final db = await instance.database;
    final id = await db.insert(tableName, salesDB.toJson());
    // final id = await db.query(
    //     'INSERT INTO $tableName (${SalesDBFields.customerName},${SalesDBFields.description},${SalesDBFields.total},${SalesDBFields.dateTime},${SalesDBFields.dateTimeTDT})'
    //             'VALUES(${salesDB.customerName},${salesDB.description},${salesDB.total},${salesDB.dateTime},' +
    //         DateTime.now().toIso8601String() +
    //         ')');
    return salesDB.copy(id: id);
  }

  Future closeDB() async {
    final db = await instance.database;
    db.close();
  }
}
