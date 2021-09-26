import 'dart:convert';

import 'package:http/http.dart';
import 'package:pitradio/song.dart';

import 'album.dart';

class API {
  String baseUrl = "/";
  Client client = Client();

  API(this.baseUrl);

  Future<List<Album>> getAllAlbums() async {
    var url = Uri.parse(baseUrl + "/Album/GetAllAlbums");
    var response = await client.get(url);
    var list = jsonDecode(response.body) as List<dynamic>;
    return list.map((j) => Album.fromJson(j)).toList(growable: false);
  }

  String getAlbumArtworkByAlbumUUID(String albumUUID) {
    return "$baseUrl/Album/GetAlbumArtworkByAlbumUUID/$albumUUID";
  }

  Future<Song> getCurrentSong() async {
    var url = Uri.parse(baseUrl + "/Playlist/GetCurrentSong");
    var response = await client.get(url);
    return Song.fromJson(jsonDecode(response.body));
  }

  Future<List<Song>> getQueue() async {
    var url = Uri.parse(baseUrl + "/Playlist/GetSongsInQueue");
    var response = await client.get(url);
    var list = jsonDecode(response.body) as List<dynamic>;
    return list.map((j) => Song.fromJson(j)).toList(growable: false);
  }
}
