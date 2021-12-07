import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'driver.dart';
import 'package:intl/intl.dart';

class Authentication {

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  @override

  getAuth(){
    return _auth;
  }

  getAuthUser(){
    return _auth.currentUser;
  }
  getUserId(){
    User? user =_auth.currentUser;
    String id = user!.uid;
    return id;
  }
  void signInEmailPassword(_email, _password, context) async{
    await Firebase.initializeApp();
    try{
      UserCredential uid = await _auth.signInWithEmailAndPassword(
          email: _email,
          password: _password);

      Navigator.push(context,MaterialPageRoute(builder:  (context) => AppDriver()));

    }on FirebaseAuthException catch(e) {
      ScaffoldMessenger.of(context).clearSnackBars();
      if (e.code == 'wrong-password') {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("Wrong password")));
      }else if(e.code =='user-not-found')    {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            content: Text("User not found")));
      }
    }catch (e){
      print(e);
    }

  }
  void signInWithGoogle(context) async{
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();


    final GoogleSignInAuthentication googleAuth = await googleUser!
        .authentication;


    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    await FirebaseAuth.instance.signInWithCredential(credential);
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('users')
        .where('first_name', isEqualTo: googleUser.displayName)
        .limit(1)
        .get();
    final List <DocumentSnapshot> docs = result.docs;
    if (docs.isEmpty) {
      try {
        var now =  DateTime.now();
        var formatter =  DateFormat('dd/MM/yyyy');
        String formattedDate = formatter.format(now);
        _db
            .collection("users")
            .doc()
            .set({
          "first_name": googleUser.displayName,
          "last_name": '',
          "role": 'customer',
          "url": '',
          "uid" : credential,
          "time" : formattedDate,
        })
            .then((value) => null)
            .onError((error, stackTrace) => null);
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (con) => AppDriver()));
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context)
            .showSnackBar(const SnackBar(content: Text("Error")));
      } catch (e) {
        print(e);
      }
    } else {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (con) => AppDriver()));
    }
  }

  void signOut(BuildContext context) async {
    return showDialog(context: context,
        builder: (context){
          return AlertDialog(
            content: SingleChildScrollView(
              child: Text("Are you sure you'd like to log out?"),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('Log out'),
                onPressed: () async {
                  await _auth.signOut();
                  ScaffoldMessenger.of(context)
                      .showSnackBar(const SnackBar(content: Text('User logged out.')));
                  Navigator.pushReplacement(
                      context, MaterialPageRoute(builder: (con) => AppDriver()));
                  ScaffoldMessenger.of(context).clearSnackBars();
                },
              ),

            ],
          );
        }
    );
  }
}