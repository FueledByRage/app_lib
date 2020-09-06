import 'package:app_lib/provider/controller.dart';
import 'package:app_lib/models/pdf.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:app_lib/views/reader/readerScreen.dart';

class FavouritesScreen extends StatefulWidget {
  @override
  _FavouritesScreenState createState() => _FavouritesScreenState();
}

class _FavouritesScreenState extends State<FavouritesScreen> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      overflow: Overflow.visible,
      children: [
        Positioned(
            right: 0.0,
            top: 0.0,
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
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
                                itemCount: favourites.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                  PDF item = favourites[index];
                                  return Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Color.fromRGBO(
                                                245, 245, 245, 1),
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(24))),
                                        child: ListTile(
                                          /*leading: CircleAvatar(
                                            backgroundColor:
                                                Colors.lightBlueAccent,
                                            child: Text(
                                              item.id.toString(),
                                              style: TextStyle(
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                          ),*/
                                          title: Text(item.name),
                                          onTap: () {
                                            Navigator.of(context).push(
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                                        Reader(item.path,
                                                            item.name)));
                                          },
                                        ),
                                      ));
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
