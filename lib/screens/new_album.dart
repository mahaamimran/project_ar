import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';

class NewAlbum extends StatefulWidget {
  const NewAlbum({super.key});

  @override
  State<NewAlbum> createState() => _NewAlbumState();
}

class _NewAlbumState extends State<NewAlbum> {
  final searchTextController = TextEditingController();



  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is removed from the
    // widget tree.
    searchTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.blackColorBackground,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: ColorConstants.blackColorBackground,
        title: Text(
          'New Album',
          style: CustomTextStyles.headingText1,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: ColorConstants.whiteColor),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView(
          children: [
            Text('Album Title', style: CustomTextStyles.headingText2),
            // text box
            TextField(
              controller: searchTextController,
              onChanged: (text) {
                print('First text field: $text (${text.characters.length})');
              },
            ),
          ],
        ),
      ),
    );
  }
}
