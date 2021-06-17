import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/models/video.dart';
import 'package:rxdart/subjects.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class YouTubeBloc implements BlocBase {
  final String? videoId = Video().id;
  var video;

  final _controllerYouTube = BehaviorSubject<String>();
  Stream<String> get outYouTube => _controllerYouTube.stream;

  YouTubeBloc() {
    video = YoutubePlayerController(
      initialVideoId: videoId.toString(),
      params: YoutubePlayerParams(
        startAt: Duration(seconds: 0),
        showControls: true,
        showFullscreenButton: true,
      ),
    );
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _controllerYouTube.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
