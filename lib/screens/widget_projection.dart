import 'package:ar_quido/ar_quido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class AROverlayWidget extends StatelessWidget {
  final Offset
      position; // Position where you want to place the dot on the screen

  const AROverlayWidget({Key? key, required this.position}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: position.dx,
      top: position.dy,
      child: Container(
        width: 50, // Dot size
        height: 50, // Dot size
        decoration: BoxDecoration(
          color: Colors.black,
          shape: BoxShape.circle,
        ),
      ),
    );
  }
}

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
   String anchorId = '';
  double x = 0, y = 0;
  double width = 1, height = 1;
  Matrix4 transform = Matrix4.identity();

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
  // functions to update the image projected when camera is opened

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Plugin example app'),
      ),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              ARQuidoView(
                referenceImageNames: _referenceImageNames,
                referenceVideoNames: [widget.videoPath],
                onImageDetected: (imageName) =>
                    _onImageDetected(context, imageName),
                onDetectedImageTapped: (imageName) =>
                    _onDetectedImageTapped(context, imageName),
              ),
              if (_recognizedImage != null)
              Positioned(
                left: x,
                top: y,
                child: Container(
                  transform: transform,
                  width: width,
                  height: height,
                  child: const MyHomePage(
                    title: 'Widgets in AR',
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
class MyHomePage extends StatefulWidget {
  const MyHomePage({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}
// what is being projected
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  void _incrementCounter() => setState(() => _counter++);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}