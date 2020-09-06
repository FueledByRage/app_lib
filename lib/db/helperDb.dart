import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../db/helperPdf.dart';

abstract class HelperDb<T> {
  static final String dataBaseName = "pdf_documents.db";
  Database _database;

  Future<T> save(T object);
  Future<int> delete(int id);
  Future<List> filter(String param);
  Future<List> getAll();
  setAsFavourite(int id);

  Future<Database> get db async {
    if (_database != null) {
      return _database;
    } else {
      _database = await initDb();
      return _database;
    }
  }

  Future<Database> initDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, dataBaseName);

    return await openDatabase(path, version: 1, onCreate: _create);
  }

  Future _create(Database db, int version) async {
    print("criado");
    await db
        .execute(
            "CREATE TABLE IF NOT EXISTS ${HelperPdf.pdfTable}(${HelperPdf.idColumn} INTEGER PRIMARY KEY AUTOINCREMENT, ${HelperPdf.pathColumn} TEXT UNIQUE, ${HelperPdf.nameColumn} TEXT, ${HelperPdf.favouriteColumn} INTEGER DEFAULT 0 )")
        .then((value) => print("ok"));
  }
}
