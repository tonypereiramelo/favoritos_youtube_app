import 'package:favoritos_youtube_app/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 4),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb.toString(),
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                  child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.fromLTRB(8, 8, 8, 0),
                    child: Text(
                      video.title.toString(),
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8),
                    child: Text(
                      video.channel.toString(),
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent),
                    ),
                  ),
                ],
              ))
            ],
          )
        ],
      ),
    );
  }
}
