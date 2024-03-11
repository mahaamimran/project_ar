import 'package:flutter/services.dart';

class ARKitHelper {
  static const MethodChannel _channel = MethodChannel('com.example.yourapp/arkit');

  static Future<void> updateTrackingImages(String imagePath) async {
    try {
      await _channel.invokeMethod('updateTrackingImages', {'imagePath': imagePath});
    } on PlatformException catch (e) {
      print("Failed to update AR tracking images: '${e.message}'.");
    }
  }
}
