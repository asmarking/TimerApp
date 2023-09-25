import 'dart:math';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:timer/authentication.dart';
import 'package:timer/savedtimers.dart';
import 'package:timer/controller.dart';
import 'dart:async';

import 'clock.dart';

class TimerWidget extends StatefulWidget {
  @override
  TimerWidget(this.timerDuration);
  int timerDuration;
  _TimerWidgetState createState() => _TimerWidgetState(timerDuration);
}
class _TimerWidgetState extends State<TimerWidget> {
  // Timer duration (in seconds)
  int _timerDuration = 5000; // Example: 60 seconds

  // Variable to hold the current time remaining
  int _currentTime = 0;

  // Timer object
  Timer? _timer;




  _TimerWidgetState(this._timerDuration){


  }

  // Function to be executed when the timer expires
  void _onTimerComplete() {
    // Implement actions to perform when the timer expires
    print("Timer complete!");
  }

  // Function to start the timer
  void _startTimer() {

    // Initialize the timer with the specified duration
    _timer = Timer.periodic(Duration(seconds: 1), (Timer timer) {
      // Update the time remaining
      setState(() {
        _currentTime = _timerDuration - timer.tick;
      });

      // Check if the timer has completed
      if (timer.tick >= _timerDuration) {
        timer.cancel(); // Cancel the timer
        _onTimerComplete(); // Execute the timer completion function
      }
    });
  }

  // Function to stop the timer
  void _stopTimer() {
    if (_timer != null && _timer!.isActive) {
      _timer!.cancel();
      setState(() {
        _currentTime = 0;
      });
    }
  }

  @override
  void dispose() {
    // Dispose the timer when the widget is removed from the widget tree
    _timer?.cancel();
    super.dispose();
  }

  void upTimer() {
    setState(() {
      _timerDuration++;
    });
  }
  void downTimer() {
    setState(() {
      _timerDuration--;
    });
  }


  FirebaseFirestore db = FirebaseFirestore.instance;

  String title = "unknown";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Timer Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextField(
              obscureText: false,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Timer Title',
              ),
              onChanged: (String newEntry) {
                title = newEntry;
              },
            ),
            SizedBox(height: 100,),
            Text(
              'Current Timer Duration: $_timerDuration seconds',
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [

                Text(
                  'Time Remaining: $_currentTime seconds',
                  style: TextStyle(fontSize: 20),
                ),
                Column(
                  children: [
                    ElevatedButton(
                      onPressed: upTimer,
                      child: Icon(Icons.arrow_drop_up),
                    ),
                    ElevatedButton(
                      onPressed: downTimer,
                      child: Icon(Icons.arrow_drop_down),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _startTimer,
              child: Text('Start Timer'),
            ),
            ElevatedButton(
              onPressed: _stopTimer,
              child: Text('Stop Timer'),
            ),
            ElevatedButton(
              onPressed: saveTimer,
              child: Text('Save Timer'),
            ),
          ],
        ),
      ),
    );
  }

  void saveTimer() {
    final Map<String, Object> timerMap = {
      "title": title,
      "duration": _timerDuration,
    };

    db.collection("users").doc(AuthenticationHelper().uid).collection("timer").doc(title).set(timerMap);
  }
}

