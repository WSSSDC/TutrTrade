import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'dummy-values.dart';
import 'custom-chip.dart';
import 'user-data.dart';
import 'request.dart';

class AskPage extends StatefulWidget {
  @override
  _AskPageState createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  double _sliderValue = 0;
  double _tip = 0;
  bool _isTutoring = false;
  List<Widget> _chips = [];
  Request request = Request();

  @override
  void initState() {
    Dummy.subjects.forEach((e) => _chips.add(CustomChip(onChanged: (v) => _onChipChange(v, e), title: e)));
    setState(() {});
    super.initState();
  }

  _onChipChange(newValue, title) {
    if(newValue) request.tags.add(title);
    if(!newValue) request.tags.remove(title);
  }

  _sendRequest() {
    request.senderId = UserData.uid;
    request.sentDate = DateTime.now();
    request.time = _sliderValue.toInt() + 10;
    request.tutoring = _isTutoring;
    request.total = _cost();
    request.title = _titleController.text;
    request.description = _descriptionController.text;
    request.setData();
  }

  int _cost() {
    return _sliderValue.toInt() + (_isTutoring ? 50 : 0) + _tip.toInt() + 10;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Ask a question", style: Theme.of(context).textTheme.headline1),
              Container(height: 15),
              Text("Title", style: Theme.of(context).textTheme.subtitle1),
              Card(
                color: Color.fromRGBO(16, 20, 25, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    child: TextField(
                      controller: _titleController,
                      maxLines: 1,
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Description", style: Theme.of(context).textTheme.subtitle1),
              Card(
                color: Color.fromRGBO(16, 20, 25, 1),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    child: TextField(
                      controller: _descriptionController,
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              Container(height: 15),
              Text("Estimated Time", style: Theme.of(context).textTheme.subtitle1),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _sliderValue,
                      max: 170,
                      onChanged: (v){setState(() => _sliderValue = v);},
                    ),
                  ),
                  Text('~' + (_sliderValue + 10).toInt().toString() + ' min', style: TextStyle(color: Colors.white))
                ],
              ),
              Container(height: 15),
              Text("Tip", style: Theme.of(context).textTheme.subtitle1),
              Row(
                children: [
                  Expanded(
                    child: Slider(
                      value: _tip,
                      max: 200,
                      onChanged: (v){setState(() => _tip = v);},
                    ),
                  ),
                  Text(_tip.toInt().toString(), style: TextStyle(color: Colors.white)),
                  Container(width: 5),
                  SvgPicture.asset(
                    'assets/coin.svg',
                    color: Colors.white,
                  ),
                ],
              ),
              /*Row(
                children: [
                  Text("Tutoring Session", style: Theme.of(context).textTheme.subtitle1),
                  Expanded(child: Container()),
                  Checkbox(
                    activeColor: Colors.white,
                    checkColor: Colors.white,
                    focusColor: Colors.white,
                    value: _isTutoring, 
                    onChanged: (v){setState(() => _isTutoring = v);}
                  )
                ],
              ),*/
              Text("Tags", style: Theme.of(context).textTheme.subtitle1),
              Wrap(
                children: _chips,
              ),
              Expanded(child: Container()),
              GestureDetector(
                onTap: () {
                  _sendRequest();
                  Navigator.pop(context);
                },
                child: Card(
                  color: Colors.deepPurple[700],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    width: width-30,
                    height: 40,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Post", style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w500)),
                        Container(width: 15),
                        Text(_cost().toString(), style: TextStyle(color: Colors.red, fontSize: 20, fontWeight: FontWeight.w500)),
                        Container(width: 3),
                        SvgPicture.asset(
                          'assets/coin.svg',
                          color: Colors.red,
                          height: 18,
                        ),
                      ],
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}