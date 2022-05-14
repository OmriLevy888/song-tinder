import 'package:flutter/material.dart';
import 'package:song_tinder/home_page/song_cards/song_card_factory.dart';
import 'package:song_tinder/providers/audio_provider.dart';
import 'swipe_buttons.dart';
import 'song_card.dart';

class SongSwipeCards extends StatefulWidget {
  const SongSwipeCards({Key? key}) : super(key: key);

  @override
  State<SongSwipeCards> createState() => _SongSwipeCardsState();
}

class _SongSwipeCardsState extends State<SongSwipeCards> {
  late SongCardFactoryResult _head;
  late SongCardFactoryResult _back;
  late bool _enabled;
  DragState _dragState = DragState();

  @override
  void initState() {
    super.initState();
    SongCardFactory().registerLoadListener(_onCardLoaded);
    _head = SongCardFactory().poll();
    _back = SongCardFactory().poll();

    _enabled = _head.type == SongCardType.card;
  }

  void _onCardLoaded(SongCard card) {
    AudioProvider().audioPlayer.stop();
    debugPrint("Loaded ${card.song}");
    if (_head.type == SongCardType.loading) {
      setState(() {
        _head = SongCardFactoryResult(type: SongCardType.card, card: card);
        _enabled = true;
      });
    } else if (_back.type == SongCardType.loading) {
      setState(() {
        _back = SongCardFactoryResult(type: SongCardType.card, card: card);
      });
    }
    if ((_head.card as SongCard).soundPreviewURL != null) {
      AudioProvider().audioPlayer.play((_head.card as SongCard).soundPreviewURL!);
    }
  }

  void _onDragEnd(DraggableDetails drag) {
    if (drag.offset.dx.abs() > 50) {
      if (drag.velocity.pixelsPerSecond.dx < 0) {
        _onSwipeLeft();
      } else {
        _onSwipeRight();
      }
      _advanceSongQueue();
    } else if (drag.offset.dy < -20) {
      _onSwipeUp();
      _advanceSongQueue();
    }
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
      _back = SongCardFactory().poll();
      _enabled = _head.type == SongCardType.card;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Stack(alignment: Alignment.bottomCenter, children: [
      Draggable<SongCard>(
        child: _head.card,
        feedback: _head.card,
        childWhenDragging: _back.card,
        onDragStarted: () => setState(() {
          _dragState = DragState();
        }),
        onDragEnd: _onDragEnd,
        onDragUpdate: (DragUpdateDetails drag) => setState(() {
          _dragState.onDragUpdate(drag);
        }),
        onDraggableCanceled: (Velocity velocity, Offset offset) => setState(() {
          _dragState = DragState();
        }),
      ),
      SwipeButtons(
        dragState: _dragState,
        swipeRightButtonAction: _enabled
            ? () {
                _onSwipeRight();
                _advanceSongQueue();
              }
            : null,
        swipeLeftButtonAction: _enabled
            ? () {
                _onSwipeLeft();
                _advanceSongQueue();
              }
            : null,
        swipeUpButtonAction: _enabled
            ? () {
                _onSwipeUp();
                _advanceSongQueue();
              }
            : null,
        enabled: _enabled,
      )
    ]);
  }
}
