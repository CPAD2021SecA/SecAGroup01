import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart' ;
import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/Service/Auth_Service.dart';
import 'package:flutter_demo_tourism_app/screens/user_profile.dart';
import 'package:flutter_demo_tourism_app/screens/welcome_screen.dart';
import 'package:flutter_demo_tourism_app/widgets/icon_badge.dart';
import 'package:flutter_demo_tourism_app/util/places.dart';
import 'package:flutter_demo_tourism_app/widgets/search_bar.dart';
import 'package:flutter_demo_tourism_app/screens/details.dart';

class Place {
  final String name;
  final String description;
  final String imgFile;

  const Place(this.name, this.description, this.imgFile);
}
 class MainScreen extends StatefulWidget {
   const MainScreen({Key? key}) : super(key: key);
   static  const  String id = 'main_screen';
   @override
   _MainScreenState createState() => _MainScreenState();
 }

 class _MainScreenState extends State<MainScreen> {
   AuthClass authClass = AuthClass();
   final _auth = FirebaseAuth.instance;
   late User loggedInUser;
   void getCurrentUser () async {
     final user = await _auth.currentUser;
     if (user !=null){
      loggedInUser = user;
      print(loggedInUser.email);
     }
   }
   @override
   void initState(){
     super.initState();
     getCurrentUser();
   }
   // AuthClass authClass = new AuthClass();
   final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("placeDetails").snapshots();


   @override
   Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.amber,
      ),
      home: Scaffold(
        appBar: AppBar(
          // leading: IconButton(
          //   icon: Icon(
          //     Icons.person,
          //   ),
          //   onPressed: () {
          //     Navigator.push(
          //       context,
          //       MaterialPageRoute(
          //         builder: (context) =>  UserProfile(),
          //       ),
          //     );
          //   },
          // ),
          title: Text(
            "Take A Tour",
          ),
          actions: <Widget>[
            Row(
              children: [
                IconButton(
                  icon: Icon(
                    Icons.logout,
                  ),
                  onPressed: () async {
                    setState(() {

                    });
                    //todo: log out functionality
                  //  _auth.signOut();
                    await authClass.logout();

                    Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (builder) => WelcomeScreen()), (route) => false);
                    //Navigator.popAndPushNamed(context, WelcomeScreen.id);

                  },
                ),
                IconButton(
                  icon: Icon(Icons.person),
                  onPressed: (){
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) =>  UserProfile(),
                      ),
                    );
                  },
                )
              ],
            ),
          ],
        ),
        body: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20.0),
              child: Text(
                "Where are you going?",
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
            buildHorizontalList(context,_stream),
            buildHorizontalList(context, _stream),
            // buildVerticalList(),

          ],
        ),

      ),
      // home: MyHomePage(title: 'TakeATour'),
    );
   }
 }
 buildHorizontalList(BuildContext, stream){
   return StreamBuilder<QuerySnapshot>(
       stream: stream,
       builder: (context, snapshot) {
         if(!snapshot.hasData){
           return Center(child: CircularProgressIndicator());
         }
         return Container(
           padding: EdgeInsets.only(top: 10.0, left: 20.0),
           height: 250.0,
           width: MediaQuery.of(context).size.width,

           child: ListView.builder(
             scrollDirection: Axis.horizontal,
             primary: false,
             itemCount:snapshot.data!.docs.length,

             itemBuilder: (context, index) {

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
                             "assets/"+"${snapshot.data!.docs[index].get('imgFileName')}",
                             height: 178.0,
                             width: 140.0,
                             fit: BoxFit.cover,
                           ),
                         ),
                         SizedBox(height: 7.0),
                         Container(
                           alignment: Alignment.centerLeft,
                           child: Text(
                             "${snapshot.data!.docs[index].get('placeName')}",
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
                             "${snapshot.data!.docs[index].get('placeDesc')}",
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

                     int i = index;
                     Place place = new Place(snapshot.data!.docs[index].get('placeDesc'),snapshot.data!.docs[index].get('placeDesc'),snapshot.data!.docs[index].get('imgFileName'));
                     Navigator.push(
                       context,
                       MaterialPageRoute(
                         builder: (context) =>  Details(place : place),
                       ),
                     );
                   },

                 ),
               );

             },
           ),
         );

       }
   );
 }




  buildVerticalList() {
    return StreamBuilder<Object>(
      stream: null,
      builder: (context, snapshot) {
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
                    // Navigator.of(context).push(
                    //   MaterialPageRoute(
                    //     builder: (BuildContext context) {
                    //       return Details();
                    //     },
                    //   ),
                    // );
                    int i = index;
                    // Place place = new Place(snapshot.data!.docs[index].get('placeDesc'),snapshot.data!.docs[index].get('placeDesc'),snapshot.data!.docs[index].get('imgFileName'));
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) =>  Details(place : place),
                    //   ),
                    // );
                  },
                ),
              );
            },
          ),
        );
      }
    );

}





