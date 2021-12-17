
import 'package:flutter/material.dart';
import 'package:flutter_demo_tourism_app/Service/DataBase_Service.dart';
import 'package:flutter_demo_tourism_app/screens/main_screen.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class AuthClass {

  late UserCredential curUserCred;
  GoogleSignIn _googleSignIn = GoogleSignIn(
      scopes: [
        'email',
        'https://www.googleapis.com/auth/contracts.readonly',

      ]
  );
  FirebaseAuth auth = FirebaseAuth.instance;
  final storage = new FlutterSecureStorage();

  Future<void> googleSignIn(BuildContext context) async {
    try {
      GoogleSignInAccount? googleSignInAccount = await _googleSignIn.signIn();
      if (googleSignInAccount != null) {
        //gives authentication details such as access token, id tocken
        GoogleSignInAuthentication googleSignInAuthentication = await googleSignInAccount
            .authentication;

        AuthCredential credential = GoogleAuthProvider.credential(
            idToken: googleSignInAuthentication.idToken,
            accessToken: googleSignInAuthentication.accessToken
        );

        try {
          UserCredential userCredential = await auth.signInWithCredential(
              credential);

          storeTokenAndData(userCredential);
          Navigator.pushAndRemoveUntil(
              context, MaterialPageRoute(builder: (builder) => MainScreen()), (
              route) => false);
        } catch (e) {
          final snackbar = SnackBar(content: Text(e.toString()));
          ScaffoldMessenger.of(context).showSnackBar(snackbar);
        }
      } else {

      }
    } catch (e) {

    }
  }

  Future<void> storeTokenAndData(UserCredential userCredential) async {

    await storage.write(
        key: "token", value: userCredential.credential?.token.toString());
    await storage.write(
        key: "userCredential", value: userCredential.toString());
  }

  Future<String?> getToken() async {
    return await storage.read(key: "token");
  }

  Future<void> logout() async {
    try {
      await _googleSignIn.signOut();
      await auth.signOut();
      await storage.delete(key: "token");
    } catch (e) {

    }
  }

  Future registerWithEmailAndPassword(BuildContext context, String email, String password) async {
    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: email,
          password: password
      );
      User? user = userCredential.user;
      curUserCred = userCredential;
      await DataBaseService(uid: user!.uid);
      Navigator.pushNamed(context, MainScreen.id);
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } catch (e) {
      print(e);
    }
  }
  Future loginWithEmailAndPassword(BuildContext context, String email, String password) async{
    try {
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: email,
          password: password
      );
      curUserCred = userCredential;
      Navigator.pushNamed(context, MainScreen.id);

    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
      final snackBar = SnackBar(content: Text(e.toString()));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }
}