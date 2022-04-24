import 'dart:math';

import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/models/models.dart';

class DummyMusicService extends MusicServiceInterface {
  final _random = Random(DateTime.now().microsecond);
  final _dummyData = const [
    SongModel(
        name: 'Spaceship',
        album: 'The College Dropout',
        artist: 'Kanye West',
        releaseYear: 2004,
        coverImgUrl:
            'https://www.udiscovermusic.com/wp-content/uploads/2019/02/Kanye-West-The-College-Dropout-album-cover-web-optimised-820.jpg'),
    SongModel(
        name: 'Mr. Rager',
        album: 'Man On The Moon II: The Legend Of Mr. Rager',
        artist: 'Kid Cudi',
        releaseYear: 2010,
        coverImgUrl:
            'https://images.genius.com/7e0ef6fcf7e000a78c6caba3b44acf88.640x640x1.jpg'),
    SongModel(
        name: 'In My Room',
        album: 'In My Room',
        artist: 'Frank Ocean',
        releaseYear: 2019,
        coverImgUrl:
            'https://images.squarespace-cdn.com/content/597febe6725e2529bad5fc50/1572710251369-UWUQIK1E0MRQG2TZO9TG/?format=1500w&content-type=image%2Fjpeg'),
    SongModel(
        name: 'Formula',
        album: 'Euphoria (Original Score from the HBO Series)',
        artist: 'Labrinth',
        releaseYear: 2019,
        coverImgUrl:
            'https://m.media-amazon.com/images/I/81pPIYQZFvL._SL1200_.jpg'),
    SongModel(
        name: 'Homecoming',
        album: 'Graduation',
        artist: 'Kanye West',
        releaseYear: 2007,
        coverImgUrl:
            'https://m.media-amazon.com/images/I/71pxGj4RoVS._AC_SL1200_.jpg'),
  ];

  @override
  ArtistModel fetchArtist(String name) {
    return const ArtistModel(name: 'TODO', albums: []);
  }

  @override
  AlbumModel fetchAlbum(String name) {
    return const AlbumModel(name: 'TODO', artist: 'TODO', year: 0, songs: []);
  }

  @override
  SongModel fetchSong(String name) {
    return _dummyData.where((element) => element.name == name).first;
  }

  @override
  PlaylistModel fetchPlaylist(String name) {
    return const PlaylistModel(name: 'TODO', songs: []);
  }

  @override
  SongModel fetchRandom() {
    return _dummyData[_random.nextInt(_dummyData.length * 100) % _dummyData.length];
  }
}
