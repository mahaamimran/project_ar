import 'dart:io';

import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';
import 'package:project_ar/models/media_item.dart';
import 'package:project_ar/providers/data_provider.dart';
import 'package:project_ar/screens/scan_photo.dart';
import 'package:provider/provider.dart';
import 'package:video_thumbnail/video_thumbnail.dart'; // Import the video_thumbnail package

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
    //Provider.of<DataProvider>(context, listen: false).clearAllMediaItems(); 
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
        maxWidth: 128, // Specify the width of the thumbnail
        quality: 25,
      );
      return MemoryImage(thumbnail!);
    } else {
      return FileImage(File(mediaItem.path));
    }
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final mediaItems = Provider.of<DataProvider>(context).mediaItems;

    return Scaffold(
      backgroundColor: ColorConstants.blackColorBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.blackColorBackground,
        title: Text('New Album', style: CustomTextStyles.headingText1.copyWith(color: ColorConstants.whiteColor)),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConstants.whiteColor),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Album Title', style: CustomTextStyles.headingText2.copyWith(color: ColorConstants.whiteColor)),
            SizedBox(height: 10),
            TextField(
              controller: searchTextController,
              style: CustomTextStyles.headingText3,
              decoration: InputDecoration(
                hintText: "Enter your album's title here",
                hintStyle: CustomTextStyles.headingText3.copyWith(color: Colors.grey),
                fillColor: Color.fromRGBO(17, 24, 39, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: mediaItems.length + 1, // Include the "Add" button
                itemBuilder: (context, index) {
                  if (index == mediaItems.length) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(context, MaterialPageRoute(builder: (context) => const ScanPhoto()));
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800],
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Icon(Icons.add, color: Colors.white, size: 50),
                      ),
                    );
                  } else {
                    final mediaItem = mediaItems[index];
                    return FutureBuilder<ImageProvider>(
                      future: _getThumbnail(mediaItem),
                      builder: (BuildContext context, AsyncSnapshot<ImageProvider> snapshot) {
                        if (snapshot.connectionState == ConnectionState.done && snapshot.hasData) {
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
                          return Center(child: CircularProgressIndicator());
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
    );
  }
}
