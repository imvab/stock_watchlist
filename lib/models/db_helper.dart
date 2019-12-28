import 'dart:async';
import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:stock_watchlist/classes/stock_class.dart';


class StockDataBase {
  static final StockDataBase _instance = StockDataBase._();
  static Database _database;

  StockDataBase._();

  factory StockDataBase() {
    return _instance;
  }

  Future<Database> get db async {
    // if (_database != null) {
    //   return _database;
    // }

    _database = await init();

    return _database;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');
    var database = openDatabase(dbPath, version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE stock(
        symbol TEXT PRIMARY KEY,
        name TEXT,
        series TEXT,
        date_listing TEXT,
        paid_value INTEGER,
        mkt_lot INTEGER,
        isin_num TEXT,
        face_value INTEGER)
    ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> addStock(Stock stock) async {
    var client = await db;
    return client.insert('stock', stock.toDb(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Stock> fetchStock(String symbol) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps = client.query('stock', where: 'SYMBOL = ?', whereArgs: [symbol]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return Stock.fromDb(maps.first);
    }

    return null;
  }

  Future<List<Stock>> fetchAll() async {
    var client = await db;
    var res = await client.query('stock');

    if (res.isNotEmpty) {
      var stocks = res.map((stockMap) => Stock.fromDb(stockMap)).toList();
      return stocks;
    }
    return [];
  }

  Future<int> updateStock(Stock newStock) async {
    var client = await db;
    return client.update('stock', newStock.toDb(),
        where: 'id = ?', whereArgs: [newStock.symbol], conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<void> removeStock(String symbol) async {
    var client = await db;
    return client.delete('stock', where: 'SYMBOL = ?', whereArgs: [symbol]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}