class SongModel {
  const SongModel({
    required this.name,
    required this.album,
    required this.artist,
    required this.releaseYear,
    required this.coverImgUrl,
  });

  final String name;
  final String album;
  final String artist;
  final int releaseYear;
  final String coverImgUrl;
}