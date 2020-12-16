import 'package:flutter/material.dart';

import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mp3_player/music_player.dart';
import 'package:mp3_player/realMain.dart';
import 'package:mp3_player/search.dart';
import 'package:mp3_player/settings.dart';

void main() => runApp(Mp3Player());

class Mp3Player extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: AnaSayfa(),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {
  int selectedMenuItem = 0;
  List<Widget> tumSayfalar;
  Settings settings;
  RealMain main;
  Search search;

  // Get Data
  final FlutterAudioQuery audioQuery = FlutterAudioQuery();
  List<SongInfo> songs = [];
  int currentIndex = 0;
  final GlobalKey<MusicPlayerState> key = GlobalKey<MusicPlayerState>();



  void getTracks() async {
    songs = await audioQuery.getSongs();
    setState(() {
      songs = songs;
    });
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != songs.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }
    key.currentState.setSong(songs[currentIndex]);
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTracks();
    settings = Settings();
    main = RealMain();
    search = Search();
    tumSayfalar = [main, search,settings];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: tumSayfalar[selectedMenuItem],
      bottomNavigationBar: bottomNavMenu(),
    );
  }

  BottomNavigationBar bottomNavMenu() {
    return BottomNavigationBar(
      elevation: 3,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.black,
            ),
            title: Text(
              "Home",
              style: TextStyle(color: Colors.black),
            )),
        BottomNavigationBarItem(
          icon: Icon(
            Icons.search,
            color: Colors.black,
          ),
          title: Text(
            "Search",
            style: TextStyle(color: Colors.black),
          ),
        ),BottomNavigationBarItem(
          icon: Icon(
            Icons.settings,
            color: Colors.black,
          ),
          title: Text(
            "Settings",
            style: TextStyle(color: Colors.black),
          ),
        ),
      ],
      type: BottomNavigationBarType.fixed,
      currentIndex: selectedMenuItem,
      onTap: (index) {
        setState(() {
          selectedMenuItem = index;
        });
      },
    );
  }
}
