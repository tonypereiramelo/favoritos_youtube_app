import 'package:favoritos_youtube_app/models/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YoutubePalyer extends StatefulWidget {
  final Video? video;
  const YoutubePalyer({this.video, key}) : super(key: key);

  @override
  _YoutubePalyerState createState() => _YoutubePalyerState();
}

class _YoutubePalyerState extends State<YoutubePalyer> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();

    _controller =
        YoutubePlayerController(initialVideoId: widget.video!.id.toString());
  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerControllerProvider(
        controller: _controller,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.video!.title.toString()),
            centerTitle: true,
          ),
          body: Container(
            padding: EdgeInsets.all(16),
            child: YoutubePlayerIFrame(
              aspectRatio: 16 / 9,
            ),
          ),
        ));
  }

  @override
  void dispose() {
    _controller.close();
    super.dispose();
  }
}
