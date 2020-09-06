import 'package:app_lib/db/helperPdf.dart';

class PDF {
  int _id;
  String _path;
  String _name;
  int _favourite;

  PDF({int id, String path, String name, int favourite}) {
    this._id = id;
    this._path = path;
    this._name = name;
    this._favourite = favourite;
  }

  int get id => this._id;
  set id(int id) => this._id = id;

  String get path => this._path;
  set path(String path) => this.path = path;

  String get name => this._name;
  set name(String name) => this.name = name;

  int get favourite => this._favourite;
  set favourite(int favourite) => this.favourite = favourite;

  PDF.fromMap(Map map) {
    _id = map[HelperPdf.idColumn];
    _path = map[HelperPdf.pathColumn];
    _name = map[HelperPdf.nameColumn];
    _favourite = map[HelperPdf.favouriteColumn];
  }

  Map toMap() {
    Map<String, dynamic> map = {
      HelperPdf.pathColumn: path,
      HelperPdf.nameColumn: name,
      HelperPdf.favouriteColumn: favourite
    };
    if (id != null) {
      map[HelperPdf.idColumn] = id;
    }
    return map;
  }
}
