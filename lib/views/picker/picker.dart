import 'dart:io';
import 'package:app_lib/db/helperPdf.dart';
import 'package:app_lib/main.dart';
import 'package:app_lib/models/pdf.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';

class PickerScreen extends StatefulWidget {
  final currentDir;

  PickerScreen(this.currentDir);
  @override
  _PickerScreenState createState() => _PickerScreenState();
}

class _PickerScreenState extends State<PickerScreen> {
  List<FileSystemEntity> currentDirList = [];
  List<PDF> paths2save = [];
  List<int> tappedIndex = [];

  void pathHandler(File item) {
    try {
      List<FileSystemEntity> list = Directory(item.path).listSync();
      updatecurrentDirList(list);
    } catch (e) {
      if (item.path.toString().endsWith(".pdf")) {
        paths2save.length == 0
            ? paths2save
                .add(PDF(path: item.path.toString(), name: basename(item.path)))
            : paths2save.any((element) =>
                    element.path.toString() == item.path.toString())
                ? paths2save.removeWhere((element) =>
                    element.path.toString() == item.path.toString())
                : paths2save.add(
                    PDF(path: item.path.toString(), name: basename(item.path)));
      }
    }
  }

  void updatecurrentDirList(List<FileSystemEntity> list) {
    setState(() {
      currentDirList = list;
    });
  }

  @override
  void initState() {
    currentDirList = widget.currentDir.listSync();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("PDF Picker"),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            tappedIndex.clear();
            setState(() {
              updatecurrentDirList(widget.currentDir.parent.listSync());
            });
          },
        ),
      ),
      body: Center(
          child: currentDirList == null
              ? CircularProgressIndicator()
              : ListView.separated(
                  padding: const EdgeInsets.only(top: 15),
                  itemBuilder: (BuildContext context, int index) {
                    final item = currentDirList[index].path;
                    return Container(
                        color: tappedIndex.any((element) => element == index)
                            ? Color.fromRGBO(216, 220, 230, 1)
                            : Colors.transparent,
                        child: ListTile(
                          contentPadding: const EdgeInsets.all(5),
                          title: Text(
                            item.toString(),
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                          onTap: () {
                            //TO DO: Add extension filter
                            if (item.toString().endsWith("pdf")) {
                              setState(() {
                                pathHandler(File(item));
                                tappedIndex.any((element) => element == index)
                                    ? tappedIndex.removeWhere(
                                        (element) => element == index)
                                    : tappedIndex.add(index);
                              });
                            } else {
                              pathHandler(File(item));
                            }
                          },
                        ));
                  },
                  separatorBuilder: (BuildContext context, int index) =>
                      const Divider(),
                  itemCount: currentDirList.length)),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
          //padding: EdgeInsets.only(left: med),
          child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Container(
            child: SizedBox(
              child: FlatButton(
                child: Text("Cancelar",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.lightBlue,
            ),
          ),
          Container(
            width: 5,
            height: 2,
          ),
          Container(
            child: SizedBox(
              child: FlatButton(
                child: Text(
                  "Salvar",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                onPressed: () async {
                  for (PDF item in paths2save) {
                    await HelperPdf.getInstance().save(item);
                  }
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => MyApp()));
                },
              ),
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.pinkAccent,
            ),
          )
        ],
      )),
    );
  }
}
