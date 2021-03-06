import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/blocs/videos_bloc.dart';
import 'package:favoritos_youtube_app/delegates/data_search.dart';
import 'package:favoritos_youtube_app/widget/video_tile.dart';
import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Container(
            height: 25,
            child: Image.asset("images/yt_logo_rgb_dark.png"),
          ),
          elevation: 0,
          backgroundColor: Colors.black87,
          actions: <Widget>[
            Align(
              alignment: Alignment.center,
              child: Text(
                "0",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
              ),
            ),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.star),
            ),
            IconButton(
              onPressed: () async {
                String? result =
                    await showSearch(context: context, delegate: DataSearch());
                if (result != null)
                  BlocProvider.getBloc<VideosBloc>().inSearch.add(result);
              },
              icon: Icon(Icons.search),
            ),
          ],
        ),
        body: StreamBuilder(
          stream: BlocProvider.getBloc<VideosBloc>().outVideos,
          builder: (context, dynamic snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemBuilder: (context, index) {
                  return VideoTile(snapshot.data!["index"]);
                },
                itemCount: snapshot.data!.length,
              );
            } else {
              return Container();
            }
          },
        ));
  }
}
