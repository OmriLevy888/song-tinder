import 'package:song_tinder/models/models.dart';

abstract class MusicServiceInterface {
  ArtistModel fetchArtist(String name);
  AlbumModel fetchAlbum(String name);
  SongModel fetchSong(String name);
  PlaylistModel fetchPlaylist(String name);
  Future<List<PlaylistModel>> listPlaylists();
  Future<SongModel> fetchRandom();
}