import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'request.dart';
import 'user-data.dart';

class RequestPage extends StatefulWidget {
  RequestPage(this.request);
  final Request request;

  @override
  _RequestPageState createState() => _RequestPageState(request);
}

class _RequestPageState extends State<RequestPage> {
  _RequestPageState(this.request);
  final Request request;

  _accept() {
    request.tutorId = UserData.uid;
    request.accepted = true;
    request.acceptedDate = DateTime.now();
    request.setData();
    Navigator.pop(context);
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
              Text(request.title, style: Theme.of(context).textTheme.headline1),
              Container(height: 10),
              Text(request.description, style: Theme.of(context).textTheme.subtitle1),
              Container(height: 5),
              Text(request.time.toString() + ' min', style: TextStyle(
                color: Colors.white54,
                fontSize: 20
              )),
              Expanded(child: Container()),
              GestureDetector(
                onTap: _accept,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  child: Container(
                    width: width-30,
                    height: 50,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Accept", style: TextStyle(fontSize: 18)),
                        Container(width: 15),
                        Text(request.total.toString(), style: TextStyle(color: Colors.green, fontSize: 18)),
                        Container(width: 3),
                        SvgPicture.asset(
                          'assets/coin.svg',
                          color: Colors.green,
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