import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/database.dart';
import 'package:mobile_final/spotify.dart';



class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {

  String id =Authentication().getUserId();
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  var user;
  getUser()async {
    user = await Database().getUsername();
    print("user: ${user}");
  }


  @override
  Widget build(BuildContext context){
  getUser();
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(children: <Widget>[
        Row(
          children: [
            Container(
              child:  Text("Hello, $user",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 20)),
            ),
          ],
        ),

      ]
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Authentication().signOut(context);
        },
        tooltip: 'Log Out',
        child: const Icon(Icons.logout),
      ),
    );

  }




}

