import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'dart:io';

class Reader extends StatefulWidget {
  final path;
  final name;

  Reader(this.path, this.name);
  @override
  _ReaderState createState() => _ReaderState();
}

class _ReaderState extends State<Reader> {
  bool loading = true;
  PDFDocument doc;

  @override
  void initState() {
    super.initState();
    loadingFile();
  }

  void loadingFile() async {
    File file = File(widget.path);
    doc = await PDFDocument.fromFile(file);
    //doc.get(page: 12);
    //print("okay");
    setState(() {
      loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : PDFViewer(
              document: doc,
            ),
    );
  }
}
