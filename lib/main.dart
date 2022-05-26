import 'dart:io';
import 'package:flutter/services.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);


  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  File? image;
  Future pickImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if(image == null)return;
      final imageTemp = File(image.path);
      setState(()=> this.image = imageTemp);
    } on PlatformException catch(e){
      print("Failed to pick Image$e");
    }
  }Future pickCameraImage() async{
    try{
      final image = await ImagePicker().pickImage(source: ImageSource.camera);
      if(image == null)return;
      final imageTemp = File(image.path);
      setState(()=> this.image = imageTemp);
    } on PlatformException catch(e){
      print("Failed to pick Image$e");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Image Picker"),
      ),
      body: Center(
        child: Column(
          children: [
            MaterialButton(
              onPressed: () {
                pickImage();
              },
              color: Colors.blueAccent,
              child: const Text("Pick Image From Gallery",
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold
                ),),),
            MaterialButton(
                onPressed: () {
                  pickCameraImage();
                },
                color: Colors.blueAccent,
                child: const Text("Pick Image From Camera",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold
                    ))),
            SizedBox(height: 20,),
            image != null ? Image.file(image!):Text("No Image Selected")
            
          ],
        ),
      ),);
  }

}
