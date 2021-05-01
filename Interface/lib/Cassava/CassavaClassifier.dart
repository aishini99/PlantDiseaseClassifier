import 'dart:io';
import 'package:flutter/material.dart';
import 'package:plant_classifier/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class CassavaClassifier extends StatefulWidget {
  static const String id = 'CassavaClassifier';

  @override
  _CassavaClassifierState createState() => _CassavaClassifierState();
}

class _CassavaClassifierState extends State<CassavaClassifier> {
  final picker = ImagePicker();
  File _image;
  bool _loading = false;
  List _output;
  String _str;
  String _strc;
  String _strt;
  String _strr;



  pickImage() async {
    var image = await picker.getImage(source: ImageSource.camera);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  pickGalleryImage() async {
    var image = await picker.getImage(source: ImageSource.gallery);

    if (image == null) return null;

    setState(() {
      _image = File(image.path);
    });
    classifyImage(_image);
  }

  @override
  void initState() {
    super.initState();
    _loading = true;
    loadModel().then((value) {
      // setState(() {});
    });
  }

  @override
  void dispose() {
    Tflite.close();
    super.dispose();
  }

  classifyImage(File image) async {
    var output = await Tflite.runModelOnImage(
        path: image.path,
        numResults: 5,
        threshold: 0.5,
        imageMean: 127.5,
        imageStd: 127.5);

    setState(() {
      _loading = false;
      _output = output;
    });
    symptoms(_output);
  }

  symptoms(List _output) async{
     var str='Causes:';
     var strc='''CBB is caused by the bacterium Xanthomonas axonopodis pv. manihotis (Bondar) Vauterin et al.''';
     var strt="Remedies:";
     var strr='''Foliar application of Pseudomonas fluorescens and P. putida has been reported to significantly to reduce leaf infection by X. axonopodis pv. manihotis.
      However, biological control is not yet a practical reality. ''';
     var str1="Causes:";
     var str1c='''CBSD is caused by the Cassava Brown Streak Virus (CBSV).
      CBSD may be transmitted  by mites and aphids.''';
     var str1t="Remedies:";
     var str1r='''Virus disease cannot be treated with chemical or biological application.
      However, insecticides could be used to reduce the population of vectors like mites and aphides.''';
     var str2="Causes";
     var str2c=''' CGM is caused by cassava green mottle virus which is a plant pathogenic virus of the family Secoviridae''';
     var str2t="Remedies:";
     var str2r=''' During the growing period and after harvest, destroy the infested stems outside of the field.
      Remove infested tips with hand pruners and destroy outside of the field''';
     var str3="Causes:";
     var str3c='''CMD is caused by a group of virus that often co-infest cassava plants.
     CMD may be transmitted by Whitefly Bemisia tabaci.''';
     var str3t="Remedies:";
     var str3r='''Active ingredients that have been reported to have effect in controlling whitefly population include bifenthrin, buprofezin, fenoxycarb, deltamethrin, azidirachtin and pymetrozine.
      Management of whitefly by installing yellow sticky traps, removal of weed hosts, spray neem oil 3% or Methyl dematon @ 2ml/lit.
      Spraying of systemic insecticide like dimethoate 1 ml/lit to control the vector''';
     var str4=" ";
     var str4c='''Cassava is a root vegetable''';
     var str4t="Uses:";
     var str4r="People use the root as a food and to make medicine.";

     if(_output[0]['index']==0){

       setState(() {
         _str = str;
         _strc=strc;
         _strt=strt;
         _strr=strr;
       });
     }
     else if(_output[0]['index']==1){

       setState(() {
         _str = str1;
         _strc=str1c;
         _strt=str1t;
         _strr=str1r;
       });
     }
     else if(_output[0]['index']==2){

       setState(() {
         _str = str2;
         _strc=str2c;
         _strt=str2t;
         _strr=str2r;
       });
     }
     else if(_output[0]['index']==3){

       setState(() {
         _str = str3;
         _strc=str3c;
         _strt=str3t;
         _strr=str3r;
       });
     }
     else if(_output[0]['index']==4){

       setState(() {
         _str = str4;
         _strc=str4c;
         _strt=str4t;
         _strr=str4r;
       });
     }

  }

  loadModel() async {
    await Tflite.loadModel(
      model: 'assets/flowers/model.tflite',
      labels: 'assets/flowers/labels.txt',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.green[400],
          title: Text('Cassava Diease Classification', style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            fontFamily: 'IndieFlower',
          ),),
          iconTheme: IconThemeData(
              color: Colors.white
          ),
          automaticallyImplyLeading: true,
          centerTitle: false,
        ),
        body: Container(
          height: 6200.0,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              stops: [0.004, 1],
              colors: [
                Color(0xFF000000),
                Color(0xFF3d3d3d),
              ],
            ),
          ),
           child: SingleChildScrollView( child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(height: 30),
                Text(
                  'Detect Disease',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontFamily: 'IndieFlower',
                      fontSize: 20),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        width: 400,
                        child: Center(
                          child: _loading
                              ? Container(
                                  width: 150,
                                  child: Column(
                                    children: <Widget>[
                                      Image.asset('assets/flowers.jpg'),
                                      SizedBox(
                                        height: 50,
                                      ),
                                    ],
                                  ),
                                )
                              : Container(
                                  child: Column(
                                    children: <Widget>[
                                      Container(
                                        height: 100,
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(10),
                                          child: Image.file(
                                            _image,
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 20,
                                      ),
                                      _output != null
                                          ? RichText(
                                      text: TextSpan(
                                      text: 'It\'s ${_output[0]['label']}',
                                      style: TextStyle(
                                         color: Colors.green[500],
                                         fontSize: 20.0,
                                         fontWeight: FontWeight.bold,
                                         fontFamily: 'IndieFlower'),
                                      children: <TextSpan>[
                                        TextSpan(text: '\n ${_str}', style: TextStyle(fontWeight: FontWeight.bold,
                                          color: Colors.yellow[300],
                                          fontSize: 18.0,
                                            fontFamily: 'IndieFlower')),
                                        TextSpan(text: '\n ${_strc}', style: TextStyle(fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontSize: 16.0,
                                            fontFamily: 'IndieFlower')),
                                        TextSpan(text: '\n ${_strt}', style: TextStyle(fontWeight: FontWeight.bold,
                                          color: Colors.yellow[300],
                                          fontSize: 18.0,
                                            fontFamily: 'IndieFlower')),
                                        TextSpan(text: '\n ${_strr}', style: TextStyle(fontStyle: FontStyle.italic,
                                          color: Colors.white,
                                          fontSize: 16.0,
                                            fontFamily: 'IndieFlower')),
                                       ],
                                       ),
                                       )


                                          : Container(),


                                      SizedBox(
                                        height: 20,
                                      ),
                                    ],
                                  ),
                                ),
                        ),
                      ),
                      Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              AppButton(
                                onClick: pickImage,
                                btnText: 'From Camera',
                              ),
                              SizedBox(height: 15),
                              AppButton(
                                onClick: pickGalleryImage,
                                btnText: 'From Gallery',
                              ),
                            ],
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
