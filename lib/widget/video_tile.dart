import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube_app/delegates/youtube_player.dart';
import 'package:favoritos_youtube_app/models/video.dart';
import 'package:flutter/material.dart';

class VideoTile extends StatelessWidget {
  final Video video;
  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final blocFav = BlocProvider.getBloc<FavoriteBloc>();
    return GestureDetector(
      onTap: () {
        Navigator.of(context)
            .push(MaterialPageRoute(builder: (context) => YoutubePalyer()));
      },
      child: Container(
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
                          style:
                              TextStyle(fontSize: 16, color: Colors.blueAccent),
                        ),
                      ),
                    ],
                  ),
                ),
                StreamBuilder<Map<String, Video>>(
                    stream: blocFav.outFav,
                    initialData: {},
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return IconButton(
                          onPressed: () {
                            blocFav.toggleFavorites(video);
                          },
                          icon: Icon(snapshot.data!.containsKey(video.id)
                              ? Icons.star
                              : Icons.star_border),
                          color: Colors.white,
                          iconSize: 30,
                        );
                      else
                        return CircularProgressIndicator();
                    })
              ],
            )
          ],
        ),
      ),
    );
  }
}
