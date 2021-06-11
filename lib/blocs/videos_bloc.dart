import 'dart:async';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/api.dart';
import 'package:favoritos_youtube_app/models/video.dart';

class VideosBloc implements BlocBase {
  Api? api;

  List<Video>? videos;

  final _videosController = StreamController<List<Video>>();
  Stream get outVideos => _videosController.stream;

  final _searchController = StreamController<String>();
  Sink get inSearch => _searchController.sink;

  final _nextPageController = StreamController<String>();
  Sink get nPage => _nextPageController.sink;

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
    _nextPageController.stream.listen(_search);
  }

  void _search(String search) async {
    if (inSearch != nPage) {
      videos = await api!.search(search);
    } else {
      videos = (videos! + await api!.nextPage());
    }

    _videosController.sink.add(videos!);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
    _nextPageController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
