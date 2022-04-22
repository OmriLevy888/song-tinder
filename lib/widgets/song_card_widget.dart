import 'package:flutter/material.dart';
import 'package:song_tinder/models/models.dart';

class SongAttributeContainer extends StatelessWidget {
  const SongAttributeContainer(
      {Key? key, required Widget this.childItem})
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

class SongCardWidget extends StatelessWidget {
  // Replaces itemBuilder of SwipeCards, takes in SongModel
  const SongCardWidget({Key? key, required this.songData}) : super(key: key);

  final SongModel songData;

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [
              const Color.fromARGB(255, 170, 137, 117).withOpacity(1),
              const Color.fromARGB(95, 57, 38, 21).withOpacity(1)
            ])),
        alignment: Alignment.center,
        padding: const EdgeInsets.all(10),
        child: ListView(children: <Widget>[
          SongAttributeContainer(
              childItem: Image(
                  image: NetworkImage(songData.coverImgUrl),
                  fit: BoxFit.cover)),
          SongAttributeContainer(
              childItem:
                  Text(songData.name, style: const TextStyle(fontSize: 15, color: Colors.white))),
          SongAttributeContainer(
              childItem:
                  Text(songData.artist, style: const TextStyle(fontSize: 10, color: Colors.white))),
        ]));
  }
}
