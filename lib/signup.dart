import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';


import 'authentication.dart';
import 'controller.dart';
import 'login.dart';

class Signup extends StatefulWidget {
  @override
  Signup();
  State<Signup> createState() => _SignupState();
}

class _SignupState extends State<Signup> {
  @override

  bool thisCharacterTeacher = false;
  String Teachercode = "OOOO";
  String CorrectTeacherCode = "";
  FirebaseFirestore db = FirebaseFirestore.instance;






  String email = "";
  String password = "";
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(50),
              bottomRight: Radius.circular(50),
            )
        ),
        toolbarHeight: 250,
        backgroundColor: Colors.blue[100],
        bottomOpacity: 0,
        elevation: 0,
        title: Text("timer app")
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 10.0,),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Email',
                  ),
                  onChanged: (String newEntry) {
                    print("Username was changed to $newEntry");
                    email = newEntry;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(top: 10.0,),
                child: TextField(
                  obscureText: false,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    labelText: 'Password',
                  ),
                  onChanged: (String newEntry) {
                    print("Username was changed to $newEntry");
                    password = newEntry;
                  },
                ),
              ),
              const SizedBox(height: 20,),
              SizedBox(
                height: 50,
                width: 500,
                child: ElevatedButton(
                  onPressed: (){
                    AuthenticationHelper()
                        .signUp(email: email!, password: password!)
                        .then((result) {
                      if (result == null) {
                        Map<String, String> x = {};
                        db.collection("users").doc(AuthenticationHelper().uid).set(x);
                        Navigator.pushReplacement(context,
                            MaterialPageRoute(builder: (context) => MyHomePage(title: '',)));
                      }
                      else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text(
                            result,
                            style: TextStyle(fontSize: 16),
                          ),
                        ));
                      }
                    });
                  },
                  child: Text("Sign up",
                    style: TextStyle(
                      fontWeight: FontWeight.w800,
                      color: Colors.white,
                      fontSize: 20,
                      fontFamily: "Metropolis",
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    elevation: 5.0,
                    backgroundColor: Colors.blue[100],
                    shadowColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 5,),

              const SizedBox(height: 5,),
            ],
          ),
        ),
      ),
    );
  }
}
