import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:travelex/functions/classes/wishlist_object.dart';
import '../classes/visit_object.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();
  static Database _database;
  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase('mainDatabase.db');
    return _database;
  }

  Future<Database> _initDatabase(String filePath) async {
    // Directory documentsDirectory = await getApplicationDocumentsDirectory();
    // String path = join(documentsDirectory.path, 'mainDatabase.db');
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
    CREATE TABLE mainDatabase(
    id INTEGER PRIMARY KEY,
    cityName TEXT,
    cityCode TEXT,
    continent TEXT
    ) 
    ''');
    await db.execute('''
    CREATE TABLE wishListDatabase(
    id INTEGER PRIMARY KEY,
    cityName TEXT,
    imgUrl TEXT,
    streetView TEXT,
    location TEXT
    ) 
    ''');
  }

  Future<List<Visit>> getVisits() async {
    Database db = await instance.database;
    var visits = await db.query('mainDatabase');
    List<Visit> visitsList =
        visits.isNotEmpty ? visits.map((c) => Visit.fromMap(c)).toList() : [];
    print(visitsList);
    return visitsList;
  }

  //returns all cities added to WishList as a list of objects <LikedCity>
  Future<List<LikedCity>> getWishList() async {
    Database db = await instance.database;
    var liked = await db.query('wishListDatabase');
    List<LikedCity> LikedCitiesList =
        liked.isNotEmpty ? liked.map((c) => LikedCity.fromMap(c)).toList() : [];
    print(LikedCitiesList);
    return LikedCitiesList;
  }

  Future<List<Visit>> conditionalVisits(String c) async {
    Database db = await instance.database;
    var visits = await db
        .rawQuery('SELECT * FROM mainDatabase WHERE continent = ?', [c]);
    List<Visit> visitsList =
        visits.isNotEmpty ? visits.map((c) => Visit.fromMap(c)).toList() : [];
    return visitsList;
  }

  Future<int> addMainDb(Visit visit) async {
    Database db = await instance.database;
    return await db.insert('mainDatabase', visit.toMap());
  }

  // adds a city to WishList database <wishListDatabase>
  Future<int> addToLiked(LikedCity city) async {
    Database db = await instance.database;
    return await db.insert('wishListDatabase', city.toMap());
  }

  void deleteRecordFromMainDb(Visit visit) async {
    Database db = await instance.database;
    await db.rawDelete(
      'DELETE FROM mainDatabase WHERE cityName = ?',
      [visit.cityName],
    );
  }

  // deletes a record (city) from the WishList database
  void deleteRecordFromWishList(LikedCity city) async {
    Database db = await instance.database;
    await db.rawDelete(
      'DELETE FROM wishListDatabase WHERE cityName = ?',
      [city.cityName],
    );
  }

  Future<bool> findRecordInMainDb(String cityName) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT cityName FROM mainDatabase WHERE cityName = ?', [cityName]);
    if (res.isNotEmpty) {
      Fluttertoast.showToast(
        msg: "Country Already Visited",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.SNACKBAR,
        backgroundColor: Colors.orange,
        textColor: Colors.white,
        fontSize: 12.sp,
      );
      return false;
    } else {
      return true;
    }
  }

  Future<bool> findRecordInWishList(String cityName) async {
    Database db = await instance.database;
    var res = await db.rawQuery(
        'SELECT cityName FROM wishListDatabase WHERE cityName = ?', [cityName]);
    if (res.isNotEmpty) {
      return true;
    } else {
      return false;
    }
  }

  void printDatabase() async {
    Database db = await instance.database;
    final result = await db.rawQuery('SELECT * FROM mainDatabase ');
    print('Printing Database : ');
    print(result);
  }

  //Deletes all db's
  Future deleteDb() async {
    final dbPath = await getDatabasesPath();
    String path = join(dbPath, 'mainDatabase.db');
    await deleteDatabase(path);
    //WishListDatabase
    final dbPath2 = await getDatabasesPath();
    String path2 = join(dbPath2, 'wishListDatabase.db');
    await deleteDatabase(path2);
  }

  Future<void> EmptyMainDb() async {
    Database db = await instance.database;
    db.rawDelete('DELETE FROM mainDatabase');
  }

  Future<void> EmptyBucketListDb() async {
    Database db = await instance.database;
    db.rawDelete('DELETE FROM wishListDatabase');
  }
}
