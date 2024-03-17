
import 'package:ar_quido/ar_quido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class WidgetProjectionPage extends StatefulWidget {
  final String imagePath;
  final String videoPath;

  const WidgetProjectionPage({
    Key? key,
    required this.imagePath,
    required this.videoPath,
  }) : super(key: key);

  @override
  _WidgetProjectionPageState createState() => _WidgetProjectionPageState();
}


class _WidgetProjectionPageState extends State<WidgetProjectionPage> {
  String? _recognizedImage;
  final List<String> _referenceImageNames = [];

  @override
  void initState() {
    super.initState();
    _referenceImageNames.add(widget.imagePath);
  }
  void _onImageDetected(BuildContext context, String? imageName) {
    if (imageName != null && _recognizedImage != imageName) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Recognized image: $imageName'),
          duration: const Duration(milliseconds: 2500),
        ),
      );
    }
    setState(() {
      _recognizedImage = imageName;
    });
  }

  void _onDetectedImageTapped(BuildContext context, String? imageName) {
    if (imageName != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Tapped on image: $imageName'),
          duration: const Duration(milliseconds: 1500),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Builder(
          builder: (context) {
            return Stack(
              children: [
                ARQuidoView(
                  referenceImageNames: _referenceImageNames,
                  onImageDetected: (imageName) =>
                      _onImageDetected(context, imageName),
                  onDetectedImageTapped: (imageName) =>
                      _onDetectedImageTapped(context, imageName),
                ),
              ],
            );
          },
        ),
    );
  }
}
