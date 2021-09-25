import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
  final List<String> _songs = [];
  final List<bool?> _pressed = [];

  void _addSong() {
    setState(() {
      _count += 1;
      _songs.add("new");
      _pressed.add(null);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
      body: _body(),
      floatingActionButton: FloatingActionButton(
        onPressed: _addSong,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget _body() {
    return ListView.builder(
      itemBuilder: (context, index) {
        return ListTile(
          leading: Image.network("https://files.catbox.moe/3j0lpp.jpg"),
          title: Text(_songs[index]),
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
