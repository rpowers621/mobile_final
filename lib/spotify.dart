import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:spotify/spotify.dart' as spotify2;
import 'package:spotify/spotify.dart';




class Spotify {

  final clientId = 'b361f82c636d4ef3821ee8f30c7f6860';
  final clientSecret = '7ecd7f4a7558497b93771e62d6c9c584';

  var authStr = "";

  var uri = '';



  getCredentials(){
  var credentials = spotify2.SpotifyApiCredentials(clientId,clientSecret);

    return credentials;
  }

  Future getArtistInfo(artist) async{
    var id =[];
    var href = [];
    var spotify = spotify2.SpotifyApi(getCredentials());
    var artistResult =  await spotify.search.get(artist).first(5)
        .catchError((err) => print((err as spotify2.SpotifyException).message));;
    print("test");

    for (var i in id) {
    if(artistResult.isNotEmpty) {
      for (var pages in artistResult) {
        for (var item in pages.items!) {
          if (item is Artist) {
            print(item.name);
            print(item.id);
            id.add(item.id!);
            print(id);
            href.add(item.href!);
            print(item.href);
          }
        }
      }
      print('test8');
    }

      print(i);
    }
    // var result = spotify.artists.getTopTracks(artistId, countryCode);
    return id;
  }



}



