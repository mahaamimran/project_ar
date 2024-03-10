import 'package:flutter/material.dart';
import 'package:project_ar/providers/data_provider.dart';
import 'package:project_ar/screens/my_albums.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataProvider = DataProvider();
  await dataProvider.loadMediaFromPreferences();
  dataProvider.clearAllMediaItems();
  

  runApp(
    ChangeNotifierProvider(
      create: (context) => dataProvider,
      child: MyApp(),
    ),
  );
}


class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  MyAppState createState() => MyAppState();
}

class MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: MyAlbums(),
      debugShowCheckedModeBanner: false,
    );
  }
}
   