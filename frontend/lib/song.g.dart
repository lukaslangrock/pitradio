// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'song.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Song _$SongFromJson(Map<String, dynamic> json) => Song(
      title: json['title'] as String,
      file: json['file'] as String,
      uuid: json['uuid'] as String?,
    );

Map<String, dynamic> _$SongToJson(Song instance) => <String, dynamic>{
      'uuid': instance.uuid,
      'title': instance.title,
      'file': instance.file,
    };
