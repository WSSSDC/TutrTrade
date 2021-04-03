import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class AskPage extends StatefulWidget {
  @override
  _AskPageState createState() => _AskPageState();
}

class _AskPageState extends State<AskPage> {
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    child: TextField(
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
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(15, 0, 15, 0),
                  child: Container(
                    child: TextField(
                      maxLines: null,
                      decoration: InputDecoration(
                        border: InputBorder.none
                      ),
                    ),
                  ),
                ),
              ),
              Expanded(child: Container()),
              Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20.0),
                ),
                child: Container(
                  width: width-30,
                  height: 40,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Post", style: TextStyle(fontSize: 18)),
                      Container(width: 15),
                      Text("200", style: TextStyle(color: Colors.red, fontSize: 18)),
                      Container(width: 3),
                      SvgPicture.asset(
                        'assets/coin.svg',
                        color: Colors.red,
                      ),
                    ],
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