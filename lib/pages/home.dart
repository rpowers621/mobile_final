
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';








class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {



  String id =Authentication().getUserId();
  final FirebaseFirestore fb = FirebaseFirestore.instance;



  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Home Page"),
      ),
      backgroundColor: Colors.amberAccent,
      body:

      StreamBuilder(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {

              return Container(
                height: 60,
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(30.0)),
                  color: Colors.teal,
                ),
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Container(
                        child: Text( document['first_name']),
                        padding: EdgeInsets.all(6),
                      ),

                    ]
                ),
                margin:EdgeInsets.all(5.0),

              );

            }).toList(),
          );
        },
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

