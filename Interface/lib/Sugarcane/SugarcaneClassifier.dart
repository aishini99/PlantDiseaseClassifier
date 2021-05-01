import 'dart:io';

import 'package:flutter/material.dart';
import 'package:plant_classifier/buttons.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tflite/tflite.dart';

class SugarcaneClassifier extends StatefulWidget {
  static const String id = 'SugarcaneClassifier';
  @override
  _SugarcaneClassifierState createState() => _SugarcaneClassifierState();
}

class _SugarcaneClassifierState extends State<SugarcaneClassifier> {
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
        imageMean: 0.0,
        imageStd: 255.0
    );

    setState(() {
      _loading = false;
      _output = output;
    });
    symptoms(_output);
  }

  symptoms(List _output) async{
    var str=' ';
    var strc='''Sugarcane (Saccharum officinarum) family Gramineae (Poaceae) is widely grown crop in India.''';
    var strt="Uses:";
    var strr='''Sugarcane is used in making refined white sugar, in skin care as exfoliant ,bio-plastics, cane ethanol ,fertilizers and so on.''';
    var str1="Causes:";
    var str1c='''Leaf spots (eye spot)  in sugarcane are caused by pathogen Bipolaris sacchari.''';
    var str1t="Remedies:";
    var str1r='''Foliar application 0.2% copper oxychloride or 0.3% mancozeb with 2 to 3 sprayings at an interval of 10 to 15 days. 
     Spraying is to be done as per the severity of the disease.''';
    var str2="Causes";
    var str2c='''Red rot disease is caused by the fungus Glomerella tucumanensis (Colletotrichum falcatum).''';
    var str2t="Remedies:";
    var str2r='''Removal of the affected clumps at an early stage and soil drenching with  Carbendazim 50 WP (1 gm in 1 litre of water).
    The cut ends and entire setts should be dipped in a fungicide solution, such as one per cent Bordeaux mixture.
    Adopt sett treatment with Carbendazim before planting (Carbendazim 50 WP (0.5 gm in 1 litre of water) or Carbendazim 25 DS (1gm in 1 litre of water) along with 2.5 kg of Urea in 250 litre of water
   Use fungitoxic chemicals like Bavistan, Benomyl, Topsin and Aretan at 0.1 per cent for 18 min. at 52ºC for dipping setts which gave almost complete elimination of rot infection.''';
    var str3="Causes:";
    var str3c='''Brown rust of sugarcane is caused by a fungus, Puccinia melanocephala.
     Windblown spores of the pathogen infect leaves. Sugarcane grown in fields receiving recent applications of mill mud is typically very prone to rust.''';
    var str3t="Remedies:";
    var str3r='''Affected leaves should be remove and burn immediately
  Spray Tridemorph 1.0 litres or Mancozeb 2.0 kg/ha.
    Use dithane M 45 @ 2 g/lit for one spraying.
    Application of triazole or strobilurin or pyraclostrobin fungicide @ 3 g/ lit of water.''';
    var str4="Causes";
    var str4c='''The virus is transmitted by aphids, Melanaphis sacchari and Rhopalosiphum maidis, in a semi-persistent manner.''';
    var str4t="Remedies:";
    var str4r='''To avoid this disease first plant the setts in nursery and then transplant to main field
    Secondary transmission of the disease by insect vectors can be controlled by application of Malathion(0.1%) or Dimecron(0.2%).
    Soil application of carbofuran @2.0 kg./ha or phorate @ 6.0 kg./ha
    Two sprayings of malathion @ 1.5 kg /ha at monthly intervals during September and October''';

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
      model: 'assets/fruits/model.tflite',
      labels: 'assets/fruits/labels.txt',
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 2,
          backgroundColor: Colors.green[400],
          title: Text('Sugarcane Disease Classification', style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
              fontFamily: 'IndieFlower'
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
                  'Dectect Disease',
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w800,
                      fontSize: 28,
                      fontFamily: 'IndieFlower'),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  padding: EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      SizedBox(height: 10),
                      Container(
                        width: 400,
                        // height: 250,
                        child: Center(
                          child: _loading
                              ? Container(
                            width: 150,
                            child: Column(
                              children: <Widget>[
                                Container(
                                    height: 180,
                                    child: Image.asset(
                                      'assets/fruits.jpg',
                                      scale: 0.6,
                                    )),
                                SizedBox(
                                  height: 60,
                                ),
                              ],
                            ),
                          )
                              : Container(
                            child: Column(
                              children: <Widget>[
                                Container(
                                  height: 150,
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
                        ),
                      ),
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
