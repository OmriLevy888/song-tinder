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
    _initAuth();
  }

  final client = http.Client();

  late String accessToken;
  static String _clientId = ""; // Your Spotify app clientId;
  static String _clientSecret = ""; // Your Spotify app clientSecret;

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

  
  Future<http.Response> _sendRequest(String path, Map<String, String>? queryParameters, bool isPost) async {
    http.Response response;
    if (isPost) {
      var uri = Uri.https('api.spotify.com', '/v1$path');
      response = await client.post(uri, headers: {'Authorization': 'Bearer ' + accessToken}, body: queryParameters);
    }
    else {
      var uri = Uri.https('api.spotify.com', "/v1$path", queryParameters);
      print(uri.toString());
      response = await client.get(uri, headers: {'Authorization': 'Bearer ' + accessToken});
    }
    if (response.statusCode == 401) {
      _renewAuth();
      return _sendRequest(path, queryParameters, isPost);
    }
    if (response.statusCode == 200) {
      return response;
    }
    throw HttpException("Unexpected response status: ${response.statusCode}");
  }

  void _initAuth() async {
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

  void _renewAuth() {
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

  SongModel _songModelFromTrackObject(Map<String, dynamic> trackObject) {
    return SongModel(
      name: trackObject['name'],
      album: trackObject['album']['name'],
      artist: trackObject['artists'][0]['name'],
      releaseYear: trackObject['album']['release_date'],
      coverImgUrl: trackObject['album']['images'][0]['url'],
      soundPreviewURL: trackObject['preview_url'],
      );
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
    String path = "/search";
    String characters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890";
    String randomItem = (characters.split('')..shuffle()).first;
    final random = Random(DateTime.now().microsecond);
    int randomInt = random.nextInt(1000);

    Map<String, String> query = {'q': randomItem, 'type': 'track', 'offset': randomInt.toString(), 'limit': '1', 'include_external': 'audio'};

    var response = await _sendRequest(path, query, false);

    var parsedSong = (json.decode(response.body))['tracks']['items'][0];

    return _songModelFromTrackObject(parsedSong);
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

    var response = await _sendRequest(path, null, false);
    var retrievedPlaylists = (json.decode(response.body))['items'];
    for (int playlistIter = 0;
        playlistIter < retrievedPlaylists.length;
        playlistIter++) {
      String playlistName = retrievedPlaylists[playlistIter]['name'];
      List<SongModel> parsedSongs = <SongModel>[];

      String playlistTracksLink =
          retrievedPlaylists[playlistIter]['tracks']['href'];

      var playlistResponse = await _sendRequest(Uri.parse(playlistTracksLink).path.substring(3), null, false);

      final retrievedSongs = (json.decode(playlistResponse.body))['items'];

      for (int songIter = 0; songIter < retrievedSongs.length; songIter++) {
        parsedSongs.add(_songModelFromTrackObject(retrievedSongs[songIter]['track']));
      }

      result.add(PlaylistModel(name: playlistName, songs: parsedSongs));
    }
    return result;
  }
}
