import 'package:flutter/services.dart';

Future<void> addImageForTracking(String imagePath) async {
  const platform = MethodChannel('com.yourcompany/arkit_channel');
  try {
    await platform.invokeMethod('addImageForTracking', {'imagePath': imagePath});
  } on PlatformException catch (e) {
    print("Failed to add image for tracking: '${e.message}'.");
  }
}
