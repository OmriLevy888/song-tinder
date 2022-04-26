import 'package:flutter/material.dart';

enum ProviderOption { spotify, appleMusic }

class SettingsPageWidget extends StatefulWidget {
  const SettingsPageWidget({Key? key}) : super(key: key);

  @override
  State<SettingsPageWidget> createState() => _SettingsPageWidgetState();
}

class _SettingsPageWidgetState extends State<SettingsPageWidget> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Widget> _extendedProviderForm = <Widget>[];

  List<Widget> _buildSpotifyForm() {
    return [
      TextFormField(
        decoration:
            const InputDecoration(labelText: 'Enter Your Client ID Here:'),
      ),
      TextFormField(
          decoration: const InputDecoration(
              labelText: 'Endter Your Client Secret Here:')),
      ElevatedButton(
          onPressed: _submitSpotifySettings, child: const Text('Save'))
    ];
  }

  List<Widget> _buildAppleMusicForm() {
    return [
      TextFormField(
        decoration:
            const InputDecoration(labelText: 'Enter Your Key Identifier Here:'),
      ),
      TextFormField(
          decoration: const InputDecoration(
              labelText:
                  'Endter Your Issuer (iss) Registered Claim Key Here:')),
      ElevatedButton(
          onPressed: _submitAppleMusicSettings, child: const Text('Save'))
    ];
  }

  void _submitSpotifySettings() {
    // TODO
  }

  void _submitAppleMusicSettings() {
    // TODO
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
                            labelText:
                                'Choose Your Music Streaming Service:'),
                        items: const [
                          DropdownMenuItem(
                              value: ProviderOption.spotify,
                              child: Text('Spotify')),
                          DropdownMenuItem(
                              value: ProviderOption.appleMusic,
                              child: Text('AppleMusic'))
                        ],
                        onChanged: (newValue) {
                          print('$newValue was chosen as the music provider');
                          switch (newValue) {
                            case ProviderOption.spotify:
                              setState(() =>
                                  _extendedProviderForm = _buildSpotifyForm());
                              break;
                            case ProviderOption.appleMusic:
                              setState(() => _extendedProviderForm =
                                  _buildAppleMusicForm());
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
                builder: (context) => const SettingsPageWidget())));
  }
}
