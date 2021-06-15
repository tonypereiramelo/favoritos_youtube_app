import 'dart:async';
import 'dart:ui';
import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:favoritos_youtube_app/models/video.dart';

class FavoriteBloc implements BlocBase {
  Map<String, Video> _favorites = {};

  final _favController = StreamController<Map<String, Video>>.broadcast();
  Stream<Map<String, Video>> get outFav => _favController.stream;

  void toggleFavorites(Video video) {
    if (_favorites.containsKey(video.id))
      _favorites.remove(video.id);
    else
      _favorites[video.id.toString()] = video;

    _favController.sink.add(_favorites);
  }

  @override
  void addListener(VoidCallback listener) {}

  @override
  void dispose() {
    _favController.close();
  }

  @override
  bool get hasListeners => throw UnimplementedError();

  @override
  void notifyListeners() {}

  @override
  void removeListener(VoidCallback listener) {}
}
