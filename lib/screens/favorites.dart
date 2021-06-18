import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/blocs/favorite_bloc.dart';
import 'package:favoritos_youtube_app/delegates/youtube_player.dart';
import 'package:favoritos_youtube_app/models/video.dart';
import 'package:flutter/material.dart';

class Favorites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.getBloc<FavoriteBloc>();

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
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => YoutubePalyer(
                            video: v,
                          )));
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
