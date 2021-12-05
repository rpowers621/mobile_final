import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/spotify.dart';








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
  final _formKey = GlobalKey<FormState>();

  final _inputController = TextEditingController();
  late  AsyncSnapshot artistStuff;


  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }



  @override
  Widget build(BuildContext context){
print("yoo");
    return Scaffold(

      backgroundColor: Colors.amberAccent,
      body: Column(children: <Widget>[
        Column(children: <Widget>[
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
                // if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Loading Data')));
                  Spotify().getCredentials();
                  setState(() {
                    searchInput = _inputController.text;
                    Spotify().getArtistInfo(searchInput);

                  });
                // }
              },
              child: const Text('Add',
                  style: TextStyle(
                      color: Colors.black))
          )
        ],
        ),
        Row(
          children: [
            FutureBuilder(
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
                            child: Text(id),
                          );
                      });
                }else{
                  return Container(
                    child: Text("Error"),
                  );
                }
              },
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

