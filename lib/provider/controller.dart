import 'package:app_lib/db/helperPdf.dart';
import 'package:flutter/material.dart';
import '../models/pdf.dart';

class Controller extends ChangeNotifier {
  List<PDF> _listOfItens = [];

  List<PDF> get list => _listOfItens;


  

  Controller() {
    if (_listOfItens.isEmpty) {
      setList();
    }
  }

  setList() async {
    await HelperPdf.getInstance().getAll().then((value) {
      _listOfItens = value;
      notifyListeners();
    });
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
