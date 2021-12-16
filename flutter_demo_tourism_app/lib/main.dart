import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/screens/main_screen.dart';
import 'screens/registration_screen.dart';
import 'screens/welcome_screen.dart';
import 'screens/login_screen.dart';

void main()  {

  runApp(TourApp());
}
class TourApp extends StatefulWidget {
  const TourApp({Key? key}) : super(key: key);

  @override
  _TourAppState createState() => _TourAppState();
}

class _TourAppState extends State<TourApp> {
  
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: WelcomeScreen.id,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        MainScreen.id: (context) => MainScreen(),
      },
    );
  }
}

