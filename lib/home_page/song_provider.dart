import 'package:audioplayers/audioplayers.dart';
import 'package:song_tinder/home_page/dummy_music_service.dart';
import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/models/models.dart';
import 'music_service_factory.dart';

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
  AudioPlayer audioPlayer = AudioPlayer();

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
