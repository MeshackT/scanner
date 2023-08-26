import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ScannedData {
  int id;
  String content;
  DateTime timestamp;

  ScannedData(this.id, this.content, this.timestamp);

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'content': content,
      'timestamp': timestamp.toIso8601String(),
    };
  }
}

class DatabaseHelper {
  Future<Database> database() async {
    return openDatabase(
      join(await getDatabasesPath(), 'scanned_data.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE scanned_data(id INTEGER PRIMARY KEY, content TEXT, timestamp TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> insertScannedData(ScannedData scannedData) async {
    final db = await database();
    await db.insert(
      'scanned_data',
      scannedData.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<ScannedData>> getScannedDataList() async {
    final db = await database();
    final List<Map<String, dynamic>> maps = await db.query('scanned_data');
    return List.generate(maps.length, (i) {
      return ScannedData(
        maps[i]['id'],
        maps[i]['content'],
        DateTime.parse(maps[i]['timestamp']),
      );
    });
  }

  Future<int> delete(int id) async {
    final db = await database();

    return await db.delete(
      "scanned_data",
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
