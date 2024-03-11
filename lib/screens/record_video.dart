import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';
import 'package:project_ar/models/media_item.dart';
import 'package:project_ar/models/media_pair.dart';
import 'package:project_ar/providers/data_provider.dart';
import 'package:project_ar/screens/new_album.dart';
import 'package:provider/provider.dart';

class RecordVideo extends StatefulWidget {
  final MediaItem photo; // Photo passed as a parameter

  const RecordVideo({Key? key, required this.photo}) : super(key: key);

  @override
  State<RecordVideo> createState() => _RecordVideoState();
}

class _RecordVideoState extends State<RecordVideo> {
  File? _video;
  Future<void> _recordVideo() async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? recordedVideo =
          await picker.pickVideo(source: ImageSource.camera);

      if (recordedVideo != null) {
        setState(() {
          _video = File(recordedVideo.path);
        });

        final mediaItem = MediaItem(path: recordedVideo.path, type: MediaType.video);
        final mediaPair = MediaPair(photo: widget.photo, video: mediaItem);
        Provider.of<DataProvider>(context, listen: false).addMediaPair(mediaPair);

        Navigator.push(context, MaterialPageRoute(builder: (context) => NewAlbum()));
      } else {
        print('No video recorded.');
      }
    } catch (e) {
      print('Failed to record video: $e');
    }
  }

  Future<void> _importVideo() async {
    final ImagePicker picker = ImagePicker();
    final XFile? pickedVideo =
        await picker.pickVideo(source: ImageSource.gallery);

    if (pickedVideo != null) {
      setState(() {
        _video = File(pickedVideo.path);
      });

      final mediaItem = MediaItem(path: pickedVideo.path, type: MediaType.video);
      final mediaPair = MediaPair(photo: widget.photo, video: mediaItem);
      Provider.of<DataProvider>(context, listen: false).addMediaPair(mediaPair);

        Navigator.push(context, MaterialPageRoute(builder: (context) => NewAlbum()));
    } else {
      print('No video selected.');
    }
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
          SizedBox(height: 50),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // green circle with white text
              Container(
                width: 50,
                height: 50,
                decoration: BoxDecoration(
                  color: ColorConstants.greyColor,
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
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                  color: ColorConstants.greenColor,
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
                  onPressed: _recordVideo,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    backgroundColor: ColorConstants.redColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text(
                    'Record a Video',
                    style: CustomTextStyles.headingText1.copyWith(
                      color: ColorConstants.whiteColor,
                      fontSize: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                // black button with red border and red text
                ElevatedButton(
                  onPressed: _importVideo,
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10),
                    backgroundColor: ColorConstants.blackColorBackground,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side:
                          BorderSide(color: ColorConstants.redColor, width: 2),
                    ),
                  ),
                  child: Text(
                    'Import a Video',
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
