import 'package:flutter/material.dart';
import 'package:plant_classifier/Cassava/CassavaClassifier.dart';
import 'package:plant_classifier/Sugarcane/SugarcaneClassifier.dart';
import 'package:plant_classifier/mainScreen.dart';
import 'package:plant_classifier/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Image Classification',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      home: SplashPage(),
      routes: {
        SplashPage.id:(context) => SplashPage(),
        MainScreen.id:(context) => MainScreen(),
        CassavaClassifier.id:(context)=> CassavaClassifier(),
        SugarcaneClassifier.id:(context)=> SugarcaneClassifier(),
        
      },
    );
  }
}
