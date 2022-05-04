import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/song_provider.dart';
import 'package:song_tinder/models/models.dart';
import 'package:multi_select_flutter/multi_select_flutter.dart';

class ConfPageWidget extends StatefulWidget {
  ConfPageWidget({Key? key}) : super(key: key);

  @override
  State<ConfPageWidget> createState() => _ConfPageWidgetState();
}

class _ConfPageWidgetState extends State<ConfPageWidget> {
  late List<PlaylistModel> _availablePlaylists;
  late List<PlaylistModel> _additionalSourceOptions;

  late PlaylistModel _sourcePlaylist;
  late PlaylistModel _destPlaylist;
  late List<PlaylistModel>
      _manualActionPlaylists; // needs to be a List<Playlist> and needs to change the input to select multiple playlists

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    _availablePlaylists = SongProvider().listPlaylists();

    List<SongModel> randomSongs = <SongModel>[];
    for (var i = 0; i < 8; i++) {
      randomSongs.add(SongProvider().poll());
    }
    _additionalSourceOptions = [
      PlaylistModel(name: 'Random', songs: randomSongs),
      PlaylistModel(name: 'Recommended', songs: randomSongs)
    ];

    super.initState();
  }

  Widget _buildSourceFromField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(labelText: 'Source Tracks From:'),
      items: (_additionalSourceOptions + _availablePlaylists)
          .map((PlaylistModel value) {
        return DropdownMenuItem(value: value, child: Text(value.name));
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: (newValue) {
        _sourcePlaylist = newValue as PlaylistModel;},
    );
  }

  Widget _buildSendToField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(labelText: 'Send Liked Tracks To:'),
      items: _availablePlaylists.map((PlaylistModel value) {
        return DropdownMenuItem(value: value, child: Text(value.name));
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'This field is required';
        }
        return null;
      },
      onChanged: (newValue) => _destPlaylist = newValue as PlaylistModel,
    );
  }

  Widget _buildManualSendField() {
    return MultiSelectDialogField(
      items: _availablePlaylists.map((PlaylistModel value) {
        return MultiSelectItem(value, value.name);
      }).toList(),
      validator: (value) {
        if (value == null) {
          return 'This field is required';
        }
        return null;
      },
      onConfirm: (newValues) =>
          _manualActionPlaylists = newValues as List<PlaylistModel>,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(24),
        child: Form(
            key: _formKey,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: _buildSourceFromField()),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: _buildSendToField()),
                  Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15),
                      child: _buildManualSendField()),
                  ElevatedButton(
                      child: const Text('Save', style: TextStyle(fontSize: 15)),
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          SongProvider().songProviderConfig.source = _sourcePlaylist;
                          SongProvider().songProviderConfig.destination = _destPlaylist;
                          SongProvider().songProviderConfig.manualDestinations = _manualActionPlaylists;
                          _formKey.currentState?.save();
                          print('Configurations were saved to SongProvider successfully');
                        }
                      }),
                ])));
  }
}
