import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:pitradio/song.dart';

class PasteSpotifyLink extends StatefulWidget {
  const PasteSpotifyLink({Key? key, this.onInput}) : super(key: key);

  final SongCallback? onInput;

  @override
  State<PasteSpotifyLink> createState() => _PasteSpotifyLinkState();
}

class _PasteSpotifyLinkState extends State<PasteSpotifyLink> {
  bool _warningShown = false;
  final TextEditingController controller = TextEditingController(text: "");
  final RegExp _regex = RegExp(
    r"^\s*(?:(?:https?:\/\/)?open\.spotify\.com\/track\/)?(\w+)(?:[\?&][\w-=]+)*$",
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Paste Spotify link"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            controller: controller,
            decoration: const InputDecoration(hintText: "Paste link..."),
          ),
          Visibility(
            visible: _warningShown,
            child: const ListTile(
              title: Text(
                "Invalid link!",
                style:
                    TextStyle(color: Colors.red, fontWeight: FontWeight.bold),
              ),
            ),
          )
        ],
      ),
      actions: [
        TextButton(
            onPressed: () async {
              ClipboardData? data = await Clipboard.getData('text/plain');
              if (data != null) {
                controller.text = data.text!;
              }
            },
            child: const Text("PASTE")),
        TextButton(
            onPressed: () async {
              RegExpMatch? match = _regex.firstMatch(controller.text);
              if (match != null) {
                Song song = await _getSong(match.group(1)!);

                if (widget.onInput != null) {
                  widget.onInput!(song);
                }

                Navigator.pop(context);
              } else {
                setState(() {
                  _warningShown = true;
                });
              }
            },
            child: const Text("OK")),
      ],
    );
  }

  Future<Song> _getSong(String id) async {
    String token = await _getToken();

    Uri uri = Uri.parse("https://api.spotify.com/v1/tracks/$id");
    http.Response response = await http.get(uri, headers: {
      "Authorization": "Bearer $token",
    });

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      return Song(
        name: json['name'],
        author: json['artists'][0]['name'],
        thumbnailUrl: json['album']['images'][0]['url'],
      );
    } else {
      throw Exception('Failed to load song');
    }
  }

  Future<String> _getToken() async {
    String key = await rootBundle.loadString("assets/spotify-key.txt");

    Uri uri = Uri.parse("https://accounts.spotify.com/api/token");
    http.Response response = await http.post(
      uri,
      headers: {"Authorization": "Basic $key"},
      body: <String, String>{"grant_type": "client_credentials"},
    );

    dynamic json = jsonDecode(response.body);
    return json['access_token'];
  }
}
