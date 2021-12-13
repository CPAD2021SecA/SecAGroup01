import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/widgets/icon_badge.dart';
import 'package:flutter_demo_tourism_app/util/places.dart';
import 'package:flutter_demo_tourism_app/widgets/search_bar.dart';
import 'package:flutter_demo_tourism_app/screens/details.dart';

// class MyHomePage extends StatefulWidget {
//   const MyHomePage({Key? key, required this.title}) : super(key: key);
//
//   final String title;
//
//   @override
//   State<MyHomePage> createState() => _MyHomePageState();
// }

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   icon: Icon(
        //     Icons.arrow_back,
        //   ),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Text(
          title,
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(
          Icons.person,
      ),
            onPressed: () {
              
            },
          ),
        ],
      ),
      body: ListView(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Text(
              "Where are you \ngoing?",
              style: TextStyle(
                fontSize: 30.0,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(20.0),
            child: SearchBar(),
          ),
          buildHorizontalList(context),
          buildHorizontalList(context),
          buildVerticalList(),

        ],
      ),

    );
  }

  buildHorizontalList(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: 10.0, left: 20.0),
      height: 250.0,
      width: MediaQuery.of(context).size.width,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        primary: false,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places.reversed.toList()[index];
          return Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: InkWell(
              child: Container(
                height: 250.0,
                width: 140.0,
                child: Column(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: Image.asset(
                        "${place["img"]}",
                        height: 178.0,
                        width: 140.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 7.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${place["name"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0,
                        ),
                        maxLines: 2,
                        textAlign: TextAlign.left,
                      ),
                    ),
                    SizedBox(height: 3.0),
                    Container(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "${place["location"]}",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 13.0,
                          color: Colors.blueGrey[300],
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.left,
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Scaffold(
                        appBar: AppBar(
                          leading: IconButton(
                            icon: Icon(
                              Icons.arrow_back,
                            ),
                            onPressed: () => Navigator.pop(context),
                          ),
                          actions: <Widget>[
                            IconButton(
                              icon: IconBadge(
                                icon: Icons.notifications_none,
                              ),
                              onPressed: () {},
                            ),
                          ],
                        ),
                        body: ListView(
                          children: <Widget>[
                            SizedBox(height: 10.0),
                            //row 1
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              height: 250.0,
                              child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                primary: false,
                                itemCount: places == null ? 0 : places.length,
                                itemBuilder: (BuildContext context, int index) {
                                  Map place = places[index];

                                  return Padding(
                                    padding: EdgeInsets.only(right: 10.0),
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(10.0),
                                      child: Image.asset(
                                        "${place["img"]}",
                                        height: 250.0,
                                        width:
                                            MediaQuery.of(context).size.width -
                                                40.0,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            //row 2

                            SizedBox(height: 20),
                            ListView(
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              primary: false,
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              children: <Widget>[
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: <Widget>[
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${places[0]["name"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.w700,
                                          fontSize: 20,
                                        ),
                                        maxLines: 2,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                    IconButton(
                                      icon: Icon(
                                        Icons.bookmark,
                                      ),
                                      onPressed: () {},
                                    ),
                                  ],
                                ),
                                Row(
                                  children: <Widget>[
                                    Icon(
                                      Icons.location_on,
                                      size: 14,
                                      color: Colors.blueGrey[300],
                                    ),
                                    SizedBox(width: 3),
                                    Container(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        "${places[0]["location"]}",
                                        style: TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 13,
                                          color: Colors.blueGrey[300],
                                        ),
                                        maxLines: 1,
                                        textAlign: TextAlign.left,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${places[0]["price"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 17,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 40),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "Details",
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 16,
                                    ),
                                    maxLines: 1,
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Container(
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    "${places[0]["details"]}",
                                    style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 15.0,
                                    ),
                                    textAlign: TextAlign.left,
                                  ),
                                ),
                                SizedBox(height: 10.0),
                              ],
                            ),
                          ],
                        ),
                        floatingActionButton: FloatingActionButton(
                          child: Icon(
                            Icons.airplanemode_active,
                          ),
                          onPressed: () {},
                        ),
                      );
                      ;
                    },
                  ),
                );
              },
            ),
          );
          ;
        },
      ),
    );
  }

  buildVerticalList() {
    return Padding(
      padding: EdgeInsets.all(20.0),
      child: ListView.builder(
        primary: false,
        physics: NeverScrollableScrollPhysics(),
        shrinkWrap: true,
        itemCount: places == null ? 0 : places.length,
        itemBuilder: (BuildContext context, int index) {
          Map place = places[index];
          return Padding(
            padding: const EdgeInsets.only(bottom: 15.0),
            child: InkWell(
              child: Container(
                height: 70.0,
                child: Row(
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Image.asset(
                        "${place["img"]}",
                        height: 70.0,
                        width: 70.0,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(width: 15.0),
                    Container(
                      height: 80.0,
                      width: MediaQuery.of(context).size.width - 130.0,
                      child: ListView(
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${place["name"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 14.0,
                              ),
                              maxLines: 2,
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 3.0),
                          Row(
                            children: <Widget>[
                              Icon(
                                Icons.location_on,
                                size: 13.0,
                                color: Colors.blueGrey[300],
                              ),
                              SizedBox(width: 3.0),
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  "${place["location"]}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13.0,
                                    color: Colors.blueGrey[300],
                                  ),
                                  maxLines: 1,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                            ],
                          ),
                          SizedBox(height: 10.0),
                          Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "${place["price"]}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 16.0,
                              ),
                              maxLines: 1,
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (BuildContext context) {
                      return Details();
                    },
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
