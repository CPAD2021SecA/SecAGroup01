
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/Service/Auth_Service.dart';
import 'package:flutter_demo_tourism_app/Service/DataBase_Service.dart';
import 'package:flutter_demo_tourism_app/constants.dart';
import 'package:flutter_demo_tourism_app/screens/details.dart';
import 'package:provider/provider.dart';

import 'main_screen.dart';

class SettingsForm extends StatefulWidget {
  final Place place;
  const SettingsForm({Key? key, required this.place,  }) : super(key: key);
  @override
  _SettingsFormState createState() => _SettingsFormState(place);
}

class _SettingsFormState extends State<SettingsForm> {
  late Place place;
  _SettingsFormState(this.place);
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
  }
//final user = Provider.of<User>(context);
  //String loggedInUserID
  final List<String> stars = ['0', '1', '2', '3', '4', '5'];
  
  // form values
  late String _currentName;
  late String _currentStars = '0';




  @override
  Widget build(BuildContext context) {

    return Form(
      key: _formKey,
      child: Column(
        children: <Widget>[
          Text(
            'Submit your valuable feedback here.',
            style: TextStyle(fontSize: 18.0),
          ),
          SizedBox(height: 20.0),
          TextField(
            decoration: textInputDecoration,
            // validator: (val) => val!.isEmpty ? 'Please enter feedback' : null,
            onChanged: (val) => setState(() => _currentName = val),
          ),
          SizedBox(height: 10.0),
          DropdownButtonFormField(
            value: _currentStars,
            decoration: textInputDecoration,
            items: stars.map((star) {
              return DropdownMenuItem(
                value: star,
                child: Text('$star stars'),
              );
            }).toList(),
            onChanged: (val) => setState(() => _currentStars = val as String ),
          ),
          SizedBox(height: 10.0),
          ElevatedButton(
              // color: Colors.orange[400],
              child: Text(
                'Submit',
                style: TextStyle(color: Colors.black),
              ),
              onPressed: () async {
                  try{
                    //var signInMethod = authClass.auth.fetchSignInMethodsForEmail();
                    var user = authClass.auth.currentUser!.uid;
                    print(user);
                    await DataBaseService(uid:user).storeUserReviewData(this.place.id,_currentName );
                    Navigator.pop(context);

                  }catch(e){

                  }
              }
          ),
        ],
      ),
    );
  }
}