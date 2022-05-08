import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/models/models.dart';
import 'music_service_factory.dart';

enum MusicServices { appleMusic, spotify }

class MusicServiceConfig {
  const MusicServiceConfig({
    required this.service,
    this.appleMusicKeyIdentifier,
    this.appleMusicISS,
  });

  final MusicServices service;
  final String? appleMusicKeyIdentifier;
  final String? appleMusicISS;
}

class SongProviderConfig {
  SongProviderConfig({this.source, this.destination, this.manualDestinations});

  PlaylistModel? source;
  PlaylistModel? destination;
  List<PlaylistModel>? manualDestinations;
}

class SongProvider {
  SongProvider(
      {required this.musicServiceConfig,
      required this.songProviderConfig,
      required this.musicService});

  MusicServiceConfig musicServiceConfig;
  SongProviderConfig songProviderConfig;
  MusicServiceInterface musicService;

  void setMusicServiceConfig(MusicServiceConfig config) {
    musicServiceConfig = config;
    musicService = MusicServiceFactory.from(config);
  }

  Future<SongModel> poll() {
    return musicService.fetchRandom();
  }

  Future<List<PlaylistModel>> listPlaylists() {
    return musicService.listPlaylists();
  }
}
