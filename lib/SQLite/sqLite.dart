


import 'dart:convert';

import 'package:crypto/crypto.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

import '../jsonsModels/users.dart';




class DatabaseHelper {
  final databaseName = "auth.db";

  String user = '''
  CREATE TABLE users (
  usrId INTEGER PRIMARY KEY AUTOINCREMENT,
  email TEXT UNIQUE,
  userPassword TEXT
  )
  ''';

  Future<Database> initDB() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    return openDatabase(path, version: 1, onCreate: (db, version) async {
      await db.execute(user);
    });
  }

  Future<bool> login(Users user) async {
    final Database db = await initDB();
    var result = await db.query(
      "users",
      where: "email = ? AND userPassword = ?",
      whereArgs: [user.email, user.userPassword],
    );
    return result.isNotEmpty;
  }

  Future<int> signup(Users user) async {
    final Database db = await initDB();
    return db.insert("users", user.toMap());
  }

  Future<Users?> getUser(String email) async {
    final Database db = await initDB();
    var res = await db.query("users", where: "email = ?", whereArgs: [email]);
    return res.isNotEmpty ? Users.fromMap(res.first) : null;
  }
}