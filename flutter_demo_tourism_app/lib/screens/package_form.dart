


import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_demo_tourism_app/Service/Auth_Service.dart';
import 'package:flutter_demo_tourism_app/Service/DataBase_Service.dart';
import 'package:flutter_demo_tourism_app/constants.dart';


import 'main_screen.dart';

class PacakageForm extends StatefulWidget {
  final Place place;
  const PacakageForm({Key? key, required this.place,  }) : super(key: key);
  @override
  _PacakageFormState createState() => _PacakageFormState(place);
}

class _PacakageFormState extends State<PacakageForm> {
  late Place place;
  _PacakageFormState(this.place);
  final _formKey = GlobalKey<FormState>();

  AuthClass authClass = new AuthClass();
  final _auth = FirebaseAuth.instance;
  late User loggedInUser;
  void getCurrentUser () async {
    final user = await _auth.currentUser;
    if (user !=null){
      loggedInUser = user;
      print("hello");
      print(loggedInUser.email);
      print(loggedInUser.uid);
    }
  }
  @override
  void initState(){
    super.initState();
    getCurrentUser ();
    fetchPackageList();

  }
  List packageList = [];
  fetchPackageList() async{
    dynamic resultant = await DataBaseService(uid: _auth.currentUser!.uid).fetchPacakgeData(this.place.id);
    if (resultant == null){
      print("result is null");
    }else{
      setState(() {
        packageList = resultant;
        print("inside details page");
        print(packageList);
      });

    }
  }

  // form values
  late String _currentName;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Text(
              'Enter bank credentials and select pack ',
              style: TextStyle(fontSize: 15.0),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Enter Bank Name",
              ),
              // validator: (val) => val!.isEmpty ? 'Please enter feedback' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Enter Acc.No.",
              ),
              // validator: (val) => val!.isEmpty ? 'Please enter feedback' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            TextField(
              decoration: InputDecoration(
                labelText: "Enter IFSC Code",
              ),
              // validator: (val) => val!.isEmpty ? 'Please enter feedback' : null,
              onChanged: (val) => setState(() => _currentName = val),
            ),
            SizedBox(
              height: 10.0,
            ),
            buildSlider()
          ],
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
        itemCount: packageList.length,
        itemBuilder: (BuildContext context, int index) {
          Map pack = packageList[index];

          return ListTile(
            trailing: ElevatedButton(
              child: Text("Confirm Booking"),
              onPressed: () async{
                try{

                  var user = authClass.auth.currentUser!.uid;
                  print(user);
                  await DataBaseService(uid:user).storeUserBookingData(pack['PID'], user );
                  Navigator.pop(context);

                }catch(e){

                }
              },
            ),
            title: Text('Pack Name : '+pack['packName']),
            subtitle: Text('Pack price: '+ pack['packPrice'].toString() ),
          );
        },
      ),
    );
  }
}