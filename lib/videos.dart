import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
import 'package:youtube_api/youtube_api.dart';

class Videos extends StatefulWidget {
  @override
  _VideosState createState() => _VideosState();

  String gelenIndex;

  Videos(this.gelenIndex);
}

class _VideosState extends State<Videos> {
  YoutubePlayerController _controller;

  void runYoutubePlayer(){
    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId(widget.gelenIndex),
        flags: YoutubePlayerFlags(
          autoPlay: false,

        ),
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    runYoutubePlayer();
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
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_sharp,
            color: Colors.black,
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Text('You Have pushed the button this many times'),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,

            ),
          ],
        ),
      )
    );
  }
}














