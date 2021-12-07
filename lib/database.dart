
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_final/authentication.dart';


class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid = Authentication().getUserId();

  getArtists() async {
    final QuerySnapshot result = await FirebaseFirestore.instance
        .collection('artists')
        .where('user', isEqualTo: uid)
        .get();
    if (result.size <= 0) {
      return null;
    }else{
      return result as List;
    }
  }

  addArtist(id) {
    print(id);
    try {
      _db
          .collection("artists")
          .doc()
          .set({
        "user": uid,
        "artistID": id
      })
          .then((value) => null)
          .onError((error, stackTrace) => null);
    } on FirebaseAuthException catch (e) {

    } catch (e) {
      print(e);
      return false;
    }
    return true;
  }
}