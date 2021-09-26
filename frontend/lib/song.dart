import 'package:json_annotation/json_annotation.dart';

part 'song.g.dart';

@JsonSerializable()
class Song {
  Song({required this.title, required this.file, this.uuid});

  final String? uuid;
  final String title;
  final String file;
  // final String author;
  // final String thumbnailUrl;

  factory Song.fromJson(Map<String, dynamic> json) => _$SongFromJson(json);
  Map<String, dynamic> toJson() => _$SongToJson(this);
}

typedef SongCallback = void Function(Song);
