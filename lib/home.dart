import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'ask-page.dart';
import 'request.dart';
import 'user-data.dart';
import 'request-card.dart';
import 'profile-page.dart';

List<Widget> _requestCards = [];
List<Request> _requests = [];

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
    void initState() {
    _load();
    super.initState();
  }

  _load() {
    db.collection('requests').where('senderId', isNotEqualTo: UserData.uid).where('accepted', isEqualTo: false).snapshots().listen((docs){
      _requests = docs.docs.map((e) => Request.data(e)).toList();
      _requests.sort((a, b) => b.sentDate.compareTo(a.sentDate));
      //_requests.removeWhere((e) => e.tags.every((element) => !UserData.skills.contains(element)));
      _requestCards = _requests.map((e) => Container(key: UniqueKey(), child: RequestCard(e))).toList();
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(15.0),
          child: Column(
            children: <Widget>[
              Row(
                children: [
                  Expanded(child: Container()),
                  GestureDetector(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (_) => ProfilePage()));
                    },
                    child: CircleAvatar(
                      radius: 28,
                      child: Icon(Icons.person, size: 32),
                    ),
                  )
                ],
              ),
              Container(height: 15),
              Text("Recent Requests", style: Theme.of(context).textTheme.headline1),
              Container(height: 15),
              Expanded(
                child: ListView(
                  children: _requestCards,
                ),
              ),
              
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Container(
        decoration: new BoxDecoration(
          boxShadow: [
            new BoxShadow(
              color: Colors.black12,
              blurRadius: 8,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              primary: Color.fromRGBO(70, 10, 160, 1)
            ),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(builder: (_) => AskPage()));
            },
            child: Container(
              height: 40,
              width: 100,
              child: Center(
                child: Text("Ask")
              ),
            ),
          ),
        ),
      ),
    );
  }
}