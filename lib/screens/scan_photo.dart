import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;
import 'package:edge_detection/edge_detection.dart'; // Assuming you have edge_detection plugin
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';
import 'package:project_ar/models/media_item.dart';
import 'package:project_ar/screens/record_video.dart';

class ScanPhoto extends StatefulWidget {
  const ScanPhoto({super.key});

  @override
  State<ScanPhoto> createState() => _ScanPhotoState();
}

class _ScanPhotoState extends State<ScanPhoto> {
  Future<void> _scanPhoto(BuildContext context) async {
    final directory = await getApplicationDocumentsDirectory();
    final fileName =
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpg";
    final imagePath = p.join(
        directory.path, "reference_images", fileName); // Adjust path as needed

    // Ensure the directory exists
    final imageDirectory = Directory(p.dirname(imagePath));
    if (!await imageDirectory.exists()) {
      await imageDirectory.create(recursive: true);
    }

    try {
      final success = await EdgeDetection.detectEdge(
        imagePath,
        canUseGallery: false,
      );
      if (!success) {
        print('Edge detection failed or was cancelled.');
        return;
      }
      // Assuming edge detection was successful and the image is saved to `imagePath`
      print('Image saved to $imagePath');
    } catch (e) {
      print('Error during edge detection: $e');
      return; // Return early to prevent further execution
    }

    // Assuming MediaItem is a construct you have for handling media in your app
    final mediaItem = MediaItem(path: imagePath, type: MediaType.image);

    // Navigate to the RecordVideo page
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RecordVideo(photo: mediaItem)),
    );
  }

  Future<void> _importPhoto(BuildContext context) async {
    String imagePath = join((await getApplicationSupportDirectory()).path,
        "${(DateTime.now().millisecondsSinceEpoch / 1000).round()}.jpg");

    bool success = false;
    try {
      //Make sure to await the call to detectEdgeFromGallery.
      success = await EdgeDetection.detectEdgeFromGallery(imagePath);
      print("success: $success");
    } catch (e) {
      print(e);
    }

    final mediaItem = MediaItem(path: imagePath, type: MediaType.image);
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => RecordVideo(photo: mediaItem)));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColorBackground,
      appBar: AppBar(
        backgroundColor: ColorConstants.blackColorBackground,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          const SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // green circle with white text
              Container(
                width: 60,
                height: 60,
                decoration: const BoxDecoration(
                  color: ColorConstants.greenColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text('1', style: CustomTextStyles.headingText1),
                ),
              ),
              // dotted line in the middle
              Container(
                width: 50,
                height: 1,
                color: ColorConstants.greyColor,
              ),
              // red circle with white text
              Container(
                width: 50,
                height: 50,
                decoration: const BoxDecoration(
                  color: ColorConstants.greyColor,
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Text(
                    '2',
                    style: CustomTextStyles.headingText1.copyWith(
                      color: ColorConstants.whiteColor,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 100),
          // container with grey borders and two buttons inside, scan a photo and import a photo
          Container(
            width: 300,
            height: 300,
            decoration: BoxDecoration(
              border: Border.all(
                width: 1.5,
                color: ColorConstants.greyColor,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // grey image icon
                const Icon(
                  Icons.image,
                  color: ColorConstants.greyColor,
                  size: 100,
                ),
                // red button with white text
                ElevatedButton(
                  onPressed: () => _scanPhoto(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    backgroundColor: ColorConstants.redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Scan a Photo',
                    style: CustomTextStyles.headingText1.copyWith(
                      color: ColorConstants.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // black button with red border and red text
                ElevatedButton(
                  onPressed: () => _importPhoto(context),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    backgroundColor: ColorConstants.blackColorBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          const BorderSide(color: ColorConstants.redColor, width: 2),
                    ),
                  ),
                  child: Text(
                    'Import a Photo',
                    style: CustomTextStyles.headingText1.copyWith(
                      color: ColorConstants.redColor,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
