import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';

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
        appBar: AppBar(
          backgroundColor: ColorConstants.primaryColor,
          title:  Text('My Albums', style: CustomTextStyles.headingText1,),
        ),
        body: const Center(
          child: Text(
            'demo',
            style: TextStyle(fontSize: 20),
          ),
        ),
      );
  }
}