import 'package:song_tinder/music_service/services/dummy_music_service.dart';
import 'package:song_tinder/music_service/music_service_interface.dart';
import 'package:song_tinder/models/models.dart';
import 'package:song_tinder/music_service/music_service_factory.dart';

enum MusicServices { none, appleMusic, spotify }

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
  static final SongProvider _instance = SongProvider._internal();

  factory SongProvider() { return _instance; }

  SongProvider._internal();

  SongProviderConfig songProviderConfig = SongProviderConfig();
  MusicServiceInterface musicService = DummyMusicService();

  void setMusicServiceConfig(MusicServiceConfig config) {
    musicService = MusicServiceFactory.from(config);
  }

  Future<SongModel> poll() {
    return musicService.fetchRandom();
  }

  Future<List<PlaylistModel>> listPlaylists() {
    return musicService.listPlaylists();
  }
}
