import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';

class DBProvider {
  // Create a singleton
  DBProvider._();

  static final DBProvider instance = DBProvider._();
  Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }

    _database = await initDB();
    return _database;
  }

  _onOpen(Database db) async {
    // Database is open, print its version
    // print('db version ${await db.getVersion()}');
  }

  /// Create USer table V2
  // void _createTableUserV2(Batch batch) {
  void _createTableUserV2(Database db, int version) {
    db.execute('DROP TABLE IF EXISTS Hot');
    db.execute('''CREATE TABLE IF NOT EXISTS Hot(
                    id int(100) PRIMARY KEY,
                    author_fullname varchar(200),
                    title varchar(200),

                    updated_at TEXT DEFAULT '')''');
    db.execute('DROP TABLE IF EXISTS New');
    db.execute('''CREATE TABLE IF NOT EXISTS New(
                    id int(100) PRIMARY KEY,
                    author_fullname varchar(200),
                    title varchar(200),

                    updated_at TEXT DEFAULT '')''');
  }

  initDB() async {
    Directory documentsDir = await getApplicationDocumentsDirectory();
    String path = join(documentsDir.path, 'jsonApp.db');

    try {
      return await openDatabase(path,
          version: 7,
          onOpen: _onOpen,
          onCreate: _createTableUserV2,
          onDowngrade: onDatabaseDowngradeDelete);
    } catch (e) {
      print(e.toString());
    }
  }
}
