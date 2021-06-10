import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/blocs/videos_bloc.dart';
import 'package:favoritos_youtube_app/screens/home.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      blocs: [
        Bloc((i) => VideosBloc()),
      ],
      dependencies: [Dependency((i) => VideosBloc())],
      child: MaterialApp(
        title: 'FlutterTube',
        debugShowCheckedModeBanner: false,
        home: Home(),
      ),
    );
  }
}
