import 'package:app_lib/db/helperPdf.dart';

import 'package:flutter/material.dart';
import '../models/pdf.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class Controller extends ChangeNotifier {
  List<PDF> _listOfItens = [];
  List<PDFPage> _listOfpage = [];
  List<PDF> get list => _listOfItens;
  List<PDFPage> get listOfPages => _listOfpage;

  Controller() {
    if (_listOfItens.isEmpty) {
      setList();
    }
  }

  setList() async {
    await HelperPdf.getInstance().getAll().then((value) {
      _listOfItens = value;
      setThumb();
    });
  }

  setThumb() async {
    for (var item in _listOfItens) {
      PDFPage page;
      try {
        PDFDocument doc = await PDFDocument.fromFile(File(item.path));

        page = await doc.get(page: 1);
      } catch (e) {
        print(e);
      }
      _listOfpage.add(page);
    }
    notifyListeners();
  }

  List<PDF> returnFavourites(List<PDF> list) {
    List<PDF> favourites = [];
    for (var item in list) {
      if (item.favourite == 1) {
        favourites.add(item);
      }
    }
    return favourites;
  }

  Future<bool> update(int id) {
    HelperPdf.getInstance().setAsFavourite(id);
    setList();
    return Future.value(true);
  }
}
