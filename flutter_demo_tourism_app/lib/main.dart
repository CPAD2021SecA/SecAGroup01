import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/Service/Auth_Service.dart';
import 'package:flutter_demo_tourism_app/screens/main_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';

import 'package:firebase_core/firebase_core.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    // Replace with actual values
    // options: FirebaseOptions(
    //   apiKey: "AIzaSyB9W6YNxq5T05L3Oh4qnd8cnR1Qh1jexVo",
    //   appId: "1:157881208388:web:ece8cb4c4945119c9f3611",
    //   messagingSenderId: "157881208388",
    //   projectId: "take-a-tour-56291",
    // ),
  );

  runApp(TourApp());
}
// void main() => runApp(FlashChat());
class TourApp extends StatefulWidget {
  const TourApp({Key? key}) : super(key: key);

  @override
  _TourAppState createState() => _TourAppState();
}

class _TourAppState extends State<TourApp> {
  String currentPage = WelcomeScreen.id;


  AuthClass authClass = AuthClass();
  @override
  void initState(){
    super.initState();
    checklogin();
  }

  void checklogin() async{
  String? token = await authClass.getToken();
  if (token!=null){
    setState(() {
      currentPage = MainScreen.id;
    });
  }
  }
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: currentPage,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}

