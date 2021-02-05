import 'dart:io';
import 'package:database_app/models/User.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  static final String _dbName = "Members.db";
  static final String _tableName = "Members";

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await initiateDatabase();
    return _database;
  }

  initiateDatabase() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String path = join(directory.path, "$_dbName");
    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        // Create table
        await db.execute("CREATE TABLE $_tableName("
            " id INTEGER PRIMARY KEY AUTOINCREMENT,"
            "firstname TEXT,"
            "lastname TEXT,"
            "contactPhone TEXT,"
            "occupation TEXT,"
            "specialConditions TEXT,"
            "residentialAddress TEXT,"
            "maritalStatus TEXT,"
            "dependencies INTEGER,"
            "dob TEXT"
        ")");
      },
    );
  }

  // Insert data
  Future<int> insert(User user) async {
    Database db = await instance.database;
    return await db.insert("$_tableName", user.toMap());
  }

  // Query all data
  Future<List<User>> getAllUsers() async {
    Database db = await instance.database;
    final List<Map<String, dynamic>> maps = await db.query("$_tableName");
    return List.generate(
      maps.length,
      (index) => User(
          id: maps[index]['id'],
          firstname: maps[index]['firstname'],
          lastname: maps[index]['lastname'],
          occupation: maps[index]['occupation'],
          specialConditions: maps[index]['specialConditions'],
          residentialAddress: maps[index]['residentialAddress'],
          maritalStatus: maps[index]['maritalStatus'],
          dependencies: maps[index]['dependencies'],
          dob: maps[index]['dob']),
    );
  }

//  query one user
  Future<User> getUserById(int id) async {
    Database db = await instance.database;
    var result = await db.query("$_tableName", whereArgs: [id], where: "id=?");
    return result.isNotEmpty ? User.fromMap(result.first) : null;
  }

//  update
  Future<int> updateUser(User user) async {
    Database db = await instance.database;
    var result = await db.update("$_tableName", user.toMap(),
        where: 'id = ?', whereArgs: [user.id]);
    return result;
  }

//  delete
  Future<void> deleteUser(int id) async {
    Database db = await instance.database;
    return await db.delete("$_tableName", where: 'id = ?', whereArgs: [id]);
  }
}
