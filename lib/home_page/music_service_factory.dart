import 'package:song_tinder/home_page/dummy_music_service.dart';
import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/home_page/song_provider.dart';
import 'package:song_tinder/music_service/services/spotify.dart';

class MusicServiceFactory {
  static MusicServiceInterface from(MusicServiceConfig config) {
    print("Creating music service for ${config.service}");
    switch (config.service) {
      case MusicServices.spotify:
        return Spotify();
      case MusicServices.appleMusic:
        print("Apple music config: KeyIdentifier=${config.appleMusicKeyIdentifier}, ISS=${config.appleMusicISS}");
        break;
    }
    return DummyMusicService();
  }
}