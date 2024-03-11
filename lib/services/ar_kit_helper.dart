import 'package:flutter/services.dart';

class ARKitHelper {
  static const platform = MethodChannel('com.yourcompany.project/arkit_helper');

  static Future<void> sendImageToARKit(Uint8List imageData) async {
    try {
      await platform.invokeMethod('sendImageToARKit', {'imageData': imageData});
    } on PlatformException catch (e) {
      print("Failed to send image to ARKit: '${e.message}'.");
    }
  }
}
