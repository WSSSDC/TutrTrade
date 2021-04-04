import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'user-data.dart';
import 'request.dart';
import 'chat-page.dart';

List<Widget> _messageTiles = [];

class MessagesPage extends StatefulWidget {
  @override
  _MessagesPageState createState() => _MessagesPageState();
}

class _MessagesPageState extends State<MessagesPage> {
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Request> _requests = [];
  List<Request> _fromUser = [];
  List<Request> _toUser = [];

  @override
  void initState() {
    _load();
    super.initState();
  }

  _load() async {
    _requests.clear();
    _loadFromUser();
    _loadToUser();
  }

  _updateRequests() {
    _requests = _fromUser + _toUser;
    _requests.sort((a, b) => b.sentDate.compareTo(a.sentDate));
    _messageTiles = _requests.map((e) => Container(key: Key(e.id), child: MessageTile(e))).toList();
    setState(() {});
  }

  _loadFromUser() {
    db.collection('requests').where('senderId', isEqualTo: UserData.uid).where('accepted', isEqualTo: true).where('active', isEqualTo: true).snapshots().listen((docs){
      _fromUser = docs.docs.map((e) => Request.data(e)).toList();
      _updateRequests();
   });
  }
  
  _loadToUser() {
    db.collection('requests').where('tutorId', isEqualTo: UserData.uid).where('active', isEqualTo: true).snapshots().listen((docs){
      _toUser = docs.docs.map((e) => Request.data(e)).toList();
      _updateRequests();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              Text("Messages", style: Theme.of(context).textTheme.headline1),
              Expanded(
                child: ListView(
                  children: _messageTiles,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}

class MessageTile extends StatefulWidget {
  MessageTile(this.request);
  final Request request;

  @override
  _MessageTileState createState() => _MessageTileState(request);
}

class _MessageTileState extends State<MessageTile> {
  _MessageTileState(this.request);
  final Request request;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChatPage(request)));
      },
      child: ListTile(
        leading: CircleAvatar(
          child: SvgPicture.asset('assets/profile.svg', color: Colors.white),
        ),
        title: Text(request.title),
        subtitle: Row(
          children: [
            Text(request.total.toString(), style: TextStyle(color: Colors.white54)),
            Container(width: 3),
            SvgPicture.asset('assets/coin.svg', color: Colors.white54, height: 15)
          ],
        ),
      ),
    );
  }
}