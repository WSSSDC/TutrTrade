import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_svg/svg.dart';
import 'user-data.dart';
import 'request.dart';

class ChatPage extends StatefulWidget {
  ChatPage(this.request);
  final Request request;

  @override
  _ChatPageState createState() => _ChatPageState(request);
}

class _ChatPageState extends State<ChatPage> {
  _ChatPageState(this.request);
  final Request request;
  TextEditingController _messageController = TextEditingController();
  FirebaseFirestore db = FirebaseFirestore.instance;
  List<Map<String,dynamic>> _messages = [];
  List<Widget> _messageTiles = [];

  @override
  void initState() {
    _load();
    super.initState();
  }

  _load() {
     db.collection('messages').doc(request.id).collection('messages').snapshots().listen((docs){
       _messages = docs.docs.map((e) => e.data()).toList();
       _messages.sort((a,b) => a['sent'].compareTo(b['sent']));
       _messageTiles = _messages.map((e) => Container(key: UniqueKey(), child: Message(message: e['message'], isFromUser: (UserData.uid == e['from'])))).toList();
      setState((){});
     });
  }

  _send() {
    String message = _messageController.text;
    db.collection('messages').doc(request.id).collection('messages').add({
      'message' : message,
      'sent' : DateTime.now(),
      'from' : UserData.uid
    });
    _messageController.clear();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(16, 20, 25, 1),
        title: CircleAvatar(
          child: Text("VV", style: TextStyle(color: Colors.black))
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: SvgPicture.asset('assets/call.svg', color: Colors.white),
          ),
        ],
      ),
      backgroundColor: Colors.black,
      body: Column(
        children: [
          Expanded(
            child: ListView(
              children: <Widget>[Container(height: 5)] + _messageTiles,
            )
          ),
          Container(
            decoration: BoxDecoration(
              color: Color.fromRGBO(40, 40, 40, 1),
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(15),
                topRight: Radius.circular(15)
              )
            ),
            height: 115,
            width: width,
            child: Column(
              children: [
                Container(height: 3),
                Row(
                  children: [
                    Spacer(),
                    Container(
                      width: width - 40,
                      child: Card(
                        color: Color.fromRGBO(16, 20, 25, 1),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                          child: Container(
                            child: TextField(
                              controller: _messageController,
                              style: TextStyle(fontSize: 12),
                              decoration: InputDecoration(
                                hintText: 'Message...',
                                hintStyle: TextStyle(color: Colors.white54),
                                isDense: true,
                                border: InputBorder.none
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: _send,
                      child: SvgPicture.asset('assets/send.svg', height: 34)
                    ),
                    Container(width: 3)
                  ],
                ),
                request.senderId == UserData.uid ?
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        request.completion();
                        Navigator.pop(context);
                      },
                      child: Container(
                        width: width,
                        height: 40,
                        child: Card(
                          color: Colors.green,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                            child: Container(
                              child: Center(child: Text("Mark as done", style: TextStyle(color: Colors.white, fontSize: 18))),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ) : Container(),
                Expanded(child: Container())
              ],
            ),
          )
        ],
      ),
    );
  }
}

class Message extends StatelessWidget {
  Message({this.message = '', this.isFromUser = true});
  final String message;
  final bool isFromUser;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isFromUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          height: 35,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Colors.white,
            child: Row(
              children: [
                Container(width: 8),
                Center(child: Text(message)),
                Container(width: 8),
              ],
            )
          ),
        )
      ],
    );
  }
}