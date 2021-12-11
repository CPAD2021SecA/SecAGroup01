import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/widgets/icon_badge.dart';
import 'package:flutter_demo_tourism_app/util/places.dart';
import 'package:flutter_demo_tourism_app/widgets/search_bar.dart';
import 'package:flutter_demo_tourism_app/screens/details.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // int _counter = 0;
  //
  // void _incrementCounter() {
  //   setState(() {
  //     // This call to setState tells the Flutter framework that something has
  //     // changed in this State, which causes it to rerun the build method below
  //     // so that the display can reflect the updated values. If we changed
  //     // _counter without calling setState(), then the build method would not be
  //     // called again, and so nothing would appear to happen.
  //     _counter++;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        //title: Text(),
        title: Text(
          widget.title,
          //'Flutter Demo Home Page',
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
          //buildHorizontalList(context),
          Container(
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
                                  Container(
                                    padding: EdgeInsets.only(left: 20),
                                    height: 250.0,
                                    child: ListView.builder(
                                      scrollDirection: Axis.horizontal,
                                      primary: false,
                                      itemCount:
                                          places == null ? 0 : places.length,
                                      itemBuilder:
                                          (BuildContext context, int index) {
                                        Map place = places[index];

                                        return Padding(
                                          padding: EdgeInsets.only(right: 10.0),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                            child: Image.asset(
                                              "${place["img"]}",
                                              height: 250.0,
                                              width: MediaQuery.of(context)
                                                      .size
                                                      .width -
                                                  40.0,
                                              fit: BoxFit.cover,
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),
                                  SizedBox(height: 20),
                                  ListView(
                                    padding:
                                        EdgeInsets.symmetric(horizontal: 20),
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
          ),

          //buildVerticalList(),
          Padding(
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
          )
        ],
      ),
      // body: Center(
      //   // Center is a layout widget. It takes a single child and positions it
      //   // in the middle of the parent.
      //   child: Column(
      //     // Column is also a layout widget. It takes a list of children and
      //     // arranges them vertically. By default, it sizes itself to fit its
      //     // children horizontally, and tries to be as tall as its parent.
      //     //
      //     // Invoke "debug painting" (press "p" in the console, choose the
      //     // "Toggle Debug Paint" action from the Flutter Inspector in Android
      //     // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
      //     // to see the wireframe for each widget.
      //     //
      //     // Column has various properties to control how it sizes itself and
      //     // how it positions its children. Here we use mainAxisAlignment to
      //     // center the children vertically; the main axis here is the vertical
      //     // axis because Columns are vertical (the cross axis would be
      //     // horizontal).
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: <Widget>[
      //       const Text(
      //         'You have pushed the button this many times:',
      //       ),
      //       Text(
      //         '$_counter',
      //         style: Theme.of(context).textTheme.headline4,
      //       ),
      //     ],
      //   ),
      // ),
      // floatingActionButton: FloatingActionButton(
      //   onPressed: _incrementCounter,
      //   tooltip: 'Increment',
      //   child: const Icon(Icons.add),
      // ), // This trailing comma makes auto-formatting nicer for build methods.
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
