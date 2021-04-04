import 'package:cloud_firestore/cloud_firestore.dart';
import 'user-data.dart';

class Request {
  FirebaseFirestore db = FirebaseFirestore.instance;

  String id = '';
  String title = '';
  String description = '';
  int time = 10;
  int tip = 0;
  bool tutoring = false;
  List<String> tags = [];
  bool active = true;
  bool accepted = false;
  DateTime sentDate = DateTime.now();
  DateTime acceptedDate = DateTime.now();
  int total = 10;
  String senderId = '';
  String tutorId = '';

  Request();

  Request.data(DocumentSnapshot data) {
    id = data.id;
    title = data.data()['title'] ?? title;
    description = data.data()['description'] ?? description;
    time = data.data()['time'] ?? time;
    tip = data.data()['tip'] ?? tip;
    tutoring = data.data()['tutoring'] ?? tutoring;
    tags = List<String>.from(data.data()['tags'] ?? tags);
    active = data.data()['active'] ?? active;
    accepted = data.data()['accepted'] ?? accepted;
    sentDate = DateTime.fromMillisecondsSinceEpoch((data.data()['sentDate'].seconds ?? (sentDate.millisecondsSinceEpoch / 1000)) * 1000);    
    total = data.data()['total'] ?? total;
    senderId = data.data()['senderId'] ?? senderId;
    tutorId = data.data()['tutorId'] ?? tutorId;
  }

  create() async {
    DocumentReference newDoc = await db.collection('requests').add({
      'title' : title,
      'description' : description,
      'time' : time,
      'tip' : tip,
      'tutoring' : tutoring,
      'tags' : tags,
      'active' : active,
      'accepted' : accepted,
      'sentDate' : sentDate,
      'acceptedDate' : acceptedDate,
      'senderId' : senderId,
      'tutorId' : tutorId,
      'total': total
    });
    this.id = newDoc.id;
  }

  setData() {
    if (id.isNotEmpty) {
      db.collection('requests').doc(id).set({
        'title' : title,
        'description' : description,
        'time' : time,
        'tip' : tip,
        'tutoring' : tutoring,
        'tags' : tags,
        'active' : active,
        'accepted' : accepted,
        'sentDate' : sentDate,
        'acceptedDate' : acceptedDate,
        'senderId' : senderId,
        'tutorId' : tutorId,
        'total' : total
      });
    } else {
      create();
    }
  }

  delete() {
    db.collection('requests').doc(id).delete();
    db.collection('messages').doc(id).delete();
  }

  completion() {
    int _points = UserData.points ?? 0;
    _points -= total;
    UserData.points = _points;
    UserData.setData();
    db.collection('users').doc(tutorId).update({
      'points' : FieldValue.increment(total)
    });
    this.active = false;
    setData();
  }
}