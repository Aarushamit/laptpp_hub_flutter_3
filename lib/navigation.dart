import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:flutter/material.dart';

import 'app_screens/home.dart';
import 'app_screens/updateScreen.dart';

class BottomNavigation extends StatelessWidget{
  @override
  Widget build(BuildContext context){
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: _BottomNavigationWidget()
    );
  }
}

class _BottomNavigationWidget extends StatefulWidget{
  @override
  _BottomNavigationWidgetState createState() => _BottomNavigationWidgetState();
}

class _BottomNavigationWidgetState extends State<_BottomNavigationWidget> {
  var _currentIndex = 0;
  List tabs = [Container(child: Home()), Container(child: UpdatesScreen())];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavyBar(
          curve: Curves.easeInOut,
          selectedIndex: _currentIndex,
          onItemSelected: (index) {
            setState(() {
              _currentIndex = index;
            });
          },
          items: <BottomNavyBarItem>[
            BottomNavyBarItem(
                icon: Icon(Icons.laptop),
                title: Text("SUGGESTIONS"),
                activeColor: Colors.grey,
                inactiveColor: Colors.black),
            BottomNavyBarItem(
                icon: Icon(Icons.update),
                title: Text("UPDATES"),
                activeColor: Colors.black54,
                inactiveColor: Colors.grey),
          ]),
      body: tabs[_currentIndex]
    );
  }

}