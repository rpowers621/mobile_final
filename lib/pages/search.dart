import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/spotify.dart';
import 'package:mobile_final/database.dart';





class SearchPage extends StatefulWidget {
  SearchPage({Key? key}) : super(key: key);

  @override
  _SearchPageState createState() => _SearchPageState();
}


class _SearchPageState extends State<SearchPage> {



  String id =Authentication().getUserId();
  final FirebaseFirestore fb = FirebaseFirestore.instance;
  User? user = FirebaseAuth.instance.currentUser;
  var searchInput = '';
  Color buttonColor = Colors.white;
  var artist_index;

  var artist_id;

  final _inputController = TextEditingController();
  late  AsyncSnapshot artistStuff;


  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context){

    return Scaffold(

      backgroundColor: Colors.amberAccent,
      body: Column(children: <Widget>[
          const SizedBox(height: 5),
          TextFormField(
            autocorrect: false,
            controller: _inputController,
            validator: (value){
              if(value == null || value.isEmpty){
                return 'Input cannot be empty';
              }
              return null;
            },
            decoration: const InputDecoration(
                labelText: "Artist ID ",
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.all(Radius.circular(5.0))),
                hintText: "Artist ID"),
          ),
          OutlinedButton(
              onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Loading Data')));
                  Spotify().getCredentials();
                  setState(() {
                    searchInput = _inputController.text;
                  });
              },
              child: const Text('Search',
                  style: TextStyle(
                      color: Colors.black))
          ),
            FutureBuilder<List>(
              future:  Spotify().getArtistInfo(searchInput),
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
                                  backgroundColor:buttonColor,
                                  elevation: 10,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.all(Radius.circular(10)),
                                  ),
                                  fixedSize: Size.fromWidth(500)
                                ),

                                onPressed: () async {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      const SnackBar(content: Text('Loading Data')));
                                  artist_id =  await Spotify().getArtistId(id);

                                  setState(() {
                                    this.buttonColor = Colors.red;
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
        OutlinedButton(
            onPressed:(){
          // delete this once DB is connected
              var result =Database().addArtist(artist_id); //THIS IS WHERE WE ADD TO DATABASE
              if(result){
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Artist Added To Saved')));
              }else{
                ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Error')));
              }
            }
         , child:Text('Add Artist'))
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

