import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:flutter/material.dart';
import 'package:anime_list_app/anime.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await initDB();
    return _database;
  }

  initDB() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'anime_list1.db'),
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE anime (
        name TEXT PRIMARY KEY,
        epsNumber TEXT,
        lastSeen TEXT
        )
        ''');
      },
      version: 2,
    );
  }

  newAnime(AnimeList newAnime) async {
    final db = await database;
    var res = await db.rawInsert('''
    INSERT INTO anime (
      name,
      epsNumber,
      lastSeen
    ) VALUES (?, ?, ?)
    ''', [newAnime.name, newAnime.epsNumber, newAnime.lastSeen]);
    return res;
  }

  Future<dynamic> getAnime() async {
    final db = await database;
    var res = await db.query("anime");
    if (res.length == 0) {
      return null;
    } else {
      var resMap;

      return ListView.builder(
        itemCount: 1,
        itemBuilder: (BuildContext context, int index) {
          resMap = res[index];
          return resMap.isNotEmpty ? resMap : null;
        },
      );
    }
  }
}
