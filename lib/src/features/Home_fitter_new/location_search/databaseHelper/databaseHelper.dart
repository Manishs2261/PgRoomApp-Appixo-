import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  DatabaseHelper._internal();

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE search_history (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            search_query TEXT NOT NULL
          )
        ''');
      },
    );
  }

  Future<int> insertSearchQuery(String query) async {
    final db = await database;
    return await db.insert('search_history', {'search_query': query});
  }

  Future<List<Map<String, dynamic>>> getSearchHistory() async {
    final db = await database;
    return await db.query('search_history', orderBy: 'id DESC');
  }

  Future<int> deleteSearchQuery(int id) async {
    final db = await database;
    return await db.delete('search_history', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> clearSearchHistory() async {
    final db = await database;
    await db.delete('search_history');
  }
}
