import 'package:song_tinder/home_page/dummy_music_service.dart';
import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/models/models.dart';
import 'music_service_factory.dart';

enum MusicServices { none, appleMusic, spotify }

class MusicServiceConfig {
  const MusicServiceConfig({
    required this.service,
    this.spotifyID,
    this.spotifyClientSecret,
    this.appleMusicKeyIdentifier,
    this.appleMusicISS,
  });

  final MusicServices service;
  final String? spotifyID;
  final String? spotifyClientSecret;
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

  MusicServiceConfig musicServiceConfig = const MusicServiceConfig(service: MusicServices.none);
  SongProviderConfig songProviderConfig = SongProviderConfig();
  MusicServiceInterface musicService = DummyMusicService();

  void setMusicServiceConfig(MusicServiceConfig config) {
    musicServiceConfig = config;
    musicService = MusicServiceFactory.from(config);
  }

  SongModel poll() {
    return musicService.fetchRandom();
  }

  List<PlaylistModel> listPlaylists() {
    return musicService.listPlaylists();
  }
}
