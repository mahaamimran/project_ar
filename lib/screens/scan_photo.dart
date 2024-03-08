import 'package:flutter/material.dart';

class ScanPhoto extends StatelessWidget {
  const ScanPhoto({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Scan Image with Camera'),
      ),
      body: Center(),
    );
  }
}
