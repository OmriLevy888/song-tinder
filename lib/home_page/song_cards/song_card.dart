import 'package:flutter/material.dart';
import 'package:palette_generator/palette_generator.dart';
import 'package:song_tinder/home_page/song_cards/song_card_factory.dart';

class SongCard extends StatelessWidget {
  SongCard({Key? key, required CardPrefetchedData data})
      : artist = data.artist,
        album = data.album,
        song = data.name,
        coverImage = data.coverImage,
        paletteGenerator = data.paletteGenerator,
        soundPreviewURL = data.soundPreviewURL,
        super(key: key);

  final String artist;
  final String album;
  final String song;
  final Image coverImage;
  final PaletteGenerator paletteGenerator;
  final String? soundPreviewURL;

  @override
  Widget build(BuildContext context) {
    return Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height -
            (MediaQuery.of(context).size.height / 5),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: <Color>[
              paletteGenerator.dominantColor!.color,
              paletteGenerator.mutedColor!.color,
            ],
          ),
        ),
        child: Column(
          children: [
            SongImage(coverImage: coverImage),
            Text(song, style: Theme.of(context).textTheme.displayMedium),
            Text(artist, style: Theme.of(context).textTheme.displaySmall),
          ],
        ));
  }
}

class SongImage extends StatelessWidget {
  const SongImage({
    Key? key,
    required this.coverImage,
  }) : super(key: key);

  final Image coverImage;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: (13 * MediaQuery.of(context).size.width) / 15,
      decoration: BoxDecoration(
        image: DecorationImage(image: coverImage.image, fit: BoxFit.cover),
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
