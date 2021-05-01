import 'package:flutter/material.dart';
import 'package:plant_classifier/catdog/catDogClassifier.dart';
import 'package:plant_classifier/flower/flowerClassifier.dart';
import 'package:plant_classifier/fruits/fruitsClassifier.dart';
import 'package:plant_classifier/mainScreen.dart';
import 'package:plant_classifier/gender/genderClassification.dart';
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
        //CatDogClassifier.id:(context) => CatDogClassifier(),
        FlowerClassifier.id:(context)=> FlowerClassifier(),
        FruitsClassifier.id:(context)=> FruitsClassifier(),
        //GenderClassification.id:(context)=> GenderClassification()
      },
    );
  }
}
