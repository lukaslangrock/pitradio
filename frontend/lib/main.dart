import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:pitradio/song.dart';
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
  final List<Song> _songs = [];
  final List<bool?> _pressed = [];
  bool enableVoteSwipe = false;

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
        var isUpvoted = voteState == true;
        var isDownvoted = voteState == false;
        int votes = getVotes(voteState);

        return ListTile(
          leading: Image.network("https://files.catbox.moe/3j0lpp.jpg"),
          title: Text(_songs[index].name),
          subtitle: Row(
            children: [
              const Text(
                "Submitted by ",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Text("Someone" + index.toString()),
            ],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (votes != 0)
                Text(votes.toString(), style: GoogleFonts.robotoMono()),
              GestureDetector(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Icon(getVoteIcon(voteState)),
                ),
                onTap: () {
                  if (voteState != null) {
                    setState(() {
                      _pressed[index] = null;
                    });
                  }
                },
                onLongPressDown: (e) async {
                  enableVoteSwipe = true;
                  await HapticFeedback.vibrate();
                  debugPrint("Vote start");
                },
                onLongPressUp: () {
                  enableVoteSwipe = false;
                  debugPrint("Vote end");
                },
                onLongPressMoveUpdate: (e) {
                  if (!enableVoteSwipe) {
                    return;
                  }

                  const int swipeThreshold = 15;
                  const int negativeSwipeThreshold = swipeThreshold * -1;

                  if (e.offsetFromOrigin.dy > swipeThreshold) {
                    setState(() {
                      _pressed[index] = false;
                    });
                  } else if (e.offsetFromOrigin.dy < negativeSwipeThreshold) {
                    setState(() {
                      _pressed[index] = true;
                    });
                  }
                },
              ),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       _pressed[index] = isUpvoted ? null : true;
              //     });
              //   },
              //   icon:
              //       Icon(isUpvoted ? Icons.thumb_up : Icons.thumb_up_outlined),
              //   splashRadius: 24,
              // ),
              // IconButton(
              //   onPressed: () {
              //     setState(() {
              //       _pressed[index] = isDownvoted ? null : false;
              //     });
              //   },
              //   icon: Icon(
              //       isDownvoted ? Icons.thumb_down : Icons.thumb_down_outlined),
              //   splashRadius: 24,
              // ),
            ],
          ),
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
}

class AddSongModal extends StatelessWidget {
  const AddSongModal({Key? key, this.onInput}) : super(key: key);

  final SongCallback? onInput;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
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
          onTap: () {},
        )
      ],
    );
  }
}
