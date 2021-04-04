import 'package:cloud_firestore/cloud_firestore.dart';

class UserData {
  static String uid = 'qHIShRii16cHzOgBgKUw';
  static String first = 'Connor';
  static String last = 'Wilson';
  static List<String> skills = [];
  static int points = 0;
  static FirebaseFirestore db = FirebaseFirestore.instance;

  static setData() {
    db.collection('users').doc(uid).set({
      'first' : first,
      'last' : last,
      'skills' : skills,
      'points' : points
    });
  }

  static getData() {
    db.collection('users').doc(uid).snapshots().listen((doc){
      first = doc.data()['first'] ?? first;
      last = doc.data()['last'] ?? last;
      skills = List<String>.from(doc.data()['skills']) ?? skills;
      points = doc.data()['points'] ?? 0;
    });
  }
}