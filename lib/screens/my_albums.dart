import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';
import 'package:project_ar/screens/about.dart';
import 'package:project_ar/screens/new_album.dart';

class MyAlbums extends StatefulWidget {
  const MyAlbums({super.key});

  @override
  State<MyAlbums> createState() => _MyAlbumsState();
}

class _MyAlbumsState extends State<MyAlbums> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.primaryColor,
      appBar: appBar(),
      body: body(),
    );
  }

  AppBar appBar() {
    return AppBar(
      centerTitle: true,
      backgroundColor: ColorConstants.primaryColor,
      title: Text(
        'My Albums',
        style: CustomTextStyles.headingText1,
      ),
      actions: [
        IconButton(
          onPressed: () {
            // navigate to about screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const About(),
              ),
            );
            
          },
          icon: const Icon(
            Icons.list,
            color: ColorConstants.whiteColor,
          ),
        ),
      ],
    );
  }

  Widget body() {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Container(
        // container has border light grey only and rounded corners
        width: width * 0.8,
        height: height * 0.38,
        decoration: BoxDecoration(
          border: Border.all(
            width:  1.5,
            color: ColorConstants.greyColor,
          ),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // add image here
            const Icon(
              Icons.image,
              size: 100,
              color: ColorConstants.greyColor,
            ),
            const SizedBox(height: 5),
            // let's start text
            Text(
              'Let\'s Start!',
              style: CustomTextStyles.headingText1,
            ),
            Text(
              'Create your first album',
              style: CustomTextStyles.headingText3,
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Navigate to new album
                 Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const NewAlbum(),
              ),
            );
              },
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(horizontal: 35, vertical: 10), 
                backgroundColor: ColorConstants.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              child: Text(
                'Create',
                style: CustomTextStyles.headingText1.copyWith(
                  color: ColorConstants.whiteColor,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
