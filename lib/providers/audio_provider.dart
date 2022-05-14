import 'package:audioplayers/audioplayers.dart';

class AudioProvider {
  static final AudioProvider _instance = AudioProvider._internal();

  factory AudioProvider() {
    return _instance;
  }

  AudioProvider._internal();

  AudioPlayer audioPlayer = AudioPlayer();
}
