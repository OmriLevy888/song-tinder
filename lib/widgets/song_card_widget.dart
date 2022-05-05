import 'package:palette_generator/palette_generator.dart';

import 'package:flutter/material.dart';
import 'package:song_tinder/models/models.dart';

class SongAttributeContainer extends StatelessWidget {
  const SongAttributeContainer({Key? key, required Widget this.childItem})
      : super(key: key);

  final Widget childItem;

  @override
  Widget build(BuildContext context) {
    return Container(
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        child: childItem);
  }
}

class SongCardWidget extends StatefulWidget {
  const SongCardWidget({Key? key, required this.songData}) : super(key: key);

  final SongModel songData;

  @override
  State<SongCardWidget> createState() => _SongCardWidgetState();
}

class _SongCardWidgetState extends State<SongCardWidget> {
  late Future<PaletteGenerator> _paletteGenerator;

  @override
  void initState() {
    super.initState();
    _paletteGenerator = _createPaletteGeneratorAsync();
  }

  Future<PaletteGenerator> _createPaletteGeneratorAsync() async {
    final paletteGenerator = await PaletteGenerator.fromImageProvider(
        NetworkImage(widget.songData.coverImgUrl));
    return paletteGenerator;
  }

  Widget _buildSongCardWidget(List<Color> gradientColors) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                colors: gradientColors)),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          SongAttributeContainer(
              childItem: Image(
                  image: NetworkImage(widget.songData.coverImgUrl),
                  fit: BoxFit.cover)),
          SongAttributeContainer(
              childItem: Text(widget.songData.name,
                  style: Theme.of(context).textTheme.displayMedium)),
          SongAttributeContainer(
              childItem: Text(widget.songData.artist,
                  style: Theme.of(context).textTheme.displaySmall)),
        ]));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaletteGenerator>(
      future: _paletteGenerator,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.done:
            final paletteGenerator = snapshot.data!;
            return _buildSongCardWidget(<Color>[
              paletteGenerator.dominantColor!.color,
              paletteGenerator.mutedColor!.color,
            ]);
          default:
            return _buildSongCardWidget(<Color>[
              const Color.fromARGB(255, 170, 137, 117).withOpacity(1),
              const Color.fromARGB(95, 57, 38, 21).withOpacity(1),
            ]);
        }
      },
    );
  }
}
