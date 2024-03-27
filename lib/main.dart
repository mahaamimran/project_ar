import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:project_ar/providers/data_provider.dart';
import 'package:project_ar/providers/settings_provider.dart';
import 'package:project_ar/screens/my_albums.dart';
import 'package:project_ar/screens/new_album.dart';
import 'package:project_ar/screens/widget_projection.dart';
import 'package:provider/provider.dart';
import 'package:ar_quido/ar_quido.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final dataProvider = DataProvider();
  final settingsProvider = SettingsProvider();
  await dataProvider.loadMediaFromPreferences();
  dataProvider.clearAllMediaItems();
  

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => dataProvider),
        ChangeNotifierProvider(create: (context) => settingsProvider),
      ],
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
   