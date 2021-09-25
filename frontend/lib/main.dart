import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    return MaterialApp(
      title: 'Flutter Demo',
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        brightness: Brightness.dark,
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'PIT Radio'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _count = 0;
  final List<Song> _songs = [];
  final List<bool?> _pressed = [];

  void _addSong(Song song) {
    setState(() {
      _count += 1;
      _songs.add(song);
      _pressed.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
        centerTitle: true,
      ),
      bottomNavigationBar: SizedBox(
        height: 69,
        child: Material(
          borderOnForeground: true,
          child: Column(
            children: [
              ListTile(
                  title: Text("Hawaii: Part II"),
                  subtitle: Text("Miracle Musical"),
                  leading: Image.network(
                      "https://images.genius.com/18635e806e01f2162088f4fd18cfa96c.1000x1000x1.jpg")),
              LinearProgressIndicator(),
            ],
          ),
          borderRadius: BorderRadius.zero,
          elevation: 12,
          type: MaterialType.card,
        ),
      ),
      body: _body(context),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return AddSongModal(
                  onInput: _addSong,
                );
              });
        },
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network("https://files.catbox.moe/3j0lpp.jpg"),
          title: Text(_songs[index].name),
          subtitle: Row(
            children: [Text("Submitted by "), Text("Aaron")],
          ),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(_pressed[index] == true
                  ? "+1"
                  : (_pressed[index] == false ? "-1" : "0")),
              IconButton(
                onPressed: () {
                  setState(() {
                    _pressed[index] = _pressed[index] == true ? null : true;
                  });
                },
                icon: Icon(_pressed[index] == true
                    ? Icons.thumb_up
                    : Icons.thumb_up_outlined),
              ),
              IconButton(
                onPressed: () {
                  setState(() {
                    _pressed[index] = _pressed[index] == false ? null : false;
                  });
                },
                icon: Icon(_pressed[index] == false
                    ? Icons.thumb_down
                    : Icons.thumb_down_outlined),
              ),
            ],
          ),
        );
      },
      itemCount: _count,
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
