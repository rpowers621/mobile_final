
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:mobile_final/authentication.dart';
import 'package:mobile_final/spotify.dart';


class Database {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final uid = Authentication().getUserId();
  var artistnames =[];
  var names = [];
  var docs;


  getArtists() async {
    print(uid);

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

           //       for (var k in artistnames) {
           //         for (var v in k) {
           //           if (v == 'artistName') {
           //             this.names.add(artistnames[v]);
           //           }
           //         }
           //       }
           //
         } catch (e) {}
       }
      //
      //   print(names);
      //   return names;
      // }else{
      //   return null;
      // }
     }catch(e){}
    return names;
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