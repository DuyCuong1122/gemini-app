import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'common/routes/pages.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Gemini app',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      initialRoute: AppPages.APPlication,
      getPages: AppPages.routes,
    );
  }
}

