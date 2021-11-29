import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/spotify.dart';








class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}


class _HomePageState extends State<HomePage> {



  String id =Authentication().getUserId();
  final FirebaseFirestore fb = FirebaseFirestore.instance;

  var artist = Spotify().getArtist('0OdUWJ0sBjDrqHygGUXeCF');



  @override
  Widget build(BuildContext context){

    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.teal,
          title: Text("Home Page"),
      ),
      backgroundColor: Colors.amberAccent,
      body: Container(
        child: FutureBuilder<void> (
          future:  Spotify().getArtist('0OdUWJ0sBjDrqHygGUXeCF'),
          builder: (context,snapshot){
            if(snapshot.hasData){
              final data = snapshot.data as String;
              return Container(
                child: Text(data),
              );
            }else{
              return CircularProgressIndicator();
            }
          },
        ),
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

