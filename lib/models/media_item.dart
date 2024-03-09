class MediaItem {
  final String path;
  final MediaType type;

  MediaItem({required this.path, required this.type});
}

enum MediaType { image, video }
