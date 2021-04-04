import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'request.dart';
import 'dummy-values.dart';
import 'user-data.dart';
import 'custom-chip.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<Widget> _chips = [];
  List<Request> _requests = [];
  List<Request> _fromUser = [];
  List<Request> _toUser = [];
  List<Widget> _requestTiles = [];
  FirebaseFirestore db = FirebaseFirestore.instance;

  @override
  void initState() {
    Dummy.subjects.forEach((e) => _chips.add(
      CustomChip(
        selected: UserData.skills.contains(e),
        onChanged: (v) => _onSkillChange(v, e), title: e)
    ));
    _load();
    setState(() {});
    super.initState();
  }

  _onSkillChange(newValue, title) {
    if(newValue) UserData.skills.add(title);
    if(!newValue) UserData.skills.remove(title);
    UserData.setData();
  }

  _load() {
    _requests = [];
    _loadFromUser();
    _loadToUser();
  }

  _updateRequests() {
    _requests = _fromUser + _toUser;
    _requests.sort((a, b) => b.sentDate.compareTo(a.sentDate));
    _requestTiles = _requests.map((e) => Container(key: Key(e.id), child: RequestTile(e))).toList();
    setState(() {});
  }

  _loadFromUser() {
    db.collection('requests').where('senderId', isEqualTo: UserData.uid).snapshots().listen((docs){
      _fromUser = docs.docs.map((e) => Request.data(e)).toList();
      _updateRequests();
   });
  }
  
  _loadToUser() {
    db.collection('requests').where('tutorId', isEqualTo: UserData.uid).snapshots().listen((docs){
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
              Center(child: CircleAvatar(
                radius: 50,
                child: SvgPicture.asset('assets/profile.svg', color: Colors.white, height: 55),
              )),
              Container(height: 10),
              Text("Connor Wilson", style: Theme.of(context).textTheme.headline1),
              Container(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(UserData.points.toString(), style: Theme.of(context).textTheme.headline1),
                  Container(width: 5),
                  SvgPicture.asset('assets/coin.svg', color: Colors.white, height: 22)
                ],
              ),
              Container(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Skills", style: Theme.of(context).textTheme.subtitle1)
                ),
              ),
              Wrap(
                children: _chips,
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(15, 10, 15, 0),
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Request History", style: Theme.of(context).textTheme.subtitle1)
                ),
              ),
              Expanded(
                child: ListView(
                  children: _requestTiles,
                )
              )
            ],
          ),
        ),
      ),
    );
  }
}


class RequestTile extends StatelessWidget {
  RequestTile(this.request);
  final Request request;
  @override
  Widget build(BuildContext context) {
    Color coinColor = request.senderId == UserData.uid ? Colors.red.withOpacity(0.5) : Colors.green.withOpacity(0.5);
    coinColor = request.active ? Colors.white54 : coinColor;
    return ListTile(
      title: Text(request.title, style: TextStyle(color: Colors.white54)),
      subtitle: Row(
        children: [
          Text(request.total.toString(), style: TextStyle(color: coinColor, fontSize: 20)),
          Container(width: 3),
          SvgPicture.asset('assets/coin.svg', color: coinColor, height: 18)
        ],
      ),
      trailing: !request.accepted ? MaterialButton(
        onPressed: request.delete,
        child: Icon(Icons.delete_forever, color: Colors.red,),
      ) : null
    );
  }
}