import 'package:json_annotation/json_annotation.dart';
import 'package:pitradio/song.dart';

part 'album.g.dart';

@JsonSerializable()
class Album {
  Album({
    required this.artist,
    required this.title,
    required this.uuid,
    required this.songs,
  });

  final String uuid;
  final String title;
  final String artist;
  final List<Song> songs;

  // final String author;
  // final String thumbnailUrl;

  factory Album.fromJson(Map<String, dynamic> json) => _$AlbumFromJson(json);
  Map<String, dynamic> toJson() => _$AlbumToJson(this);
}
