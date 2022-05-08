import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:http/http.dart' as http;
import 'package:song_tinder/home_page/music_service_interface.dart';
import 'package:song_tinder/models/song_model.dart';
import 'package:song_tinder/models/playlist_model.dart';
import 'package:song_tinder/models/artist_model.dart';
import 'package:song_tinder/models/album_model.dart';
import 'package:url_launcher/url_launcher.dart';

class Spotify extends MusicServiceInterface {
  Spotify() {
    initAuth();
  }

  final client = http.Client();

  late String accessToken;
  static String _clientId = ""; // Your Spotify app clientId;
  static String _clientSecret = ""; // Your Spotify app clientSecret;

  static String _baseURL = "https://api.spotify.com/v1";
  static String _callbackServerURL = "http://localhost:3000";
  final Uri _initAuthURL = Uri(
      scheme: 'https',
      host: 'accounts.spotify.com',
      path: '/authorize',
      queryParameters: {
        'client_id': _clientId,
        'redirect_uri': _callbackServerURL,
        'response_type': 'code',
        'scope':
            'ugc-image-upload user-modify-playback-state user-read-playback-state user-read-currently-playing user-follow-modify user-follow-read user-read-recently-played user-read-playback-position user-top-read playlist-read-collaborative playlist-modify-public playlist-read-private playlist-modify-private app-remote-control streaming user-read-email user-read-private user-library-modify user-library-read'
      });

  void initAuth() async {
    await launchUrl(
        _initAuthURL); // open Spotify's authorization form on a web view

    // start listener for callback response
    await HttpServer.bind('0.0.0.0', 3000).then((listener) {
      listener.listen((HttpRequest request) async {
        await closeInAppWebView(); // close the web view on received callback response

        final String authCode = request.uri.queryParameters['code']!;

        // fetch access token using received code from Spotify
        client.post(
            Uri(
                scheme: 'https',
                host: 'accounts.spotify.com',
                path: '/api/token',
                queryParameters: {
                  'code': authCode,
                  'redirect_uri': _callbackServerURL,
                  'grant_type': 'authorization_code'
                }),
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded',
              'Authorization': 'Basic ' +
                  base64.encode(utf8.encode(_clientId + ':' + _clientSecret))
            }).then((response) {
          accessToken = json.decode(response.body)['access_token'];
        });
        request.response.close();
        listener.close();
      });
    });
  }

  void renewAuth() {
    client.post(
        Uri(
            scheme: 'https',
            host: 'accounts.spotify.com',
            path: '/api/token',
            queryParameters: {
              'grant_type': 'refresh_token',
              'refresh_token': accessToken
            }),
        headers: {
          'Content-Type': 'application/x-www-form-urlencoded',
          'Authorization': 'Basic ' +
              base64.encode(utf8.encode(_clientId + ':' + _clientSecret))
        }).then((response) {
      accessToken = json.decode(response.body)['access_token'];
    });
  }

  @override
  AlbumModel fetchAlbum(String name) {
    // TODO: implement fetchAlbum
    throw UnimplementedError();
  }

  @override
  ArtistModel fetchArtist(String name) {
    // TODO: implement fetchArtist
    throw UnimplementedError();
  }

  @override
  PlaylistModel fetchPlaylist(String playlistId) {
    // TODO: implement fetchPlaylist
    throw UnimplementedError();
  }

  @override
  Future<SongModel> fetchRandom() async {
    String path = "/me/top/tracks";

    final _random = Random(DateTime.now().microsecond);
    List<SongModel> savedTracks = <SongModel>[];

    var response = await client.get(Uri.parse(_baseURL + path),
        headers: {'Authorization': 'Bearer ' + accessToken});
    if (response.statusCode == 401) {
      renewAuth();
      fetchRandom();
    } else if (response.statusCode == 200) {
      var retrievedSongs = (json.decode(response.body))['items'];

      for (int songIter = 0; songIter < retrievedSongs.length; songIter++) {
        String songName = retrievedSongs[songIter]['name'];
        String songAlbum = retrievedSongs[songIter]['album']['name'];
        String songArtist = retrievedSongs[songIter]['artists'][0]['name'];
        String songReleaseYear =
            retrievedSongs[songIter]['album']['release_date'];
        String songCoverImgUrl =
            retrievedSongs[songIter]['album']['images'][0]['url'];

        savedTracks.add(SongModel(
            name: songName,
            album: songAlbum,
            artist: songArtist,
            releaseYear: songReleaseYear,
            coverImgUrl: songCoverImgUrl));
      }
    }
    return savedTracks[
        _random.nextInt(savedTracks.length * 100) % savedTracks.length];
  }

  @override
  SongModel fetchSong(String name) {
    // TODO: implement fetchSong
    throw UnimplementedError();
  }

  @override
  Future<List<PlaylistModel>> listPlaylists() async {
    String path = "/me/playlists";

    List<PlaylistModel> result = <PlaylistModel>[];

    var response = await client.get(Uri.parse(_baseURL + path),
        headers: {'Authorization': 'Bearer ' + accessToken});
    if (response.statusCode == 401) {
      renewAuth();
      listPlaylists();
    } else if (response.statusCode == 200) {
      var retrievedPlaylists = (json.decode(response.body))['items'];
      for (int playlistIter = 0;
          playlistIter < retrievedPlaylists.length;
          playlistIter++) {
        String playlistName = retrievedPlaylists[playlistIter]['name'];
        List<SongModel> parsedSongs = <SongModel>[];

        String playlistTracksLink =
            retrievedPlaylists[playlistIter]['tracks']['href'];

        var playlistResponse = await client.get(Uri.parse(playlistTracksLink),
            headers: {'Authorization': 'Bearer ' + accessToken});

        final retrievedSongs = (json.decode(playlistResponse.body))['items'];

        for (int songIter = 0; songIter < retrievedSongs.length; songIter++) {
          String songName = retrievedSongs[songIter]['track']['name'];
          String songAlbum = retrievedSongs[songIter]['track']['album']['name'];
          String songArtist =
              retrievedSongs[songIter]['track']['artists'][0]['name'];
          String songReleaseYear =
              retrievedSongs[songIter]['track']['album']['release_date']!;
          String songCoverImgUrl =
              retrievedSongs[songIter]['track']['album']['images'][0]['url'];

          parsedSongs.add(SongModel(
              name: songName,
              album: songAlbum,
              artist: songArtist,
              releaseYear: songReleaseYear,
              coverImgUrl: songCoverImgUrl));
        }

        result.add(PlaylistModel(name: playlistName, songs: parsedSongs));
      }
    }
    return result;
  }
}
