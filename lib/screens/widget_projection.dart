import 'package:ar_quido/ar_quido.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:project_ar/config/color_constants.dart';
import 'package:project_ar/config/text_styles.dart';

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
  // List of strings of video paths and image paths
  final List<String> referenceImageNames;
  final List<String> referenceVideoNames;

  WidgetProjectionPage({
    Key? key,
    required this.referenceImageNames,
    required this.referenceVideoNames,
  }) : super(key: key);

  @override
  _WidgetProjectionPageState createState() => _WidgetProjectionPageState();
}

class _WidgetProjectionPageState extends State<WidgetProjectionPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'See your videos come to life!',
          style: CustomTextStyles.headingText1,
        ),
        backgroundColor: ColorConstants.blackColorBackground,
      ),
      body: Builder(
        builder: (context) {
          return Stack(
            children: [
              ARQuidoView(
                referenceImageNames: widget.referenceImageNames,
                referenceVideoNames: widget.referenceVideoNames,
                onImageDetected: (imageName) {},
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
