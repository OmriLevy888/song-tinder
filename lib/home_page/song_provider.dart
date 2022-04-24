import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/models/models.dart';

class SongProviderConfig {
  SongProviderConfig({required this.source});

  String source;
}

class SongProvider {
  const SongProvider({required this.config, required this.musicService});

  final SongProviderConfig config;
  final MusicServiceInterface musicService;

  SongModel poll() {
    return musicService.fetchRandom();
  }
}
