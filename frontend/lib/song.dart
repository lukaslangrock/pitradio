class Song {
  Song({required this.name, required this.author, required this.thumbnailUrl});

  final String name;
  final String author;
  final String thumbnailUrl;
}

typedef SongCallback = void Function(Song);
