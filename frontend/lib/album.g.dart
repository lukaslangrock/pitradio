// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'album.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Album _$AlbumFromJson(Map<String, dynamic> json) => Album(
      artist: json['artist'] as String,
      title: json['title'] as String,
      uuid: json['uuid'] as String,
      songs: (json['songs'] as List<dynamic>)
          .map((e) => Song.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$AlbumToJson(Album instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'artist': instance.artist,
      'songs': instance.songs,
    };
