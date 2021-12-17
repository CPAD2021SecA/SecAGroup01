
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/Service/Auth_Service.dart';
import 'package:flutter_demo_tourism_app/Service/DataBase_Service.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);
  static const String id = 'user_profile';

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile>
    with SingleTickerProviderStateMixin {
  bool _status = true;
  final FocusNode myFocusNode = FocusNode();

  AuthClass authClass = new AuthClass();
  final _auth = FirebaseAuth.instance;

  @override
  void initState(){
    super.initState();
    fetchUserBookingData();
    //fetchPacakgeDataWithPID();

  }
  List bookingList = [];
  List packList = [];

  fetchUserBookingData() async{
    dynamic resultant = await DataBaseService(uid: _auth.currentUser!.uid).fetchUserBookingData(_auth.currentUser!.uid);
      setState(() {
        bookingList = resultant;
        print("inside details page");
        print(bookingList);
        fetchPacakgeDataWithPID();
      });

  }

  fetchPacakgeDataWithPID() async{
    dynamic resultant = await DataBaseService(uid: _auth.currentUser!.uid).fetchPacakgeDataWithPID(bookingList);
    if (resultant == null){
      print("result is null");
    }else{

      setState(() {
        packList = resultant;
        print("inside details page");
        print(packList);
      });


    }
  }

  @override
  Widget build(BuildContext context) {
    String? userEmail = authClass.auth.currentUser!.email;
    return new Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.amber,
        title: Text('Profile'),
        elevation: 2.0,

      ),


      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CircleAvatar(
                backgroundColor: Colors.amber,
                radius: 50.0,
                child: new Icon(
                  Icons.person,
                  size: 45.0,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 40.0),
              Text(
                'User Name',
                style: TextStyle(

                    fontSize: 15.0,

                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(
                height: 10.0,
              ),

              Text(
                userEmail!,

                style: TextStyle(
                    fontSize: 15.0
                ),

              ),

              // TextField(
              //   decoration: InputDecoration(
              //       labelStyle: TextStyle(
              //           fontSize: 10.0
              //       )
              //   ),
              //   enabled: !_status,
              //   autofocus: !_status,
              // ),
              SizedBox(height: 16.0),
              Text(
                'Bookings',
                style: TextStyle(

                    fontSize: 16.0,

                  fontWeight: FontWeight.bold,
                ),
              ),
              buildSlider(),
              // Column(
              //   children: [
              //     ListTile(
              //       title: Text('Title of Booking'),
              //       subtitle: Text('Additional Info'),
              //       trailing: Icon(Icons.chevron_right),
              //     ),
              //     ListTile(
              //       title: Text('Title of Booking'),
              //       subtitle: Text('Additional Info'),
              //       trailing: Icon(Icons.chevron_right),
              //     ),
              //     ListTile(
              //       title: Text('Title of Booking'),
              //       subtitle: Text('Additional Info'),
              //       trailing: Icon(Icons.chevron_right),
              //     )
              //   ],
              // )
            ],
          ),
        ),
      ),
    );
  }

  buildSlider() {
    return Container(
      height: 250.0,
      child: ListView.builder(
        scrollDirection: Axis.vertical,
        primary: false,
        itemCount: packList.length,
        itemBuilder: (BuildContext context, int index) {
          Map pack = packList[index];

          return ListTile(

            title: Text('Pack Name : '+pack['packName']),
            subtitle: Text('Pack price: '+ pack['packPrice'].toString() ),

          );
        },
      ),
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the Widget is disposed
    myFocusNode.dispose();
    super.dispose();
  }

  Widget _getActionButtons() {
    return Padding(
      padding: EdgeInsets.only(left: 25.0, right: 25.0, top: 45.0),
      child: new Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.start,
        children: <Widget>[
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(right: 10.0),
              child: Container(
                  child: new RaisedButton(

                    child: new Text("Save"),
                    textColor: Colors.white,
                    color: Colors.green,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),

            ),
            flex: 2,
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Container(
                  child: new RaisedButton(

                    child: new Text("Cancel"),
                    textColor: Colors.white,
                    color: Colors.red,
                    onPressed: () {
                      setState(() {
                        _status = true;
                        FocusScope.of(context).requestFocus(new FocusNode());
                      });
                    },
                    shape: new RoundedRectangleBorder(
                        borderRadius: new BorderRadius.circular(20.0)),
                  )),

            ),
            flex: 2,
          ),
        ],
      ),
    );
  }

  Widget _getEditIcon() {
    return new GestureDetector(
      child: new Icon(
        Icons.edit,
        color: Colors.white,
        size: 25.0,
      ),
      onTap: () {
        setState(() {
          _status = false;
        });
      },
    );
  }
}

