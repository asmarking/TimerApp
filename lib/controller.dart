import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:timer/savedtimers.dart';
import 'package:timer/timer.dart';

import 'clock.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<String> titles = ["Clock", "Timer", "Stopwatch", "Saved"];

  static List<Widget> _bodywidgetOptions = [];
  static List<BottomNavigationBarItem> NavbarItems = [
    BottomNavigationBarItem(
      icon: Icon(Icons.access_time_filled),
      label: "",
      backgroundColor: Colors.blue[100],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.timer),
      label: "",
      backgroundColor: Colors.blue[100],
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.timer_rounded),
      label: "",
      backgroundColor: Colors.blue[100],
    ),
  ];


  _MyHomePageState() {
    _bodywidgetOptions = <Widget>[
      FlutterAnalogClock(),
      TimerWidget(60),
      savedTimer(title: 'saved timers'),
    ];
  }

  void _incrementCounter() {
    setState(() {

      _counter++;
    });
  }

  int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    //
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: _bodywidgetOptions[_selectedIndex]
      ),

      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        showUnselectedLabels: true,
        backgroundColor: Colors.blue[100],
        items: NavbarItems,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.black,
        onTap: _onItemTapped,
      ),// This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}