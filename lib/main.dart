import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'profile-page.dart';
import 'request-card.dart';
import 'ask-page.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        backgroundColor: Colors.black54,
        textTheme: TextTheme(
          headline1: TextStyle(
            fontSize: 25,
            fontWeight: FontWeight.bold,
            color: Colors.white
          ),
          subtitle1: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
            color: Colors.white
          ),
        )
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentNavIndex = 0;

  _onNavBarItemTap(int index) {
    setState(() => _currentNavIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Colors.black,
        onTap: _onNavBarItemTap,
        unselectedItemColor: Colors.white,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        currentIndex: _currentNavIndex,
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/home.svg',
              color: _currentNavIndex == 0 ? Colors.purpleAccent : Colors.white,
            ),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/calendar.svg',
              color: _currentNavIndex == 1 ? Colors.purpleAccent : Colors.white,
            ),
            label: ''
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/history.svg',
              color: _currentNavIndex == 2 ? Colors.purpleAccent : Colors.white,
            ),
            label: ''
          ),
        ],
      ),
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
                    ),
                  )
                ],
              ),
              Container(height: 15),
              Text("Recent Requests", style: Theme.of(context).textTheme.headline1),
              Container(height: 15),
              Expanded(
                child: ListView(
                  children: [
                    RequestCard(),
                    RequestCard(),
                    RequestCard(),
                    RequestCard(),
                  ],
                ),
              ),
              Container(
                decoration: new BoxDecoration(
                  boxShadow: [
                    new BoxShadow(
                      color: Colors.black12,
                      blurRadius: 8,
                    ),
                  ],
                ),
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
              )
            ],
          ),
        ),
      ),
    );
  }
}