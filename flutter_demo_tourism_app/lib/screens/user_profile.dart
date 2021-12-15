
import 'package:flutter/material.dart';

class UserProfile extends StatefulWidget {
  const UserProfile({Key? key}) : super(key: key);

  @override
  _UserProfileState createState() => _UserProfileState();
}

class _UserProfileState extends State<UserProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
        icon: Icon(
        Icons.arrow_back,
        ),
        onPressed: () {
        Navigator.pop(context);
        },
      ),
      title: Text("User Profile"),


    ),
    );
  }
}
