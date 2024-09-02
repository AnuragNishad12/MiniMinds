import 'package:flutter/material.dart';
import 'package:mini_minds/EnglishComponents/FrontEnglishPage.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Language Selection App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home:FrontEnglishPage(),
      // home: AZScreen(),
    );
  }
}




