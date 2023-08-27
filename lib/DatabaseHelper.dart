import 'dart:io';

import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

//Class Model
class ScannedData {
  int? id;
  String? content;
  DateTime? date;

  ScannedData({this.id, this.content, this.date});
  // constructor with id
  ScannedData.withId({this.id, this.content, this.date});

  Map<String, dynamic> toMap() {
    final map = Map<String, dynamic>();

    if (id != null) {
      map['id'] = id;
    }

    map["content"] = content;
    map["date"] = date!.toIso8601String();
    return map;
  }

  factory ScannedData.fromMap(Map<String, dynamic> map) {
    return ScannedData.withId(
      id: map['title'],
      content: map['content'],
      date: DateTime.parse(map["date"]),
    );
  }
}

//database helper
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._instance();

  //instance of a fdb
  static Database? _db = null;

  DatabaseHelper._instance();

  String scannerTable = 'scanned_table';
  String colId = 'id';
  String colContent = 'content';
  String colDate = 'date';

  //if db is null then create it
  Future<Database?> get db async {
    if (_db == null) {
      _db = await initDB();
    }
    return _db;
  }

  //initialize the database
  Future<Database> initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'scanned_data.db';
    final scannedDataDB = await openDatabase(
      path,
      version: 1,
      onCreate: _createDb,
    );
    return scannedDataDB;
  }

  //'Create a database'
  void _createDb(Database db, int version) async {
    await db.execute('CREATE TABLE $scannerTable('
        '$colId INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, '
        '$colContent TEXT,'
        '$colDate TEXT)');
  }

  //getMapList
  Future<List<Map<String, dynamic>>> getScannedDataMapList() async {
    Database? db = await this.db;
    final List<Map<String, dynamic>> result = await db!.query(scannerTable);
    return result;
  }

  //get the list of data
  Future<List<ScannedData>> getScannedList() async {
    final List<Map<String, dynamic>> scannedMapList =
        await getScannedDataMapList();

    final List<ScannedData> scannedList = [];

    scannedMapList.forEach((element) {
      scannedList.add(ScannedData.fromMap(element));
    });

    scannedList.sort((scanB, scanA) => scanB.date!.compareTo(scanA.date!));

    return scannedList;
  }

  //insert scanned data
  Future<int> insertScannedData(ScannedData scannedData) async {
    Database? db = await this.db;
    final int result = await db!.insert(
      scannerTable,
      scannedData.toMap(),
    );
    return result;
  }

  //update scanned data
  Future<int> updatingScannedData(ScannedData scannedData) async {
    Database? db = await this.db;
    final int result = await db!.update(
      scannerTable,
      scannedData.toMap(),
      where: '$colId =?',
      whereArgs: [scannedData.id],
    );
    return result;
  }

  //delete scanned data
  Future<void> deletingScannedData(int id) async {
    Database? db = await this.db;
    // final int result =
    await db!.delete(
      scannerTable,
      where: '$colId = ?',
      whereArgs: [id],
    );
    // return result;
  }
}
