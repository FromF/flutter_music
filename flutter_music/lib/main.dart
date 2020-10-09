import 'package:audioplayers/audio_cache.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'music app',
      theme: ThemeData(
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
        // This makes the visual density adapt to the platform that you run
        // the app on. For desktop platforms, the controls will be smaller and
        // closer together (more dense) than on mobile platforms.
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'music app'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // シンバル用Audio
  final cymbalPlayer = AudioCache(fixedPlayer: AudioPlayer());
  AudioPlayer cymbalAudioSource;
  // ギター用Audio
  final guitarPlayer = AudioCache(fixedPlayer: AudioPlayer());
  AudioPlayer guitarAudioSource;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Stack(
        children: [
          Image.asset(
            'images/background.png',
            width: double.infinity,
            height: double.infinity,
            fit: BoxFit.fitHeight,
          ),
          SafeArea(child:
          Center(child:
            Row(
                //横幅いっぱいを指定する
                mainAxisSize: MainAxisSize.min,
                children: [
                  FlatButton(onPressed: () async {
                    if (cymbalAudioSource != null) {
                      // すでに再生中なら一旦停止する
                      cymbalAudioSource.stop();
                    }
                    // AudioCacheを用いて再生
                    cymbalAudioSource = await cymbalPlayer.play('cymbalSound.mp3', mode: PlayerMode.LOW_LATENCY);

                  },
                    child: Image.asset('images/cymbal.png')
                  ),
                  FlatButton(onPressed: () async {
                    if (guitarAudioSource != null) {
                      // すでに再生中なら一旦停止する
                      guitarAudioSource.stop();
                    }
                    // AudioCacheを用いて再生
                    guitarAudioSource = await guitarPlayer.play('guitarSound.mp3', mode: PlayerMode.LOW_LATENCY);
                  },
                      child: Image.asset('images/guitar.png')
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
