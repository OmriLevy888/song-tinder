import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';

class SongCard extends StatefulWidget {
  const SongCard({
    Key? key,
    required this.artist,
    required this.song,
    required this.imageUrl,
  }) : super(key: key);

  final String artist;
  final String song;
  final String imageUrl;

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  late Future<PaletteGenerator> _paletteGenerator;

  @override
  initState() {
    super.initState();
    _paletteGenerator = _createPaletteGenerator();
  }

  Future<PaletteGenerator> _createPaletteGenerator() async {
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(NetworkImage(widget.imageUrl));
    return paletteGenerator;
  }

  Widget _buildSongCard(List<Color> garientColors) {
    return Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: garientColors),
        ),
        child: Column(
          children: [
            SongImage(imageUrl: widget.imageUrl),
            Text(widget.song, style: Theme.of(context).textTheme.displayMedium),
            Text(widget.artist,
                style: Theme.of(context).textTheme.displaySmall),
          ],
        ));
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<PaletteGenerator>(
        future: _paletteGenerator,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final paletteGenerator = snapshot.data!;
              return _buildSongCard(<Color>[
                paletteGenerator.dominantColor!.color,
                paletteGenerator.mutedColor!.color,
              ]);
            default:
              return _buildSongCard(<Color>[
                Theme.of(context).colorScheme.secondary,
                Theme.of(context).colorScheme.onSecondary,
              ]);
          }
        });
  }
}

class SongImage extends StatelessWidget {
  const SongImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  final String imageUrl;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height / 2,
      decoration: BoxDecoration(
        image:
            DecorationImage(image: NetworkImage(imageUrl), fit: BoxFit.cover),
        borderRadius: BorderRadius.circular(3),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context).colorScheme.shadow,
            spreadRadius: 4,
            blurRadius: 4,
            offset: const Offset(2, 2),
          )
        ],
      ),
      alignment: Alignment.center,
      margin: EdgeInsets.only(
        top: MediaQuery.of(context).size.height / 40,
        left: MediaQuery.of(context).size.width / 15,
        right: MediaQuery.of(context).size.width / 15,
        bottom: MediaQuery.of(context).size.height / 50,
      ),
    );
  }
}
