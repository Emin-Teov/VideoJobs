import 'package:path/path.dart';
import 'package:public_ip_address/public_ip_address.dart';
import 'package:sqflite/sqflite.dart';

import '/models/context_model.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();
  DatabaseService._constructor();
  final List<String> language_codes = ['EN', 'AZ'];

  Future<Database> get database async {
    if (_db != null)
      return _db!;
    else
      _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final dir = await getDatabasesPath();
    final path = join(dir, 'job_tube_db.db');
    final database =
        await openDatabase(path, version: 1, onCreate: (db, version) async {
      db.execute('''
        CREATE TABLE IF NOT EXISTS users(
          id INTEGER PRIMARY KEY,
          token TEXT UNIQUE NOT NULL,
          username TEXT UNIQUE NOT NULL,
          firstname TEXT NOT NULL,
          surname TEXT NOT NULL,
          employment TEXT NOT NULL
        )
        ''');

      db.execute('''
        CREATE TABLE IF NOT EXISTS context(
          id INTEGER PRIMARY KEY,
          language TEXT NOT NULL,
          style BOOLEAN DEFAULT 1
        )
        ''');

      if (Sqflite.firstIntValue(
              await db.rawQuery('SELECT COUNT(*) FROM context')) ==
          0) {
        String _country_code = await IpAddress().getCountryCode();
        db.insert('context', {
          'language':
              language_codes.contains(_country_code) ? _country_code : 'EN',
        });
      }
    });
    return database;
  }

  void deleteDatabase() async {
    final dir = await getDatabasesPath();
    final path = join(dir, 'job_tube_db.db');
    databaseFactory.deleteDatabase(path);
  }

  Future<ContextModel?> getContext() async {
    final db = await database;
    final data = await db.query('context');
    List<ContextModel> context = data
        .map((e) => ContextModel(
            id: e["id"] as int,
            language: e["language"] as String,
            style: e["style"] as int))
        .toList();
    return context[0];
  }

  void changeStyle(int style) async {
    final db = await database;
    await db.update('context', {'style': style}, where: 'id = ?', whereArgs: [1]);
  }

  void changeLanguage() async {
    final db = await database;
    await db.update('context', {'language': 'EN'}, where: 'id = ?', whereArgs: [1]);
  }
}
