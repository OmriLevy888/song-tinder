import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/models/models.dart';

class SongProviderConfig {
  SongProviderConfig({this.source, this.destination, this.manualDestinations});

  PlaylistModel? source;
  PlaylistModel? destination;
  List<PlaylistModel>? manualDestinations;
}

class SongProvider {
  const SongProvider({required this.config, required this.musicService});

  final SongProviderConfig config;
  final MusicServiceInterface musicService;

  SongModel poll() {
    return musicService.fetchRandom();
  }

  List<PlaylistModel> listPlaylists() {
    return musicService.listPlaylists();
  }
}
