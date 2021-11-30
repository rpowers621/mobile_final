import 'package:spotify/spotify.dart';


class Spotify {

  final clientId = 'b361f82c636d4ef3821ee8f30c7f6860';
  final clientSecret = '7ecd7f4a7558497b93771e62d6c9c584';


  getCredentials(){
    return SpotifyApiCredentials(clientId,clientSecret);
  }

  getAPI(){
    return SpotifyApi(getCredentials());
  }

  getArtist(name) async {
    var artist = await getAPI().artists.search.get(name).first(1)
        .catchError((err) => print((err as SpotifyException).message));
    //var artist = await getAPI().artists.get(name);
    print(artist);
    if( artist == null){
      print("error");
      return "Artist ID incorrect";
    } else{
      print(artist.name);

      return artist.name;
    }

  }
  getImage(id) async{
    var artists = await getAPI().artists.get(id);
    if( artists == null){
      print("error");
      return "Artist ID incorrect";
    } else{
      print(artists.name);

      return artists.image;
    }
  }
  getTopTracks(id) async{

  }

}



