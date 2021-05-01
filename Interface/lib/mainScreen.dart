import 'package:flutter/material.dart';
import 'package:plant_classifier/buttons.dart';

import 'package:plant_classifier/Cassava/CassavaClassifier.dart';
import 'package:plant_classifier/Sugarcane/SugarcaneClassifier.dart';



class MainScreen extends StatefulWidget {
  static const String id = 'mainScreen';

  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.green[400],
          title: Text('Plant DiseaseS Classification', style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'IndieFlower'
          ),),
          automaticallyImplyLeading: false,
          centerTitle: true,
        ),
        backgroundColor: Colors.black,
        body: Container(
          margin: EdgeInsets.only(top: 25),
          child: ListView(
            shrinkWrap: true,
            children: [

              ListContent(
                text: 'Cassava Disease Classification',
                imagePath: 'assets/flowers.jpg',
                onClick: () {
                  Navigator.pushNamed(context, CassavaClassifier.id);
                },
              ),
              ListContent(
                text: 'Sugarcane Disease Classification',
                imagePath: 'assets/fruits.jpg',
                onClick: () {
                  Navigator.pushNamed(context, SugarcaneClassifier.id);
                },
              ),

            ],
          ),
        ),
      ),
    );
  }
}
