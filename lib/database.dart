
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/spotify.dart';


class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid = Authentication().getUserId();
  var artistnames =[];
  var username = [];
  var names = [];
  String user= '';
  var docs;

  getUsername() async{
    print("in username");
    try{
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('users')
          .where('uid', isEqualTo: uid)
          .get();

      print("in here too");
      docs = result.docs.map((e) => e.data());

      if (result.size >= 0) {
        try {
          for (var fields in docs) {
            this.username.add(fields);
          }
          for (var i = 0; i < username.length; i++) {
            user = username[i]['first_name'];
          }
        } catch (e) {}
      }
    }catch(e){}
    print(user);
    return user;
  }


  getArtists() async {
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('artists')
          .where('user', isEqualTo: uid)
          .get();

      docs = result.docs.map((e) => e.data());

       if (result.size >= 0) {
         try {
           for (var artistName in docs) {
             this.artistnames.add(artistName);
           }
           for (var i = 0; i < artistnames.length; i++) {
             names.add(artistnames[i]['artistName']);
           }
         } catch (e) {}
       }
     }catch(e){}
    return names;
  }

  Future<String> addArtist(id,name) async{

    try {
      _db
          .collection("artists")
          .doc(id + uid)
          .set({
        "user": uid,
        "artistID": id,
        "artistName": name
      })
          .then((value) => null)
          .onError((error, stackTrace) => null);
    } on FirebaseAuthException catch (e) {
      return 'true';
    } catch (e) {
      print(e);
    }
    return 'true';
  }
  removeArtist(id) async{
    print("in remove artist");
    print(id);
    try {
      await FirebaseFirestore.instance
          .collection('artists')
          .doc(id+ uid)
          .delete();

    }catch(e){}

  }
}