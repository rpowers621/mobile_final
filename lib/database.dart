
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/spotify.dart';


class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid = Authentication().getUserId();
  var artistname;

  getArtists() async {
    print(uid);
    try {
      final QuerySnapshot result = await FirebaseFirestore.instance
          .collection('artists')
          .where('user', isEqualTo: uid)
          .get();
      List lResult = result.docs.toList();

      var docs = result.docs.map((e) => e.data());
      // print(docs['artistID']);



      if (result.size <= 0) {
        return null;
      }else{
        return result as List;
      }
    }catch(e){}

  }

  Future<String> addArtist(id,name) async{
    print("in add artist");
    print(id);
    print(name);
    try {
      _db
          .collection("artists")
          .doc()
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
}