import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:player/test.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();

  // Blocker l'orientation vertical
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);

  // Navigation color change
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    systemNavigationBarColor: Colors.deepOrange,
    systemNavigationBarIconBrightness: Brightness.light,
  ));
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  // This widget is the root of your application.
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  bool isLoading = true;

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 1), () {
      setState(() {
        isLoading = false;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text(
            'La You Sound 😁',
          ),
        ),
        backgroundColor: Colors.white70,
        body: Test(),
      ),
    );
  }
}
