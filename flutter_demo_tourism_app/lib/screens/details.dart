

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/Service/Auth_Service.dart';
import 'package:flutter_demo_tourism_app/Service/DataBase_Service.dart';
import 'package:flutter_demo_tourism_app/screens/main_screen.dart';
import 'package:flutter_demo_tourism_app/screens/package_form.dart';
import 'package:flutter_demo_tourism_app/screens/review_form.dart';
import 'package:flutter_demo_tourism_app/widgets/icon_badge.dart';


class Details extends StatefulWidget {
  final Place place;
  const Details({Key? key, required this.place,  }) : super(key: key);

  @override
  _DetailsState createState() => _DetailsState(place);
}


class _DetailsState extends State<Details> {
  Place place;
  _DetailsState(this.place);
  AuthClass authClass = new AuthClass();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  void getCurrentUser () async {
    final user = await _auth.currentUser;
    if (user !=null){
      loggedInUser = user;
      print(loggedInUser.email);
    }
  }
  List userReviewList =[];
  @override
  void initState(){
    super.initState();
    getCurrentUser();
    fetchUserReviewDataList();

  }

  fetchUserReviewDataList() async{
    dynamic resultant = await DataBaseService(uid: _auth.currentUser!.uid).fetchUserReviewData(this.place.id);
    if (resultant == null){
      print("result is null");
    }else{
      setState(() {
        userReviewList = resultant;
        print("inside details page");
        print(userReviewList);
      });

    }
  }
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance.collection("placeDetails").snapshots();
//final Stream<QuerySnapshot> _reviewStream = FirebaseFirestore.instance.collection('reviewDetails').snapshots()
  TextEditingController reviewController = TextEditingController();
  @override
  Widget build(BuildContext context) {

    void _showSettingsPanel(Place place) {
      showModalBottomSheet(context: context, builder: (context) {
        return Container(
          padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
          child: SettingsForm( place: place),
        );
      });
    }

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

      body: StreamBuilder<QuerySnapshot>(
          stream: _stream,
          builder: (context, snapshot) {
            if(!snapshot.hasData){
              return Center(child: CircularProgressIndicator());
            }
            return ListView.builder(
                itemCount: 1,
                itemBuilder: (context, index){
                  return Column(
                    children: <Widget>[
                      SizedBox(height: 10.0),

                      buildSlider1(),
                      SizedBox(height: 20),
                      ListView(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        primary: false,
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        children: <Widget>[
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: <Widget>[
                              Container(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  this.place.name,
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 20,
                                  ),
                                  maxLines: 2,
                                  textAlign: TextAlign.left,
                                ),
                              ),
                              IconButton(
                                tooltip: "Add Review",
                                icon: Icon(
                                  Icons.rate_review,
                                ),
                                onPressed: () => _showSettingsPanel(this.place),
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
                                  this.place.description,
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
                              this.place.description,
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
                              this.place.description,
                              style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontSize: 15.0,
                              ),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10.0),
                          //todo: check data is being fetched from the DB


                        ],
                      ),
                      Text("Review Section : ", style: TextStyle(fontSize: 18, fontWeight:FontWeight.bold),),
                      buildSlider(),
                    ],

                  );

                });

          }
      ),

      floatingActionButton: FloatingActionButton(
        child: Icon(
          Icons.airplanemode_active,
        ),
        onPressed: () {
          showModalBottomSheet(context: context, builder: (context) {
            return Container(
              padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 60.0),
              child: PacakageForm( place: place),
            );
          });
        },
      ),
    );
  }

  buildSlider() {
    return Container(
      padding: EdgeInsets.only(left: 20),
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount: userReviewList.length,
        itemBuilder: (BuildContext context, int index) {
          Map review = userReviewList[index];

          return Padding(
            padding: EdgeInsets.only(right: 10.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10.0),
              child:ListTile(
                leading: Icon(
                    Icons.reviews
                ),
                title: Text(review['review']),
              ),

            ),
          );
        },
      ),
    );
  }
  buildSlider1(){
    return Container(

        child: Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(10.0),
            child: Image.asset(
              "assets/"+this.place.imgFile,
              height: 250.0,
              width: MediaQuery.of(context).size.width - 40.0,
              fit: BoxFit.cover,
            ),
          ),
        )


    );
  }
}
