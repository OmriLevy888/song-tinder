import 'package:flutter/material.dart';
import 'package:song_tinder/providers/song_provider.dart';

class SettingsPageWidget extends StatefulWidget {
  SettingsPageWidget({Key? key}) : super(key: key);

  @override
  State<SettingsPageWidget> createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Widget> _extendedProviderForm = <Widget>[];

  MusicServices _service = MusicServices.spotify;

  final _spotifyIDController = TextEditingController();
  final _spotifyClientSectetController = TextEditingController();
  final _appleMusicKeyIdentifierController = TextEditingController();
  final _appleMusicISSController = TextEditingController();

  List<Widget> _buildSpotifyForm() {
    return [
      ElevatedButton(
          onPressed: _submitMusicServiceSettings, child: const Text('Save'))
    ];
  }

  List<Widget> _buildAppleMusicForm() {
    return [
      TextFormField(
        controller: _appleMusicKeyIdentifierController,
        decoration:
            const InputDecoration(labelText: 'Enter Your Key Identifier Here:'),
      ),
      TextFormField(
          controller: _appleMusicISSController,
          decoration: const InputDecoration(
              labelText: 'Enter Your Issuer (iss) Registered Claim Key Here:')),
      ElevatedButton(
          onPressed: _submitMusicServiceSettings, child: const Text('Save'))
    ];
  }

  void _submitMusicServiceSettings() {
    switch (_service) {
      case MusicServices.spotify:
        SongProvider().setMusicServiceConfig(MusicServiceConfig(
          service: _service,
        ));
        break;
      case MusicServices.appleMusic:
        SongProvider().setMusicServiceConfig(MusicServiceConfig(
          service: _service,
          appleMusicKeyIdentifier: _appleMusicKeyIdentifierController.text,
          appleMusicISS: _appleMusicISSController.text,
        ));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text('Settings Page')),
        body: Container(
            margin: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    DropdownButtonFormField(
                        decoration: const InputDecoration(
                            labelText: 'Choose Your Music Streaming Service:'),
                        items: const [
                          DropdownMenuItem(
                              value: MusicServices.spotify,
                              child: Text('Spotify')),
                          DropdownMenuItem(
                              value: MusicServices.appleMusic,
                              child: Text('AppleMusic'))
                        ],
                        onChanged: (newValue) {
                          print('$newValue was chosen as the music provider');
                          switch (newValue) {
                            case MusicServices.spotify:
                              setState(() {
                                _service = MusicServices.spotify;
                                _extendedProviderForm = _buildSpotifyForm();
                              });
                              break;
                            case MusicServices.appleMusic:
                              setState(() {
                                _service = MusicServices.appleMusic;
                                _extendedProviderForm = _buildAppleMusicForm();
                              });
                              break;
                          }
                        }),
                    Column(
                      children: _extendedProviderForm,
                    )
                  ]),
            )));
  }
}

class SettingsButton extends StatelessWidget {
  const SettingsButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IconButton(
        icon: const Icon(Icons.settings),
        onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    SettingsPageWidget())));
  }
}
