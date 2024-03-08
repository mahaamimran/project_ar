import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';
import 'package:project_ar/screens/onboarding_1.dart';
import 'package:project_ar/screens/scan_photo.dart';
import 'package:project_ar/screens/widget_projection.dart';

class NewAlbum extends StatefulWidget {
  const NewAlbum({super.key});

  @override
  State<NewAlbum> createState() => _NewAlbumState();
}

class _NewAlbumState extends State<NewAlbum> {
  TextEditingController searchTextController = TextEditingController();

  @override
  void dispose() {
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: ColorConstants.blackColorBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.blackColorBackground,
        title: Text(
          'New Album',
          style: CustomTextStyles.headingText1
              .copyWith(color: ColorConstants.whiteColor),
        ),
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
            Text(
              'Album Title',
              style: CustomTextStyles.headingText2
                  .copyWith(color: ColorConstants.whiteColor),
            ),
            SizedBox(height: 10),
            TextField(
              controller: searchTextController,
              style: CustomTextStyles.headingText3,
              decoration: InputDecoration(
                hintText: "Enter your album's title here",
                hintStyle:
                    CustomTextStyles.headingText3.copyWith(color: Colors.grey),
                fillColor: Color.fromRGBO(17, 24, 39, 1),
                filled: true,
                border: OutlineInputBorder(
                  borderSide: BorderSide.none,
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Container(
                    width: width * 0.4,
                    height: width * 0.4,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                        // border: 2px solid rgba(31, 41, 55, 1)
                        color: Color.fromRGBO(31, 41, 55, 1),
                        width: 2,
                      ),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.add_circle_outlined,
                            color: ColorConstants.redColor,
                            size: 50,
                          ),
                          onPressed: () {
                            // navigate to about screen
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ScanPhoto(),
                              ),
                            );
                          },
                        ),
                        Text(
                          'Add Photo or Video',
                          style: CustomTextStyles.headingText3.copyWith(
                            fontSize: width * 0.03,
                          ),
                        ),
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
