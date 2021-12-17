import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_demo_tourism_app/screens/main_screen.dart';

class DataBaseService{
  final String uid;
  DataBaseService({required this.uid});
  final CollectionReference placeCollection = FirebaseFirestore.instance.collection('placeDetails');
  final CollectionReference userCollection = FirebaseFirestore.instance.collection('userDetails');
  final CollectionReference reviewCollection = FirebaseFirestore.instance.collection('reviewDetails');
  final CollectionReference bookingCollection = FirebaseFirestore.instance.collection('bookingDetails');
  Future updateUserData(String? userName, String email, String placeBooked) async{
    return await userCollection.doc(uid).set({
      'userName' : userName,
      'email' : email,
      'placeBooked':placeBooked
    });
  }

  Stream<QuerySnapshot> get userData {
    return userCollection.snapshots();
  }
  Future storeUserReviewData( int placeID, String review) async{
    return await reviewCollection.doc().set({
      'placeID' : placeID,
      'review' : review,

    });
    
  }


  Future fetchUserReviewData( int placeID) async{
    List reviewdata = [];
    final reference = FirebaseFirestore.instance.collection("reviewDetails");
    await reference.get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        if (element.data()['placeID'] == placeID) {
          reviewdata.add(element.data());
        }
      });
    });

    return reviewdata;
  }
  Future storeUserBookingData( int PID, String userID, ) async{
    return await bookingCollection.doc().set({
      'PID' : PID,
      'userID' : userID,

    });

  }
  Future fetchUserBookingData( String userID) async{
    List bookdata = [];
    final reference = FirebaseFirestore.instance.collection("bookingDetails");
    await reference.get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        if (element.data()['userID'] == userID) {
          bookdata.add(element.data()['PID']);
        }
      });
    });

    return bookdata;
  }

  Future fetchPacakgeData( int placeID) async{
    List packdata = [];
    final reference = FirebaseFirestore.instance.collection("pacakageDetails");
    await reference.get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        if (element.data()['placeID'] == placeID) {
          packdata.add(element.data());
        }
      });
    });

    return packdata;
  }
  Future fetchPacakgeDataWithPID( List<dynamic> PID) async{
    List packdata = [];
    final reference = FirebaseFirestore.instance.collection("pacakageDetails");
    await reference.get().then((querySnapshot){
      querySnapshot.docs.forEach((element) {
        if ( PID.contains(element.data()['PID'])) {
          packdata.add(element.data());
        }
      });
    });

    return packdata;
  }

  builder(Map<String, dynamic> data, String id) {

  }

  // List<Place>? _placeListFromSnapshot(QuerySnapshot snapshot) {
  //   return snapshot.docs.map((doc) {
  //     return Place(
  //         name : doc.get('placeName'),
  //         description: doc.get('placeName'),
  //         imgFile: doc.get("name") )
  //   });
  // }
}