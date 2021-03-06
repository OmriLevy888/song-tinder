class SongModel {
  const SongModel({
    required this.name,
    required this.album,
    required this.artist,
    required this.releaseYear,
    required this.coverImgUrl,
    this.soundPreviewURL,
  });

  final String name;
  final String album;
  final String artist;
  final String releaseYear;
  final String coverImgUrl;
  final String? soundPreviewURL;
}