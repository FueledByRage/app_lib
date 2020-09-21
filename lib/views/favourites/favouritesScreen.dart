import 'package:app_lib/provider/controller.dart';
import 'package:app_lib/models/pdf.dart';
import 'package:app_lib/views/reader/readerScreen.dart';
import 'package:app_lib/widgets/alertBox.dart';
import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';
import 'package:provider/provider.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
      overflow: Overflow.visible,
      children: [
        Positioned(
            right: 0.0,
            top: 0.0,
            width: size.width,
            height: size.height,
            child: Container(
                decoration: BoxDecoration(
                    color: Colors.pinkAccent,
                    //Color.fromRGBO(224, 224, 224, 1),
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "List of favourites",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(
                            height: 1.0,
                          ),
                          Icon(
                            Icons.favorite,
                            color: Colors.white,
                            size: 15,
                          )
                        ],
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Consumer<Controller>(builder:
                            (BuildContext context, Controller value,
                                Widget child) {
                          List<PDF> favourites =
                              value.returnFavourites(value.list);
                          if (favourites.isNotEmpty) {
                            return ListView.separated(
                                physics: BouncingScrollPhysics(),
                                itemCount: favourites.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                  PDF item = favourites[index];
                                  PDFPage page = value.listOfPages[index];
                                  return Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: GestureDetector(
                                          onTap: () {
                                            try {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Reader(item.path,
                                                              item.name)));
                                            } catch (e) {
                                              Boxes.alertDialog(context, e);
                                            }
                                          },
                                          child: Container(
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                boxShadow: [
                                                  BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.5),
                                                      spreadRadius: 5,
                                                      blurRadius: 7,
                                                      offset: Offset(0, 3))
                                                ],
                                                borderRadius:
                                                    BorderRadius.circular(12)),
                                            height: 100.0,
                                            width: size.width,
                                            //color: Colors.amber,
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: [
                                                Container(
                                                  /*decoration: BoxDecoration(
                                                          boxShadow: <
                                                              BoxShadow>[
                                                            BoxShadow(
                                                                color:
                                                                    Colors.blue)
                                                          ]),*/
                                                  width: 100,
                                                  height: 150,
                                                  child: ClipRRect(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              24.0),
                                                      child: page),
                                                ),
                                                Expanded(
                                                    child: Container(
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            left: 16.0),
                                                    child: Text(
                                                      item.name,
                                                      style: TextStyle(
                                                          fontWeight:
                                                              FontWeight.bold),
                                                    ),
                                                  ),
                                                )),
                                              ],
                                            ),
                                          )));
                                });
                          } else {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        }))
                  ],
                )))
      ],
    );
  }
}
