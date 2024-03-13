import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';
import 'package:project_ar/models/media_item.dart';
import 'package:project_ar/providers/data_provider.dart';
import 'package:project_ar/screens/scan_photo.dart';
import 'package:project_ar/screens/widget_projection.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart';

class NewAlbum extends StatefulWidget {
  const NewAlbum({Key? key}) : super(key: key);

  @override
  State<NewAlbum> createState() => _NewAlbumState();
}

class _NewAlbumState extends State<NewAlbum> {
  TextEditingController searchTextController = TextEditingController();
  // clear media items in initState
  @override
  void initState() {
    super.initState();
    //Provider.of<DataProvider>(context, listen: false).clearAllMediaPairs();
  }

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  Future<ImageProvider> _getThumbnail(MediaItem mediaItem) async {
    if (mediaItem.type == MediaType.video) {
      final thumbnail = await VideoThumbnail.thumbnailData(
        video: mediaItem.path,
        imageFormat: ImageFormat.JPEG,
        maxWidth: 128,
        quality: 100,
      );
      return MemoryImage(thumbnail!);
    } else {
      return FileImage(File(mediaItem.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final mediaPairs = Provider.of<DataProvider>(context).mediaPairs;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: ColorConstants.blackColorBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.blackColorBackground,
        title: Text('New Album',
            style: CustomTextStyles.headingText1
                .copyWith(color: ColorConstants.whiteColor)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConstants.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Album Title',
                    style: CustomTextStyles.headingText2
                        .copyWith(color: ColorConstants.whiteColor)),
                const SizedBox(height: 10),
                TextField(
                  controller: searchTextController,
                  style: CustomTextStyles.headingText3,
                  decoration: InputDecoration(
                    hintText: "Enter your album's title here",
                    hintStyle: CustomTextStyles.headingText3
                        .copyWith(color: Colors.grey),
                    fillColor: const Color.fromRGBO(17, 24, 39, 1),
                    filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide.none,
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 1, // each item square
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                    ),
                    itemCount: mediaPairs.length * 2 + 1, // add button
                    itemBuilder: (context, index) {
                      int pairIndex = index ~/ 2;
                      if (index == mediaPairs.length * 2) {
                        // The add button
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => const ScanPhoto()));
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: Colors.grey[800],
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: const Icon(Icons.add,
                                color: Colors.white, size: 50),
                          ),
                        );
                      } else if (index % 2 == 0) {
                        // Photo thumbnail
                        final mediaPair = mediaPairs[pairIndex];
                        return Container(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: FileImage(File(mediaPair.photo!.path)),
                              fit: BoxFit.cover,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),
                        );
                      } else {
                        // Video thumbnail with FutureBuilder
                        final mediaPair = mediaPairs[pairIndex];
                        return FutureBuilder<ImageProvider>(
                          future: _getThumbnail(mediaPair.video!),
                          builder: (BuildContext context,
                              AsyncSnapshot<ImageProvider> snapshot) {
                            if (snapshot.connectionState ==
                                    ConnectionState.done &&
                                snapshot.hasData) {
                              return Container(
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: snapshot.data!,
                                    fit: BoxFit.cover,
                                  ),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                              );
                            } else {
                              return const Center(
                                  child: CircularProgressIndicator());
                            }
                          },
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),

          // add floating action button at bottom center if MediaPairs is not empty
          if (mediaPairs.isNotEmpty)
            Positioned(
              bottom: 30,
              left: width / 2 - 40,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => WidgetProjectionPage(
                                  imagePath: mediaPairs[0].photo!.path,
                                  videoPath: mediaPairs[0].video!.path)));
                    },
                    child: Container(
                      width: 80,
                      height: 80,
                      decoration: const BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                      child:
                          const Icon(Icons.camera_alt, size: 32, color: Colors.white),
                    ),
                  ),
                  const SizedBox(width: 32), 
                  InkWell(
                    onTap: () {
                      // Trigger upload functionality
                    },
                    child: Container(
                      width: 50,
                      height: 50,
                      decoration: const BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.file_upload,
                          size: 24, color: Colors.black),
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
