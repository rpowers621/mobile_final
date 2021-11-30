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

    return Scaffold(// new

      backgroundColor: Colors.amberAccent,
      body: Column(children: <Widget>[
        Row(
          children: [
            Container(
              child: const Text("Hello, " ,
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 20)),
            ),
          ],
        ),



        // Row(children: [
        //   Form(
        //     key: _formKey,
        //     child:
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
                if (_formKey.currentState!.validate()) {
                  ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Loading Data')));

                  setState(() {
                    artistStuff = Spotify().getArtist(_inputController);
                  });
                }
              },
              child: const Text('Add',
                  style: TextStyle(
                      color: Colors.black))
          )
        ],
        ),
        //   ),
        // ],
        // )

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

