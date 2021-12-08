import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';
import 'package:spotify/spotify.dart';

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
  // var tracks;
  var hold;

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.amberAccent,
      body: Column(children: <Widget>[
        Text("Click an artist to see their top tracks!", style: const TextStyle(fontSize: 30), textAlign: TextAlign.center),
        SizedBox(width: 30, height: 10,),
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
                    var artist_name = data[index];
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
                              hold = await Spotify().getArtistId(artist_name) as String;
                              setState(() {
                              });
                            },
                            child:
                            Text(artist_name,
                              style: TextStyle(
                                  color: Colors.black),)
                        ),
                      );
                  });
            }else{
              return Container(
                child: Text(""),
              );
            }
          },
        ),
        SizedBox(width: 50, height: 20,),
        FutureBuilder(
            future: Spotify().getTopTracks(hold),
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                final data = snapshot.data;
                return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: data!.length,
                  itemBuilder: (context, index){
                    var tracks = data[index];
                    return
                      Expanded(
                        child:
                        Text(
                          "${index+1}. $tracks",
                            textAlign: TextAlign.center,
                            style: const TextStyle(fontSize: 20),
                        ),
                      );
                  }
                );
              }else{
                return Container(
                  child: Text(""),
                );
              }
            }),
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




