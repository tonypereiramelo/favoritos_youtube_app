import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube_app/blocs/youtube_bloc.dart';
import 'package:favoritos_youtube_app/models/video.dart';
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Favorites extends StatelessWidget {
  const Favorites({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();
    final blocYouTube = BlocProvider.getBloc<YouTubeBloc>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Favoritos"),
        centerTitle: true,
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.black87,
      body: StreamBuilder<Map<String, Video>>(
        stream: bloc.outFav,
        initialData: {},
        builder: (context, snapshot) {
          return ListView(
            children: snapshot.data!.values.map((v) {
              return InkWell(
                onTap: () {
                  StreamBuilder(
                      stream: blocYouTube.outYouTube,
                      initialData: {},
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return YoutubePlayerIFrame(
                            controller: blocYouTube.video,
                            aspectRatio: 19 / 9,
                          );
                        } else
                          return CircularProgressIndicator();
                      });
                },
                onLongPress: () {
                  bloc.toggleFavorites(v);
                },
                child: Row(
                  children: <Widget>[
                    Container(
                      width: 100,
                      height: 50,
                      child: Image.network(v.thumb.toString()),
                    ),
                    Expanded(
                        child: Text(
                      v.title.toString(),
                      style: TextStyle(
                        color: Colors.white,
                      ),
                      maxLines: 2,
                    ))
                  ],
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
