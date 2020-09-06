import 'dart:async';
import 'package:app_lib/db/helperDb.dart';

import '../models/pdf.dart';

class HelperPdf extends HelperDb<PDF> {
  static final pdfTable = "pdf_table";
  static final String pathColumn = "path";
  static final String nameColumn = "name";
  static final String idColumn = "id";
  static final String favouriteColumn = "favourite";
  static HelperPdf _instance = HelperPdf.getInstance();

  factory HelperPdf() => _instance;
  HelperPdf.getInstance();

  @override
  Future<PDF> save(PDF pdf) async {
    db.then((database) async {
      await database.insert(pdfTable, pdf.toMap());
    });
    return pdf;
  }

  @override
  Future<List> filter(String param) => db.then((database) async {
        List listMap = await database
            .rawQuery("SELECT * FROM $pdfTable WHERE $nameColumn == %$param%");
        List<PDF> lista = List();
        for (Map m in listMap) {
          lista.add(PDF.fromMap(m));
        }
        return lista;
      });

  @override
  Future<List> getAll() => db.then((database) async {
        List listMap = await database.rawQuery("SELECT * FROM $pdfTable");
        List<PDF> lista = List();
        for (Map m in listMap) {
          lista.add(PDF.fromMap(m));
        }
        return lista;
      });

  @override
  Future<int> delete(int id) {
    return db.then((database) async {
      return await database
          .delete(pdfTable, where: "$idColumn = ?", whereArgs: [id]);
    });
  }

  @override
  setAsFavourite(int id) async {
    db.then((database) async {
      await database
          .rawQuery(
              "SELECT $favouriteColumn FROM $pdfTable WHERE $idColumn = $id")
          .then((value) {
        if (value[0]["favourite"] == 0) {
          database
              .rawUpdate(
                  "UPDATE $pdfTable SET $favouriteColumn = 1 WHERE $idColumn = $id")
              .then((value) {});
        } else {
          database
              .rawUpdate(
                  "UPDATE $pdfTable SET $favouriteColumn = 0 WHERE $idColumn = $id")
              .then((value) {});
        }
      });
    });
  }
}
