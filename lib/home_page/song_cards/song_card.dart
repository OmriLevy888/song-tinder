import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:song_tinder/models/models.dart';

class SongCard extends StatefulWidget {
  SongCard({Key? key, required SongModel song})
      : artist = song.artist,
        album = song.album,
        song = song.name,
        imageUrl = song.coverImgUrl,
        super(key: key);

  final String artist;
  final String album;
  final String song;
  final String imageUrl;

  @override
  State<SongCard> createState() => _SongCardState();
}

class _SongCardState extends State<SongCard> {
  late Future<PaletteGenerator> _paletteGenerator;

  @override
  initState() {
    debugPrint("initState for ${widget.song}");
    super.initState();
    _paletteGenerator = _createPaletteGenerator();
  }

  Future<PaletteGenerator> _createPaletteGenerator() async {
    debugPrint("Generating palette for ${widget.song}");
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
      height: (13 * MediaQuery.of(context).size.width) / 15,
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
        top: MediaQuery.of(context).size.height / 30,
        left: MediaQuery.of(context).size.width / 15,
        right: MediaQuery.of(context).size.width / 15,
        bottom: MediaQuery.of(context).size.height / 50,
      ),
    );
  }
}
