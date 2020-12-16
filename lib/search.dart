import 'package:flutter/material.dart';
import 'package:mp3_player/videos.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_api/youtube_api.dart';
import 'dart:core';
import 'dart:async';


class Search extends StatefulWidget {
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  static String key = ''; // Required this place
  String query = "";
  YoutubeAPI ytApi = new YoutubeAPI(key);
  static List<YT_API> ytResult = [];



  callAPI() async {
    ytResult = await ytApi.search(query);

    setState(() {
      ListView.builder(
          itemCount: ytResult.length,
          itemBuilder: (_, index) => listItem(index));
    });
  }


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    callAPI();
    debugPrint('$query');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: TextField(
          autofocus: false,
          onSubmitted: (String s) {
            query = s;
            callAPI();
          },
        ),
        leading: Icon(Icons.music_note, color: Colors.black),
      ),
      body: Container(
        child: ListView.builder(
            itemCount: ytResult.length,
            itemBuilder: (_, index) => listItem(index)),
      ),
    );
  }

  Widget listItem(index) {
    return GestureDetector(
      child: Card(
        child: Container(
          margin: EdgeInsets.symmetric(vertical: 7.0),
          padding: EdgeInsets.all(12.0),
          child: Row(
            children: [
              Image.network(
                ytResult[index].thumbnail['default']['url'],
              ),
              Padding(
                padding: EdgeInsets.only(right: 20),
              ),
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ytResult[index].title,
                      softWrap: true,
                      style: TextStyle(fontSize: 18),
                    ),
                    Padding(padding: EdgeInsets.only(bottom: 1.5)),
                    Text(
                      ytResult[index].channelTitle,
                      softWrap: true,
                    ),


                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => Videos(ytResult[index].url)));
      },
    );
  }
}
