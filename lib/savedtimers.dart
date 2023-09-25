import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'authentication.dart';

class savedTimer extends StatefulWidget {
  const savedTimer({super.key, required this.title});

  final String title;

  @override
  State<savedTimer> createState() => savedTimerState();
}

class savedTimerState extends State<savedTimer> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  FirebaseFirestore db = FirebaseFirestore.instance;

  Future<QuerySnapshot<Map<String, dynamic>>> fetchData() async {
    // Replace 'collectionName' with your actual collection name
    QuerySnapshot<Map<String, dynamic>> snapshot = (await db
        .collection("users")
        .doc(AuthenticationHelper().uid)
        .collection("timer")
        .get());
    return snapshot;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FutureBuilder<QuerySnapshot<Map<String, dynamic>>>(
                future: fetchData(), // Call your fetchData function here
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                        child:
                            CircularProgressIndicator()); // Display a loading indicator while waiting for data
                  } else if (snapshot.hasError) {
                    return Center(
                        child: Text(
                            'Error fetching data')); // Display an error message if data fetching fails
                  } else if (!snapshot.hasData) {
                    return Center(
                        child: Text(
                            'No data available')); // Display a message if no data is available
                  } else {
                    // Build your UI using the fetched data
                    // You can access the data using snapshot.data
                    List<Widget> x = [];
                    final data = snapshot.data!;
                    print(data.docs);
                    for (var i in data.docs) {
                      print(i.data()["duration"]);
                      print(i.data()["title"]);
                      x.add(Row(
                        children: [
                          Text(
                            i.data()["duration"].toString(),
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(width: 1,),

                          Text(i.data()["title"],
                              style: TextStyle(fontSize: 20)),
                        ],
                      ));
                    }

                    print(x);
                    // Extract the data from the DocumentSnapshot
                    List<Widget> tmpHW = [];
                    return Container(
                      height: 600,
                      width: 300,
                      child: ListView(
                        children: x,
                      ),
                    );
                  }
                })
          ],
        ),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
