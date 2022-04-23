import 'package:flutter/material.dart';
import 'package:swipe_cards/draggable_card.dart';
import 'package:swipe_cards/swipe_cards.dart';
import 'widgets/widgets.dart';
import 'models/models.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Song Tinder',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        shadowColor: Colors.black.withAlpha(60),
      ),
      home: const MyHomePage(title: 'Song Tinder'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late MatchEngine _matchEngine;
  final _swipeItems = <SwipeItem>[];
  final _data = songData;
  int _index = 0;

  @override
  void initState() {
    for (int i = 0; i < _data.length; i++) {
      _swipeItems.add(SwipeItem(
        content: _data[i],
        likeAction: () => _onSwipeRight(),
        nopeAction: () => _onSwipeLeft(),
        superlikeAction: () => _onSwipeUp(),
        onSlideUpdate: (SlideRegion? region) async {},
      ));
    }

    _matchEngine = MatchEngine(swipeItems: _swipeItems);
    super.initState();
  }

  void _onSwipeRight() {
    final song = _data[_index % _data.length];
    print('Swiped right on ${song.name} by ${song.artist}');
  }

  void _onSwipeLeft() {
    final song = _data[_index % _data.length];
    print('Swiped left on ${song.name} by ${song.artist}');
  }

  void _onSwipeUp() {
    final song = _data[_index % _data.length];
    print('Swiped up on ${song.name} by ${song.artist}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Stack(alignment: Alignment.bottomCenter, children: [
        SwipeCards(
          matchEngine: _matchEngine,
          upSwipeAllowed: true,
          itemBuilder: (BuildContext context, int index) {
            _index = index;
            return SongCardWidget(songData: _data[index % _data.length]);
          },
          onStackFinished: () => print('Finished entire stack'),
          itemChanged: (SwipeItem item, int index) {
            print('1 Changed to ${_data[index % _data.length].name}');
            _swipeItems.add(
              SwipeItem(
                content: _data[index % _data.length],
                likeAction: () => _onSwipeRight(),
                nopeAction: () => _onSwipeLeft(),
                superlikeAction: () => _onSwipeUp(),
                onSlideUpdate: (SlideRegion? region) async => {},
              ),
            );
          },
        ),
        Container(
          padding: const EdgeInsets.only(left: 60.0, right: 60.0, bottom: 40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              CircleButton(
                radius: 30,
                color: const Color.fromARGB(255, 221, 0, 0),
                icon: Icons.close,
                onPressed: () {
                  _matchEngine.currentItem?.nope();
                  _onSwipeLeft();
                },
              ),
              CircleButton(
                radius: 25,
                color: const Color.fromARGB(255, 0, 181, 226),
                icon: Icons.menu,
                onPressed: () {
                  _matchEngine.currentItem?.superLike();
                  _onSwipeUp();
                },
                onLongPress: () => print('Configure swipe up'),
              ),
              CircleButton(
                radius: 30,
                color: const Color.fromARGB(255, 1, 202, 62),
                icon: Icons.favorite,
                onPressed: () {
                  _matchEngine.currentItem?.like();
                  _onSwipeRight();
                },
                onLongPress: () => print('Configure swipe right'),
              ),
            ],
          ),
        ),
      ]),
    );
  }
}
