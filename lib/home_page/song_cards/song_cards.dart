import 'dart:collection';

import 'package:flutter/material.dart';
import '../../widgets/home_page_swipe_buttons.dart';
import '../song_provider.dart';
import 'song_card.dart';

class SongSwipeCards extends StatefulWidget {
  const SongSwipeCards({Key? key}) : super(key: key);

  @override
  State<SongSwipeCards> createState() => _SongSwipeCardsState();
}

class _SongSwipeCardsState extends State<SongSwipeCards> {
  late SongCard _head;
  late SongCard _back;
  final Queue<SongCard> _songQueue = Queue();

  @override
  void initState() {
    super.initState();
    _head = SongCard(song: SongProvider().poll());
    _back = SongCard(song: SongProvider().poll());
    for (int i = 0; i < 10; i++) {
      _songQueue.add(SongCard(song: SongProvider().poll()));
    }
  }

  void _onDragEnd(DraggableDetails drag) {
    if (drag.velocity.pixelsPerSecond.dx < 0) {
      _onSwipeLeft();
    } else {
      _onSwipeRight();
    }
    _advanceSongQueue();
  }

  void _onSwipeLeft() {
    debugPrint("Swiped left");
  }

  void _onSwipeRight() {
    debugPrint("Swiped right");
  }

  void _onSwipeUp() {
    debugPrint("Swiped up");
  }

  void _advanceSongQueue() {
    setState(() {
      _head = _back;
      _back = _songQueue.removeFirst();
      _songQueue.add(SongCard(song: SongProvider().poll()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Draggable(
        child: _head,
        feedback: _head,
        childWhenDragging: _back,
        onDragEnd: _onDragEnd,
      ),
      HomePageSwipeButtons(
        swipeRightButtonAction: () { _onSwipeRight(); _advanceSongQueue(); },
        swipeLeftButtonAction: () { _onSwipeLeft(); _advanceSongQueue(); },
        swipeUpButtonAction: () { _onSwipeUp(); _advanceSongQueue(); },
      )
    ]);
  }
}
