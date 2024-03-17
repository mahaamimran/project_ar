import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:project_ar/models/media_item.dart';
import 'package:project_ar/models/media_pair.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class DataProvider with ChangeNotifier {
  List<MediaItem> _mediaItems = [];
  List<MediaPair> _mediaPairs = [];
  List<MediaItem> get mediaItems => _mediaItems;
  List<MediaPair> get mediaPairs => _mediaPairs;

  Future<File> saveImageToDocumentsDirectory(File imageFile) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName = imageFile.uri.toFilePath().split('/').last;
    final imagePath = '${directory.path}/reference_images/$fileName';
    final savedImage = await imageFile.copy(imagePath);
    print('Saved image to $imagePath');
    return savedImage;
  }

  void addMediaPair(MediaPair pair) {
    _mediaPairs.add(pair);
    notifyListeners();
  }

  Future<void> addMediaItem(MediaItem item) async {
    final savedImageFile = await saveImageToDocumentsDirectory(File(item.path));
    final newItem = MediaItem(path: savedImageFile.path, type: item.type);
    _mediaItems.add(newItem);
    saveMediaToPreferences();
    notifyListeners();
  }

  void deleteMediaItem(String path) {
    _mediaItems.removeWhere((item) => item.path == path);
    saveMediaToPreferences();
    notifyListeners();
  }

  void clearAllMediaItems() {
    _mediaItems.clear();
    saveMediaToPreferences();
    notifyListeners();
  }

  Future<void> loadMediaFromPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String? mediaJson = prefs.getString('mediaItems');
    if (mediaJson != null) {
      Iterable decoded = json.decode(mediaJson);
      _mediaItems = decoded
          .map((item) => MediaItem(
              path: item['path'], type: MediaType.values[item['type']]))
          .toList();
      notifyListeners();
    }
  }

  void saveMediaToPreferences() async {
    final prefs = await SharedPreferences.getInstance();
    String encoded = json.encode(_mediaItems
        .map((item) => {'path': item.path, 'type': item.type.index})
        .toList());
    prefs.setString('mediaItems', encoded);
  }
}
