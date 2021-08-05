import 'dart:async';

import 'package:flutter/material.dart';
import 'package:test_app/models/news.dart';
import 'package:test_app/services/db.dart';
import 'package:test_app/views/sign_in.dart';

class NewsPage extends StatefulWidget {
  const NewsPage({Key key}) : super(key: key);

  @override
  _NewsPageState createState() => _NewsPageState();
}

class _NewsPageState extends State<NewsPage> {
  DataService _dataService = DataService();
  Future<List<NewsModel>> _newsModel;
  List<NewsModel> favNews = [];
  bool selected = true;


  Timer timer;

  Timer timerForDialog;

  sessionExpiredDialog(BuildContext context) {
    return showDialog(context: context, builder: (c) {
      return AlertDialog(
        title: Text("Session expiring in 5 seconds"),
      );
    });
  }


  @override
  void initState() {
    _newsModel = _dataService.getNews();

    timerForDialog = Timer.periodic(Duration(seconds: 7195), (timer) {
      sessionExpiredDialog(context);
      timerForDialog.cancel();
    });


    timer = Timer.periodic(Duration(seconds: 7200), (timer) {
      Navigator.pushReplacement(context, MaterialPageRoute(builder: (c) => SignInPage()));
      timer.cancel();
    });


    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    timer.cancel();
  }

  @override
  Widget build(BuildContext context) {

    double screenHeight = MediaQuery.of(context).size.height;
    double screenWidth = MediaQuery.of(context).size.width;

    newPage() {
      return Container(
        child: FutureBuilder<List<NewsModel>>(
          future: _newsModel,
          builder: (context, snap) {
            if (snap.hasData) {
              return ListView.builder(
                  itemCount: snap.data.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 12.0, horizontal: 8.0),
                      child: Container(
                        padding: EdgeInsets.all(4.0),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 4,
                                blurRadius: 6,
                                offset:
                                Offset(0, 7), // changes position of shadow
                              ),
                            ]),
                        child: ListTile(
                          leading: IconButton(
                            onPressed: () {
                              setState(() {
                                if(snap.data[index].isFav == false) {
                                  favNews.add(snap.data[index]);
                                  snap.data[index].isFav = true;
                                } else {
                                  setState(() {
                                    favNews.removeWhere((element) => element.id == snap.data[index].id);
                                    snap.data[index].isFav = false;
                                  });
                                }

                              });
                            },
                            icon: Icon(
                              snap.data[index].isFav ?Icons.favorite: Icons.favorite_border_rounded,
                              color:  snap.data[index].isFav ? Colors.red : Colors.black54,
                              size: 40,
                            ),
                          ),
                          title: Text(
                            snap.data[index].title,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          subtitle: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(
                                snap.data[index].summary ?? "No Summary",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                              ),
                              SizedBox(
                                height: 8.0,
                              ),
                              Text(snap.data[index].published),
                            ],
                          ),
                          isThreeLine: true,
                          //isThreeLine: true,
                        ),
                      ),
                    );
                  });
            } else {
              return Center(
                child: CircularProgressIndicator(),
              );
            }
          },
        ),
      );
    }

    favPage() {
      return Container(
        child: favNews.length != 0 ? ListView.builder(
            itemCount: favNews.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(
                    vertical: 12.0, horizontal: 8.0),
                child: Container(
                  padding: EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          spreadRadius: 4,
                          blurRadius: 6,
                          offset:
                          Offset(0, 7), // changes position of shadow
                        ),
                      ]),
                  child: ListTile(
                    leading: IconButton(
                      icon: Icon(
                        Icons.favorite,
                        color: Colors.red,
                        size: 40,
                      ),
                    ),
                    title: Text(
                      favNews[index].title,
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    subtitle: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(
                          favNews[index].summary ?? "No Summary",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 5,
                        ),
                        SizedBox(
                          height: 8.0,
                        ),
                        Text(favNews[index].published),
                      ],
                    ),
                    isThreeLine: true,
                    //isThreeLine: true,
                  ),
                ),
              );
            }) : Center(child: Text('No news added to favorites list', style: TextStyle(fontWeight: FontWeight.bold, color: Colors.black),)),
      );
    }



    return Scaffold(
      body: Stack(
        children: [
          selected ? newPage() : favPage(),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: screenHeight * 0.08,
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Container(
                        height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 4,
                                blurRadius: 6,
                                offset:
                                Offset(7, 0), // changes position of shadow
                              ),
                            ],
                            color: selected ? Colors.blue : Colors.white,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.menu, size: 30, color: selected ? Colors.white : Colors.black,),
                            SizedBox(width: 5.0,),
                            Text("News", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: selected ? Colors.white : Colors.black),)

                          ],
                        ),

                      ),
                    ),
                  ),
                  SizedBox(width: 10,),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selected = !selected;
                        });
                      },
                      child: Container(
                        height: screenHeight * 0.08,
                        decoration: BoxDecoration(
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 4,
                                blurRadius: 6,
                                offset:
                                Offset(7, 0), // changes position of shadow
                              ),
                            ],
                            color: selected ? Colors.white : Colors.blue,
                            borderRadius: BorderRadius.only(topLeft: Radius.circular(12.0), topRight: Radius.circular(12.0))
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.favorite, color: selected ? Colors.red : Colors.white, size: 30),
                            SizedBox(width: 5.0,),
                            Text("Favs", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24, color: selected ? Colors.black : Colors.white),)

                          ],
                        ),

                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }


}
