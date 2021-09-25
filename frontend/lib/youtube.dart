import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:pitradio/song.dart';

class PasteYouTubeLink extends StatefulWidget {
  const PasteYouTubeLink({Key? key, this.onInput}) : super(key: key);

  final SongCallback? onInput;

  @override
  State<PasteYouTubeLink> createState() => _PasteYouTubeLinkState();
}

class _PasteYouTubeLinkState extends State<PasteYouTubeLink> {
  bool _warningShown = false;
  final TextEditingController controller = TextEditingController(text: "");
  final RegExp _regex = RegExp(
    r"^\s*(?:https?:\/\/)?(?:www\.)?(?:youtube\.com\/watch\?v=|youtu.be\/)([\w-]+)(?:[&?][\w=\.]+)*\s*$",
  );

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Paste YouTube video link"),
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
    Uri uri = Uri.parse(
        "https://www.youtube.com/oembed?url=https://www.youtube.com/watch?v=$id&format=json");
    http.Response response = await http.get(uri);

    if (response.statusCode == 200) {
      dynamic json = jsonDecode(response.body);
      return Song(
        name: json['title'],
        author: json['author_name'],
        thumbnailUrl: json['thumbnail_url'],
      );
    } else {
      throw Exception('Failed to load video');
    }
  }
}
