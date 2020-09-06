import 'package:app_lib/provider/controller.dart';
import 'package:app_lib/models/pdf.dart';
import 'package:app_lib/views/reader/readerScreen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LibScreen extends StatefulWidget {
  @override
  _LibScreenState createState() => _LibScreenState();
}

class _LibScreenState extends State<LibScreen> {
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
                    boxShadow: <BoxShadow>[
                      BoxShadow(
                          color: Colors.black,
                          offset: Offset(1.0, 6.0),
                          blurRadius: 40.0)
                    ],
                    color: Colors.white,
                    //Color.fromRGBO(224, 224, 224, 1),
                    borderRadius: BorderRadius.all(Radius.circular(24))),
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
                            "List of documents",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.lightBlue),
                          ),
                          SizedBox(
                            height: 1.0,
                          ),
                          Icon(
                            Icons.book,
                            color: Colors.lightBlue,
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
                          if (value.list.isNotEmpty) {
                            return ListView.separated(
                                itemCount: value.list.length,
                                separatorBuilder:
                                    (BuildContext context, int index) =>
                                        const Divider(),
                                itemBuilder: (BuildContext context, int index) {
                                  PDF item = value.list[index];
                                  return Padding(
                                      padding: EdgeInsets.only(top: 10.0),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: Colors.lightBlue,
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
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),*/
                                            title: Text(
                                              item.name,
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            trailing: IconButton(
                                                icon: item.favourite == 0 ||
                                                        item.favourite == null
                                                    ? Icon(Icons.star_border)
                                                    : Icon(
                                                        Icons.star,
                                                        color: Color.fromRGBO(
                                                            240, 98, 146, 1),
                                                      ),
                                                onPressed: () async {
                                                  await value.update(item.id);
                                                }),
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Reader(item.path,
                                                              item.name)));
                                            }),
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
