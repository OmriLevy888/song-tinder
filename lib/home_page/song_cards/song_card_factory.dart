import 'dart:collection';

import 'package:palette_generator/palette_generator.dart';

import '../../models/song_model.dart';
import '../song_provider.dart';
import 'song_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class CardPrefetchedData {
  final Image coverImage;
  final PaletteGenerator paletteGenerator;
  final String artist;
  final String name;
  final String album;
  final int releaseYear;

  const CardPrefetchedData({
    required this.coverImage,
    required this.paletteGenerator,
    required this.artist,
    required this.name,
    required this.album,
    required this.releaseYear,
  });
}

enum SongCardType { loading, card }

class SongCardFactoryResult {
  final SongCardType type;
  final Widget card;

  const SongCardFactoryResult({required this.type, required this.card});
}

class LoadingCard extends StatelessWidget {
  const LoadingCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SpinKitWave(
              color: Theme.of(context).colorScheme.onPrimary,
              itemCount: MediaQuery.of(context).size.width ~/ 30,
              size: MediaQuery.of(context).size.width / 4,
            ),
            SizedBox(height: MediaQuery.of(context).size.height / 20,),
            Text(
              'Fetching songs',
              style: Theme.of(context).textTheme.displaySmall!,
            ),
          ],
        ));
  }
}

class SongCardFactory {
  static final SongCardFactory _instance = SongCardFactory._internal();

  factory SongCardFactory() => _instance;

  final Queue<CardPrefetchedData> _dataQueue = Queue();
  void Function(SongCard)? _callback;

  SongCardFactory._internal() {
    for (int i = 0; i < 16; i++) {
      _addCardToQueue();
    }
  }

  void _addCardToQueue() {
    final fetchedData = _fetchCardData(SongProvider().poll());
    fetchedData.then((data) {
      _dataQueue.add(data);
      _callback?.call(SongCard(data: data));
    });
  }

  Future<CardPrefetchedData> _fetchCardData(SongModel song) async {
    final coverImage = Image.network(song.coverImgUrl);
    final paletteGenerator =
        await PaletteGenerator.fromImageProvider(coverImage.image);

    return CardPrefetchedData(
      coverImage: coverImage,
      paletteGenerator: paletteGenerator,
      artist: song.artist,
      name: song.name,
      album: song.album,
      releaseYear: song.releaseYear,
    );
  }

  void registerLoadListener(void Function(SongCard) callback) {
    _callback = callback;
  }

  SongCardFactoryResult poll() {
    if (_dataQueue.isEmpty) {
      return const SongCardFactoryResult(
        type: SongCardType.loading,
        card: LoadingCard(),
      );
    }

    _addCardToQueue();
    return SongCardFactoryResult(
      type: SongCardType.card,
      card: SongCard(data: _dataQueue.removeFirst()),
    );
  }
}
