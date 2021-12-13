import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/widgets/icon_badge.dart';
import 'package:flutter_demo_tourism_app/util/places.dart';
import 'package:flutter_demo_tourism_app/widgets/search_bar.dart';
import 'package:flutter_demo_tourism_app/screens/details.dart';
import 'home.dart';

// void main() {
//   runApp(const MainScreen());
// }
//
// class MainScreen extends StatelessWidget {
//   const MainScreen({Key? key}) : super(key: key);
//
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: MyHomePage(title: 'TakeATour'),
//     );
//   }
// }
 class MainScreen extends StatefulWidget {
   const MainScreen({Key? key}) : super(key: key);
   static  const  String id = 'main_screen';
   @override
   _MainScreenState createState() => _MainScreenState();
 }

 class _MainScreenState extends State<MainScreen> {
   @override
   Widget build(BuildContext context) {
     return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'TakeATour'),
    );
   }
 }



