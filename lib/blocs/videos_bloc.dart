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

  VideosBloc() {
    api = Api();
    _searchController.stream.listen(_search);
  }

  void _search(String search) async {
    videos = await api!.search(search);
    _videosController.sink.add(videos!);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
