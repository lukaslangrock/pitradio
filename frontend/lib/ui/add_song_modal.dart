import 'package:flutter/material.dart';
import 'package:pitradio/album.dart';
import 'package:pitradio/main.dart';
import 'package:pitradio/song.dart';

class AddSongModal extends StatelessWidget {
  const AddSongModal({Key? key, this.onInput}) : super(key: key);

  final SongCallback? onInput;

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: [
        ListTile(
          title: Text("Add a new song",
              style: Theme.of(context).textTheme.headline6),
        ),
        FutureBuilder(
          future: api.getAllAlbums(),
          builder: (context, AsyncSnapshot<List<Album>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }

            return Column(children: [
              for (var album in snapshot.data!)
                for (var song in album.songs)
                  ListTile(
                      title: Text(album.artist + " - " + song.title),
                      leading: Image.network(
                        api.getAlbumArtworkByAlbumUUID(album.uuid),
                        width: 48,
                        height: 48,
                      ))
            ]);
          },
        ),
      ],
    );
  }
}
