import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'request-page.dart';

class RequestCard extends StatefulWidget {
  @override
  _RequestCardState createState() => _RequestCardState();
}

class _RequestCardState extends State<RequestCard> {
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (_) => RequestPage()));
      },
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 2, 0, 2),
        child: Card(
          color: Color.fromRGBO(16, 20, 25, 1),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(25.0),
          ),
          shadowColor: Colors.black,
          child: Container(
            height: 150,
            width: width - 30,
            child: Padding(
              padding: const EdgeInsets.all(15.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("Help with calculus homework", style: Theme.of(context).textTheme.subtitle1),
                    ],
                  ),
                  Container(height: 5),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("30 min", style: TextStyle(
                        color: Colors.white54
                      )),
                    ],
                  ),
                  Expanded(child: Container()),
                  Row(
                    children: [
                      SvgPicture.asset(
                        'assets/calculator.svg',
                        color: Colors.white,
                      ),
                      Expanded(child: Container()),
                      Text("100", style: TextStyle(color: Colors.green)),
                      Container(width: 3),
                      SvgPicture.asset(
                        'assets/coin.svg',
                        color: Colors.green,
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}