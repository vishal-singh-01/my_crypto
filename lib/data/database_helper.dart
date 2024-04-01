import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/cryptocurrency.dart';


class DatabaseHelper {
  // static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  // static Database? _database;

  // DatabaseHelper._privateConstructor();

  // static Future<void> initialize() async {
  //   // Initialize the SQLite database factory
  //   databaseFactory = databaseFactoryFfi;
  // }

  // Future<Database> get database async {
  //   if (_database != null) return _database!;
  //
  //   _database = await _initDatabase();
  //   return _database!;
  // }

  static final DatabaseHelper _instance = DatabaseHelper._();
  static Database? _database;

  DatabaseHelper._();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    // String path = join(await getDatabasesPath(), 'cryptocurrency_database.db');
    // return await databaseFactory.openDatabase(
    //   path,
    //   // version: 1,
    //   onCreate: _createDatabase,
    // );atabasesPath(), 'cryptocurrency_database.db');
    //     // return await databaseFactory.openDatabase(
    //     //   path,
    //     //   // version: 1,

    var databasesPath = await getDatabasesPath();
    String path = join(databasesPath, 'cryptocurrency_database.db');
    return await openDatabase(
        path,
        version: 1,
        onCreate: (Database db, int version) async {
         // When creating the db, create the table
         // await _createDatabase(db, 1);
          print('Creating table cryptocurrencies');

          await db.execute('''
      CREATE TABLE cryptocurrencies (
        id INTEGER PRIMARY KEY,
        name TEXT,
        symbol TEXT,
        slug TEXT,
        first_historical_data TEXT,
        last_historical_data TEXT,
        is_favorite INTEGER
      )''');
       });
  }




  Future<void> _createDatabase(Database db, int version) async {
    await db.execute('''
      CREATE TABLE cryptocurrencies (
        id INTEGER PRIMARY KEY,
        name TEXT,
        symbol TEXT,
        slug TEXT,
        first_historical_data TEXT,
        last_historical_data TEXT,
        is_favorite INTEGER
      )
    ''');
  }

  // Future<void> insertCryptocurrency(Map<String, dynamic> cryptocurrency) async {
  //   final db = await database;
  //   await db.insert('cryptocurrencies', cryptocurrency,
  //       conflictAlgorithm: ConflictAlgorithm.replace);
  // }

  // Future<List<Map<String, dynamic>>> getCryptocurrencies() async {
  //   final db = await database;
  //   return await db.query('cryptocurrencies');
  // }


  Future<void> insertCryptocurrency(Cryptocurrency cryptocurrency) async {
    final db = await database;
    await db.insert(
      'cryptocurrencies',
      cryptocurrency.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Cryptocurrency>> getCryptocurrencies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('cryptocurrencies');
    return List.generate(maps.length, (i) {
      return Cryptocurrency(
        id: maps[i]['id'],
        name: maps[i]['name'],
        symbol: maps[i]['symbol'],
        slug: maps[i]['slug'],
        first_historical_data: maps[i]['first_historical_data'],
        last_historical_data: maps[i]['last_historical_data'],
        isFavorite: maps[i]['is_favorite'] == 1,
      );
    });
  }

  Future<void> updateCryptocurrency(Cryptocurrency cryptocurrency) async {
    final db = await database;
    await db.update(
      'cryptocurrencies',
      cryptocurrency.toMap(),
      where: 'id = ?',
      whereArgs: [cryptocurrency.id],
    );
  }

  Future<void> deleteCryptocurrency(int id) async {
    final db = await database;
    await db.delete(
      'cryptocurrencies',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  Future<List<Cryptocurrency>> getFavoriteCryptocurrencies() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(
      'cryptocurrencies',
      where: 'is_favorite = ?',
      whereArgs: [1], // 1 indicates favorite cryptocurrencies
    );

    return List.generate(maps.length, (i) {
      return Cryptocurrency(
        id: maps[i]['id'],
        name: maps[i]['name'],
        symbol: maps[i]['symbol'],
        slug: maps[i]['slug'],
        first_historical_data: maps[i]['first_historical_data'],
        last_historical_data: maps[i]['last_historical_data'],
        isFavorite: maps[i]['is_favorite'] == 1,
      );
    });
  }
}
