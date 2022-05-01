import 'package:song_tinder/home_page/dummy_music_service.dart';
import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/home_page/song_provider.dart';

class MusicServiceFactory {
  static MusicServiceInterface from(MusicServiceConfig config) {
    print("Creating music service for ${config.service}");
    switch (config.service) {
      case MusicServices.spotify:
        print("Spotify config: ID=${config.spotifyID}, ClientSecret=${config.spotifyClientSecret}");
        break;
      case MusicServices.appleMusic:
        print("Apple music config: KeyIdentifier=${config.appleMusicKeyIdentifier}, ISS=${config.appleMusicISS}");
        break;
    }
    return DummyMusicService();
  }
}