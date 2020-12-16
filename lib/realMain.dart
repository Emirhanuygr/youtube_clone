import 'package:flutter/material.dart';
import 'dart:io';
import 'dart:async';
import 'dart:convert';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:mp3_player/music_player.dart';
import 'package:mp3_player/settings.dart';


class RealMain extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Main(),
    );
  }
}

class Main extends StatefulWidget {
  @override
  _AnaSayfaState createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<Main> {


  // VERI CEKILMESINE YARDIMCI OLAN KUTUPHANE get Data
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
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Text(
          "Mp3Player",
          style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: Colors.black,
              fontFamily: "Montserrat"),
        ),
        leading: Icon(Icons.music_note, color: Colors.black),
      ),
      body: Container(
        child: ListView.separated(
          separatorBuilder: (context, index) => Divider(
            height: 5,
          ),
          itemCount: songs.length,
          itemBuilder: (context, index) => ListTile(
            leading: Material(
              elevation: 6,
              child: CircleAvatar(
                backgroundImage: songs[index].albumArtwork == null
                    ? AssetImage('assets/musix.jpg')
                    : FileImage(File(songs[index].albumArtwork)),
              ),
            ),
            title: Text(songs[index].title),
            subtitle: Text(songs[index].artist),
            onTap: () {
              currentIndex = index;
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MusicPlayer(
                      changeTrack: changeTrack,
                      songInfo: songs[currentIndex],
                      key: key)));
            },
          ),
        ),
      ),
    );
  }



  }

