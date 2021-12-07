import 'package:spotify/spotify.dart' as spotify2;
import 'package:spotify/spotify.dart';




class Spotify {

  final clientId = 'b361f82c636d4ef3821ee8f30c7f6860';
  final clientSecret = '7ecd7f4a7558497b93771e62d6c9c584';

  var authStr = "";

  var uri = '';
  List<String> ids =  [];
  var artist_names = [];
  var topTracks = [];

  var countryCode = "US";



  getCredentials(){
  var credentials = spotify2.SpotifyApiCredentials(clientId,clientSecret);

    return credentials;
  }

  Future<List> getArtistInfo(artist) async{

    var spotify = spotify2.SpotifyApi(getCredentials());


    var artistResult =  await spotify.search.get(artist).first(5)
        .catchError((err) => print((err as spotify2.SpotifyException).message));

    try {
      if (artistResult.isNotEmpty) {
        for (var pages in artistResult) {
          for (var item in pages.items!) {
            if (item is Artist) {
              this.artist_names.add(item.name);
              this.ids.add(item.id!);

            }
          }
        }
      }
    }catch (e){}

    print(ids);

    return artist_names;
  }
  getArtistId(index){
    var artist_id = ids[index];
    print(artist_id);
    return artist_id;
  }

  Future getTopTracks(artist_id) async {
    var spotify = spotify2.SpotifyApi(getCredentials());

    var tracks = await spotify.artists.getTopTracks(artist_id, countryCode);
    for (var track in tracks) {
      this.topTracks.add(track.name);
    }
    return topTracks;
  }

  Future getRelatedArtist(artist_id) async{

  }



}



