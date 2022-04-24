class AlbumModel {
  const AlbumModel({
    required this.name,
    required this.artist,
    required this.year,
    required this.songs,
  });

  final String name;
  final String artist;
  final int year;
  final List<String> songs;
}
