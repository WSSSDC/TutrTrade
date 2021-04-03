import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class RequestPage extends StatefulWidget {
  @override
  _RequestPageState createState() => _RequestPageState();
}

class _RequestPageState extends State<RequestPage> {
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
              Text("Help with calculus homework", style: Theme.of(context).textTheme.headline1),
              Container(height: 10),
              Text("You think of the question as a category to narrow down the skill set you need to solve the problem. Then, try something and see if it gets you there. Things come with practice, and you should be practicing as much as you can to have a thorough understanding of why the method works for this problem. Read the textbook, search online vids. Don’t go only for the how when it comes to answering questions, go for the why. That’s the best advice to succeed in math (or anything) in general. Minimize what you have to memorize and maximize what you intuitively know.", style: Theme.of(context).textTheme.subtitle1),
              Container(height: 5),
              Text("30 min", style: TextStyle(
                color: Colors.white54,
                fontSize: 20
              )),
              Expanded(child: Container()),
              Card(
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
                      Text("200", style: TextStyle(color: Colors.green, fontSize: 18)),
                      Container(width: 3),
                      SvgPicture.asset(
                        'assets/coin.svg',
                        color: Colors.green,
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