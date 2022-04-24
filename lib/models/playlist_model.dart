import 'package:song_tinder/models/models.dart';

class PlaylistModel {
  const PlaylistModel({
    required this.name,
    required this.songs,
  });

  final String name;
  final List<SongModel> songs;
}
