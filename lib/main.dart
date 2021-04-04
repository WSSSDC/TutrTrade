import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_core/firebase_core.dart';
import 'user-data.dart';
import 'home.dart';
import 'messages-page.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initialization,
      builder: (context, snapshot) {
        if(snapshot.connectionState == ConnectionState.done)
        return MaterialApp(
          theme: ThemeData(
            //brightness: Brightness.dark,
            backgroundColor: Colors.black54,
            primarySwatch: Colors.purple,
            unselectedWidgetColor: Colors.white,
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
        return MaterialApp(
          home: Scaffold(
            body: Center(
              child: CircularProgressIndicator.adaptive(),
            ),
          ),
        );
      }
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _currentNavIndex = 0;
  Widget _currentPage = Home();
  List<Widget> _pages = [Home(), MessagesPage()];
 
  @override
  void initState() {
    setState(() => UserData.getData());
    super.initState();
  }

  _onNavBarItemTap(int index) {
    setState((){
      _currentNavIndex = index;
      _currentPage = _pages[index];
    });
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
              'assets/chat.svg',
              color: _currentNavIndex == 1 ? Colors.purpleAccent : Colors.white,
            ),
            label: ''
          ),
        ],
      ),
      body: _currentPage,
    );
  }
}