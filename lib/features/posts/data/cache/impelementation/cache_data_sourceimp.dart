import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../../../domain/models/post.dart';
import '../abstraction/cache_data_source.dart';

class PostLocalDataSourceImp implements PostLocalDataSource {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await intialDb();
      return _db;
    } else {
      return _db;
    }
  }

  intialDb() async {
    String databasepath = await getDatabasesPath();
    String path = join(databasepath, 'post.db');
    Database mydb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return mydb;
  }

  _onUpgrade(Database db, int oldversion, int newversion) {
    if (kDebugMode) {
      print("onUpgrade =====================================");
    }
  }

  _onCreate(Database db, int version) async {
    await db.execute('''
  CREATE TABLE "posts" (
    "id" INTEGER  NOT NULL , 
    "title" TEXT NOT NULL,
    "body"  TEXT NOT NULL
  )
 ''');
    if (kDebugMode) {
      print(" onCreate =====================================");
    }
  }

  @override
  Future<List<Post>> readData(String sql) async {
    Database? mydb = await db;
    List<Map<String, dynamic>> maps = await mydb!.rawQuery(sql);

    // Convert the list of maps to a list of Todo objects
    return List.generate(maps.length, (i) {
      return Post(
        id: maps[i]['id'],
        title: maps[i]['title'],
        body: maps[i]['body'],
      );
    });
  }

  @override
  insertData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawInsert(sql);
    return response;
  }

  @override
  updateData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawUpdate(sql);
    return response;
  }

  @override
  deleteData(String sql) async {
    Database? mydb = await db;
    int response = await mydb!.rawDelete(sql);
    return response;
  }
}
