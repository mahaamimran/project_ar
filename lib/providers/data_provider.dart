import 'package:flutter/material.dart';
import 'package:project_ar/models/media_item.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataProvider with ChangeNotifier {
  List<MediaItem> _mediaItems = [];

  List<MediaItem> get mediaItems => _mediaItems;

  void addMediaItem(MediaItem item) {
    _mediaItems.add(item);
    saveMediaToPreferences();
    notifyListeners();
  }

  void deleteMediaItem(String path) {
    _mediaItems.removeWhere((item) => item.path == path);
    saveMediaToPreferences();
    notifyListeners();
  }

  Future<void> loadMediaFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? mediaJson = prefs.getString('mediaItems');
    if (mediaJson != null) {
      Iterable decoded = json.decode(mediaJson);
      _mediaItems = decoded.map((item) => MediaItem(path: item['path'], type: MediaType.values[item['type']])).toList();
      notifyListeners();
    }
  }

  void saveMediaToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String encoded = json.encode(_mediaItems.map((item) => {'path': item.path, 'type': item.type.index}).toList());
    prefs.setString('mediaItems', encoded);
  }
}
