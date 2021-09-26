import 'package:flutter/material.dart';
import 'package:mdi/mdi.dart';
import 'package:pitradio/song.dart';
import 'package:pitradio/spotify.dart';
import 'package:pitradio/youtube.dart';

class AddSongModal extends StatelessWidget {
  const AddSongModal({Key? key, this.onInput}) : super(key: key);

  final SongCallback? onInput;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        ListTile(
          title: Text("Add a new song",
              style: Theme.of(context).textTheme.headline6),
        ),
        ListTile(
          leading: const Icon(Mdi.youtube),
          title: const Text("YouTube"),
          onTap: () async {
            Navigator.pop(context);

            await showDialog(
              context: context,
              builder: (context) {
                return PasteYouTubeLink(onInput: onInput);
              },
            );
          },
        ),
        ListTile(
          leading: const Icon(Mdi.spotify),
          title: const Text("Spotify"),
          onTap: () async {
            Navigator.pop(context);

            await showDialog(
              context: context,
              builder: (context) {
                return PasteSpotifyLink(onInput: onInput);
              },
            );
          },
        )
      ],
    );
  }
}
