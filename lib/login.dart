import 'package:flutter/material.dart';
import 'controller.dart';
import 'signup.dart';
import 'authentication.dart';
import 'main.dart';
class Login extends StatefulWidget{
  Login();

  @override
  State<Login> createState() => _LoginState();




}

class _LoginState extends State<Login> {
  String email = "";
  String password = "";
  @override
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
                        .signIn(email: email!, password: password!)
                        .then((result) {
                      if (result == null) {
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
                  child: Text("Log in",
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

              const SizedBox(height: 12,),
              TextButton(
                onPressed: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => Signup(),
                      ));
                },
                child: Text(
                  "Don't have a account? Make one here",
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 15,
                    fontFamily: "Merriweather",
                    decoration: TextDecoration.underline,
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