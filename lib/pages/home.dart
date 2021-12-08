import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/database.dart';
import 'package:mobile_final/spotify.dart';
import 'package:link/link.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var holder = "";
  String id = Authentication().getUserId();
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  var user ='G-User';
  @override

  Widget build(BuildContext context){
  getUser();
    return Scaffold(
      backgroundColor: Colors.indigo,
      body:Column(
        // constraints: BoxConstraints.expand(),
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage("assets/cover.jpeg"),
        //     fit: BoxFit.cover)),
        children: [
          Text("Hello, $user",
          style: const TextStyle(
              color: Colors.white,
              fontSize: 60,
              fontFamily: 'RobotoMono'
          ),
        ),
        SizedBox(width: 5, height: 10),
        Text("Welcome to GeSpot! We love having you here.", style: const TextStyle(fontSize: 30, color: Colors.white), textAlign: TextAlign.center),
        SizedBox(width: 5, height: 30),
        Container(
          width: 300,
          child: Text("The saved page is where you can see your saved artist and discover their top tracks or search the name of an artist on the search page to discover new things!", style: const TextStyle(fontSize: 20, color: Colors.white), textAlign: TextAlign.center),
        ),
        SizedBox(width: 5, height: 40),
        FutureBuilder<Map>(
            future: Spotify().getFeaturedPlaylists(),
            builder: (context, AsyncSnapshot snapshot){
              if(snapshot.hasData){
                final data = snapshot.data;
                return ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    itemCount: 1,
                    itemBuilder: (context, index){
                      var name = data["name"][index];
                      holder = data["playlist_id"][index];
                      return
                        Column(
                          children: [
                            Text("Our featured playlist is: $name", style: const TextStyle(fontSize: 30, color: Colors.lightGreenAccent), textAlign: TextAlign.center),
                            SizedBox(width: 5, height: 10),
<<<<<<< HEAD
                            Text("Go to this link to see the featured playlist!", style: const TextStyle(fontSize: 25, color: Colors.white), textAlign: TextAlign.center, decoration: TextDecoration.underline,),
                            SizedBox(width: 5, height: 10),
=======
>>>>>>> 1ac599d8e150f536bc0635a72a9d21f48d51a1da
                            Container(
                              width: 300,
                              child: new InkWell(
                                  child: Text("Click here to see the featured playlist!", style: const TextStyle(fontSize: 15
                                      , color: Colors.white), textAlign: TextAlign.center),
                                  onTap:() => launch("https://open.spotify.com/playlist/37i9dQZF1DXc5e2bJhV6pu"),
                      )

                            )
                          ]
                        );
                    }
                );
              }
              else{
                return Container(
                  child: Text(""),
                );
              }
            }),
        ],

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

  getUser()async {
    user = await Database().getUsername();
    return user;
    print("user: ${user}");
  }

}
