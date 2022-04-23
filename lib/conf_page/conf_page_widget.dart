import 'package:flutter/material.dart';

class ConfPageWidget extends StatefulWidget {
  const ConfPageWidget({Key? key}) : super(key: key);

  @override
  State<ConfPageWidget> createState() => _ConfPageWidgetState();
}

class _ConfPageWidgetState extends State<ConfPageWidget> {
  final List<String> sourceFromPlaylist = [ 
    'Random',
    'Recommended',
    'Playlist #1',
    'Playlist #2'
  ];
  final List<String> sendToPlaylist = ['Playlist #1', 'Playlist #2'];
  final List<String> manualSendToPlaylists = ['Playlist #1', 'Playlist #2'];

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  Widget _buildSourceFromField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(labelText: 'Source Tracks From:'),
      items: sourceFromPlaylist.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) =>
          print('Source Playlist was changed to $newValue'),
    );
  }

  Widget _buildSendToField() {
    return DropdownButtonFormField(
      decoration: const InputDecoration(labelText: 'Send Liked Tracks To:'),
      items: sendToPlaylist.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) =>
          print('Destination Playlist was changed to $newValue'),
    );
  }

  Widget _buildManualSendField() {
    return DropdownButtonFormField(
      decoration:
          const InputDecoration(labelText: 'Set Tracks For Manual Action:'),
      items: manualSendToPlaylists.map((String value) {
        return DropdownMenuItem(value: value, child: Text(value));
      }).toList(),
      onChanged: (newValue) => print('Manual Action was changed to $newValue'),
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
                      onPressed: () =>
                          print('Save configurations button was pressed')),
                ])));
  }
}
