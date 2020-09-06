import 'dart:io';
import 'package:app_lib/widgets/alertBox.dart';
import 'package:app_lib/views/favourites/favouritesScreen.dart';
import 'package:app_lib/views/library/libScreen.dart';
import 'package:app_lib/models/pdf.dart';
import 'package:downloads_path_provider/downloads_path_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:permission_handler/permission_handler.dart';
import '../picker/picker.dart';
import '../../models/destination.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PDFDocument doc;
  List<PDF> listPdf = List();

  int _currentIndex = 0;

  List<Widget> _children = [LibScreen(), FavouritesScreen()];
  List<Destination> allDestinations = <Destination>[
    Destination('Lib', Icons.book, Colors.lightBlue),
    Destination('Favourites', Icons.favorite, Colors.pinkAccent),
  ];

  void getPermission() async {
    var status = await Permission.storage.status;

    if (status.isUndetermined) {
      Permission.storage.request();
    }
  }

  @override
  void initState() {
    //listController.gettingList();
    super.initState();
    getPermission();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.lightBlue,
        appBar: AppBar(
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: _children[_currentIndex],
        bottomNavigationBar: BottomNavigationBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            currentIndex: _currentIndex,
            items: allDestinations.map((Destination destination) {
              return BottomNavigationBarItem(
                  icon: Icon(destination.icon),
                  backgroundColor: destination.color,
                  title: Text(destination.title));
            }).toList()),
        floatingActionButton: FloatingActionButton(
          backgroundColor: _currentIndex == 0
              ? Color.fromRGBO(240, 98, 146, 1)
              : Colors.lightBlue,
          onPressed: () async {
            var status = await Permission.storage.status;
            if (status.isGranted) {
              Directory dir = await DownloadsPathProvider.downloadsDirectory;
              Navigator.pop(context, true);
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PickerScreen(dir)));
            } else if (status.isDenied) {
              Boxes.alertDialog(context, "Denied!");
            } else {
              Permission.storage.request();
            }
          },
          tooltip: 'Add PDF file',
          child: Icon(Icons.add),
        ));
    // This trailing comma makes auto-formatting nicer for build methods.
  }
}
