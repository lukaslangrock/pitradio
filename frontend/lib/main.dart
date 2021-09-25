import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:pitradio/song.dart';
import 'package:pitradio/spotify.dart';
import 'package:pitradio/youtube.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    const primarySwatch = MaterialColor(
      0xFFDE3639,
      {
        50: Color(0xfffeebee),
        100: Color(0xfffcccd2),
        200: Color(0xffea989b),
        300: Color(0xffdf7174),
        400: Color(0xffe85153),
        500: Color(0xffed3f3a),
        600: Color(0xffde3639),
        700: Color(0xffcc2c33),
        800: Color(0xffbf262c),
        900: Color(0xffb01b20),
      },
    );

    var themeData = ThemeData.from(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primarySwatch,
        accentColor: Colors.redAccent,
        errorColor: Colors.purpleAccent,
      ),
    );

    var darkThemeData = ThemeData.from(
      colorScheme: ColorScheme.fromSwatch(
        primarySwatch: primarySwatch,
        accentColor: Colors.redAccent,
        errorColor: Colors.purpleAccent,
        brightness: Brightness.dark,
        backgroundColor: Colors.black,
        cardColor: Colors.white10,
      ),
    );
    return MaterialApp(
      title: 'PIT Radio',
      themeMode: ThemeMode.system,
      theme: themeData,
      darkTheme: darkThemeData,
      home: const MyHomePage(title: 'PIT Radio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;
  String _name = "";
  final List<Song> _songs = [];
  final List<bool?> _pressed = [];
  bool enableVoteSwipe = false;

  @override
  void initState() {
    WidgetsBinding.instance?.addPostFrameCallback((timeStamp) {
      showDialog(
        context: context,
        builder: (context) {
          return NameDialog(
            onEnter: (name) {
              _name = name;
            },
          );
        },
      );
    });
  }

  void _addSong(Song song) {
    setState(() {
      _count += 1;
      _songs.add(song);
      _pressed.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    Duration startTime = Duration(seconds: 5);
    Duration finishTime = Duration(seconds: 30, minutes: 1);

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: Material(
        borderOnForeground: true,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
                title: Text("Hawaii: Part II"),
                subtitle: Text("Miracle Musical"),
                leading: Image.network(
                    "https://images.genius.com/18635e806e01f2162088f4fd18cfa96c.1000x1000x1.jpg"),
                trailing: Row(mainAxisSize: MainAxisSize.min, children: [
                  Text(
                    "0:05",
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "/",
                    style: GoogleFonts.robotoMono(),
                  ),
                  Text(
                    "1:30",
                    style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
                  ),
                ])),
            LinearProgressIndicator(
              value: startTime.inSeconds / finishTime.inSeconds,
            ),
          ],
        ),
        borderRadius: BorderRadius.zero,
        elevation: 12,
        type: MaterialType.card,
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Add song',
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddSongModal(
                  onInput: _addSong,
                );
              });
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        switch (index) {
          case 0:
            return const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 16.0,
                vertical: 12,
              ),
              child: Text("NOW PLAYING"),
            );

          case 1:
            index--;
            break;

          case 2:
            return const Divider();

          default:
            index -= 2;
            break;
        }

        var voteState = _pressed[index];
        int votes = getVotes(voteState);

        return Dismissible(
          key: ValueKey(index),
          child: ListTile(
            tileColor: getTileColor(voteState),
            leading: Image.network(_songs[index].thumbnailUrl),
            title: Text(_songs[index].name),
            subtitle: Row(
              children: [
                const Text(
                  "Submitted by ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text(_name),
              ],
            ),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (votes != 0)
                  Text(votes.toString(), style: GoogleFonts.robotoMono()),
              ],
            ),
            onLongPress: () {
              setState(() => _pressed[index] = null);
            },
          ),
          background: Container(
            color: Colors.green,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                children: const [
                  Icon(Icons.thumb_up),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text("Like"),
                  ),
                ],
              ),
            ),
          ),
          secondaryBackground: Container(
            color: Colors.red,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: const [
                  Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Text("Dislike"),
                  ),
                  Icon(Icons.thumb_down),
                ],
              ),
            ),
          ),
          confirmDismiss: (direction) async {
            debugPrint(direction.toString());

            setState(() {
              _pressed[index] = direction == DismissDirection.startToEnd;
            });

            return false;
          },
        );
      },
      itemCount: _count + 2,
    );
  }

  IconData getVoteIcon(bool? vote) {
    if (vote == true) return Icons.thumb_up;
    if (vote == false) return Icons.thumb_down;
    return Icons.thumbs_up_down_outlined;
  }

  int getVotes(bool? vote) {
    if (vote == true) return 1;

    if (vote == false) return -1;

    return 0;
  }

  Color? getTileColor(bool? voteState) {
    if (voteState == true) return Colors.green.withOpacity(0.25);
    if (voteState == false) return Colors.red.withOpacity(0.25);
    return null;
  }
}

typedef NameCallback = void Function(String);

class NameDialog extends StatefulWidget {
  const NameDialog({Key? key, this.onEnter}) : super(key: key);

  final NameCallback? onEnter;

  @override
  State<NameDialog> createState() => _NameDialogState();
}

class _NameDialogState extends State<NameDialog> {
  final TextEditingController _controller = TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Please enter your name."),
      content: TextField(
        controller: _controller,
        decoration: const InputDecoration(hintText: "Enter name..."),
      ),
      actions: [
        TextButton(
            onPressed: () async {
              if (widget.onEnter != null) {
                widget.onEnter!(_controller.text);
              }
              Navigator.pop(context);
            },
            child: const Text("OK")),
      ],
    );
  }
}

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

            Future dialog = showDialog(
              context: context,
              builder: (context) {
                return PasteYouTubeLink(
                  onInput: onInput,
                );
              },
            );
          },
        ),
        ListTile(
          leading: const Icon(Mdi.spotify),
          title: const Text("Spotify"),
          onTap: () async {
            Navigator.pop(context);

            Future dialog = showDialog(
              context: context,
              builder: (context) {
                return PasteSpotifyLink(
                  onInput: onInput,
                );
              },
            );
          },
        )
      ],
    );
  }
}
