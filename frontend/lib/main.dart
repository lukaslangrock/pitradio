import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mdi/mdi.dart';
import 'package:pitradio/album.dart';
import 'package:pitradio/api.dart';
import 'package:pitradio/song.dart';

late API api;

void main() {
  api = API("http://192.168.10.1:5000/api");
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

  void _addSong(Song song) {
    setState(() {
      _count += 1;
      _songs.add(song);
      _pressed.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    Duration startTime = const Duration(seconds: 5);
    Duration finishTime = const Duration(seconds: 30, minutes: 1);

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
            FutureBuilder(
              future: api.getCurrentSong(),
              builder: (builder, AsyncSnapshot<Song> snapshot) {
                if (snapshot.hasError) {
                  return Text(snapshot.error.toString());
                }

                if (!snapshot.hasData) {
                  return const Center(
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }

                return ListTile(
                  title: Text(snapshot.data!.title),
                  leading: Image.network(
                    "https://images.genius.com/18635e806e01f2162088f4fd18cfa96c.1000x1000x1.jpg",
                  ),
                  trailing: const TimeDisplay(
                    current: "0:05",
                    end: "0:30",
                  ),
                );
              },
            ),
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
            },
          );
        },
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body(BuildContext context) {
    return FutureBuilder(
        future: api.getQueue(),
        builder: (builder, AsyncSnapshot<List<Song>> snapshot) {
          if (snapshot.hasError) {
            return Text(snapshot.error.toString());
          }

          if (!snapshot.hasData) {
            return const Center(
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: CircularProgressIndicator(),
              ),
            );
          }

          if (snapshot.data!.isEmpty) {
            return Center(
              child: Opacity(
                opacity: .5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Icon(Mdi.musicNoteOutline, size: 64),
                    Padding(
                      padding: EdgeInsets.only(top: 8.0),
                      child: Text("No songs queued"),
                    )
                  ],
                ),
              ),
            );
          }

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

              var voteState = false;
              //var voteState = _pressed[index];
              int votes = getVotes(voteState);
              Song song = snapshot.data![index];

              return Dismissible(
                key: ValueKey(index),
                child: ListTile(
                  tileColor: getTileColor(voteState),
                  // leading: Image.network(_songs[index].thumbnailUrl),
                  title: Text(song.title),
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
                    ],
                  ),
                  onLongPress: () {
                    setState(() => _pressed[index] = null);
                  },
                ),
                background: const VoteSwipeBackground(
                  color: Colors.green,
                  direction: true,
                  icon: Icons.thumb_up,
                  text: 'Like',
                ),
                secondaryBackground: const VoteSwipeBackground(
                  color: Colors.red,
                  direction: false,
                  icon: Icons.thumb_down,
                  text: 'Dislike',
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
            itemCount: snapshot.data!.length + 2,
          );
        });
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

class TimeDisplay extends StatelessWidget {
  const TimeDisplay({
    Key? key,
    required this.current,
    required this.end,
  }) : super(key: key);

  final String current;
  final String end;

  @override
  Widget build(BuildContext context) {
    return Row(mainAxisSize: MainAxisSize.min, children: [
      Text(
        current,
        style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
      ),
      Text(
        "/",
        style: GoogleFonts.robotoMono(),
      ),
      Text(
        end,
        style: GoogleFonts.robotoMono(fontWeight: FontWeight.bold),
      ),
    ]);
  }
}

class VoteSwipeBackground extends StatelessWidget {
  const VoteSwipeBackground({
    Key? key,
    required this.icon,
    required this.text,
    required this.color,
    required this.direction,
  }) : super(key: key);

  final IconData icon;
  final String text;
  final Color color;
  final bool direction;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: color,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
          mainAxisAlignment:
              direction ? MainAxisAlignment.start : MainAxisAlignment.end,
          children: [
            Icon(icon),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(text),
            ),
          ],
        ),
      ),
    );
  }
}

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
