import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';

import '../database.dart';
import '../spotify.dart';



class LibraryPage extends StatefulWidget {
  LibraryPage({Key? key}) : super(key: key);

  @override
  _LibraryPageState createState() => _LibraryPageState();
}


class _LibraryPageState extends State<LibraryPage> {

  String id =Authentication().getUserId();
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var tracks;


  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor: Colors.amberAccent,
      body: Column(children: <Widget>[
        FutureBuilder(
          future:  Database().getArtists(),
          builder: (context,AsyncSnapshot snapshot){
            if(snapshot.hasData){
              final data = snapshot.data;
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data!.length,
                  itemBuilder: (context, index){
                    var id = data[index];
                    return
                      Expanded(
                        child:
                        OutlinedButton(
                            style: OutlinedButton.styleFrom(
                                backgroundColor:Colors.white,
                                elevation: 10,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.all(Radius.circular(10)),
                                ),
                                fixedSize: Size.fromWidth(500)
                            ),

                            onPressed: () async {
                              tracks =  await Spotify().getTopTracks(id);

                              setState(() {

                              });
                            },
                            child:  Text(id,
                              style: TextStyle(
                                  color: Colors.black),)
                        ),
                      );
                  });
            }else{
              return Container(
                child: Text("Error"),
              );
            }
          },
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

