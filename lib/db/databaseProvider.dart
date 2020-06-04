import 'package:fetchtask/pages/Models/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'dart:async';
import 'databaseHelper.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = new DatabaseHelper.internal();
  factory DatabaseHelper() => _instance;
  static Database db;

  DatabaseHelper.internal();

  initDb() async {
    DBProvider dbProvider = DBProvider.instance;
    db = await dbProvider.database;
  }

  Future<int> saveJson(Data datas, {@required String dbTableName}) async {
    try {
      int res = await db.insert(dbTableName, datas.toJson());
      return res;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<List<Data>> getJson({@required String dbTableName}) async {
    try {
      var rows = await db.query(dbTableName);
      if (rows != null && rows.length > 0) {
        return rows.isNotEmpty
            ? rows
                .map(
                  (classes) => Data.fromDBJson(classes),
                )
                .toList()
            : [];
      }
      return null;
    } catch (e) {
      return null;

      // throw e.toString();
    }
  }

  Future<int> saveNewJson(Data datas) async {
    print(datas.authorFullname);
    try {
      int res = await db.insert("Hot", datas.toJson());
      return res;
    } catch (e) {
      print(e.toString());
      throw e.toString();
    }
  }

  Future<List<Data>> getNewJson() async {
    try {
      var rows = await db.query('Hot');
      if (rows != null && rows.length > 0) {
        return rows.isNotEmpty
            ? rows
                .map(
                  (classes) => Data.fromDBJson(classes),
                )
                .toList()
            : [];
      }
      return null;
    } catch (e) {
      return null;

      // throw e.toString();
    }
  }

  // Future<int> deletedatass() async {
  //   return db
  //       .rawDelete('Delete from Hot'); // where: 'id = ?', whereArgs: [id]);
  // }
}
