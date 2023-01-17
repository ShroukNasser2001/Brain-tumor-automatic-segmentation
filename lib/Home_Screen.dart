import 'dart:convert';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import 'button.dart';
import 'd.dart';
import 'n.dart';

//import 'iris_screen.dart';
//import 'homepage_code.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  String result = 'add photo';
  File? _image = null;
  final imagePicker = ImagePicker();
  Future getImage() async {
    final image = await imagePicker.getImage(source: ImageSource.camera);
    setState(() {
      _image = File(image!.path);
    });
  }

  File? _gallery = null;
  File? _cam = null;
  final CameraPicker = ImagePicker();
  final galleryPicker = ImagePicker();
  Future getPhoto() async {
    //final image = await galleryPicker.getImage(source: ImageSource.gallery);

    try {
      var pickedFile = await galleryPicker.pickImage(
        source: ImageSource.gallery,
      );
      if (pickedFile != null) {
        Uint8List bytes = await XFile(pickedFile.path).readAsBytes();
        //_gallery = XFile.fromData(bytes);
        await brightness(base64Encode(bytes)).then((value) {
          setState(() {
            if (value != null) result = value;
          });

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SizedBox(
                    height: 100.0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.teal,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                value!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
      }
      // setState(() {
      // _gallery = File(pickedFile!.path);
      // });

    } catch (e) {
      print('PickImage : $e');
    }
  }

  Future getCamera() async {
    //final image = await galleryPicker.getImage(source: ImageSource.gallery);

    try {
      var pickedFile = await CameraPicker.pickImage(
        source: ImageSource.camera,
      );
      if (pickedFile != null) {
        Uint8List bytes = await XFile(pickedFile.path).readAsBytes();
        //_gallery = XFile.fromData(bytes);
        await brightness(base64Encode(bytes)).then((value) {
          setState(() {
            if (value != null) result = value;
          });

          showDialog(
              context: context,
              builder: (BuildContext context) {
                return AlertDialog(
                  content: SizedBox(
                    height: 100.0,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: <Widget>[
                        Positioned(
                          right: -40.0,
                          top: -40.0,
                          child: InkResponse(
                            onTap: () {
                              Navigator.of(context).pop();
                            },
                            child: CircleAvatar(
                              child: Icon(Icons.close),
                              backgroundColor: Colors.teal,
                            ),
                          ),
                        ),
                        Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            children: <Widget>[
                              Text(
                                value!,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 35.0,
                                  color: Colors.teal,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
        });
      }
      // setState(() {
      // _gallery = File(pickedFile!.path);
      // });

    } catch (e) {
      print('PickImage : $e');
    }
  }

  int currentIndex = 0;
  int index = 0;
  var searchController = TextEditingController();
  List<Widget> screens = [/*HomePageCode() , IrisScreen()*/];

  void _showSelectPhotoOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(25.0),
        ),
      ),
      builder: (context) => DraggableScrollableSheet(
          initialChildSize: 0.28,
          maxChildSize: 0.4,
          minChildSize: 0.28,
          expand: false,
          builder: (context, scrollController) {
            return SingleChildScrollView(
              controller: scrollController,
              child: Container(
                // color: Colors.grey.shade300,
                padding: const EdgeInsets.all(20),
                child: Stack(
                  alignment: AlignmentDirectional.topCenter,
                  clipBehavior: Clip.none,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    Column(children: [
                      SelectPhoto(
                        onTap: () => getImage(),
                        icon: Icons.image,
                        textLabel: 'Browse Gallery',
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      const Center(
                        child: Text(
                          'OR',
                          style: TextStyle(fontSize: 18),
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      SelectPhoto(
                        onTap: () {
                          getImage();
                        },
                        icon: Icons.camera_alt_outlined,
                        textLabel: 'Use a Camera',
                      ),
                    ])
                  ],
                ),
              ),
            );
          }),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xeec99dbe),
      appBar: AppBar(
        centerTitle: true,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            /*Image.asset(
        //'assets/images/logo.png',
        scale: 12,
      ),*/
            const SizedBox(
              width: 10,
            ),
            const Text(
              'Image Recognetion',
              style: TextStyle(color: Colors.black),
            ),
          ],
        ),
        backgroundColor: Color(0xc9cd92d4), //<-- SEE HERE
      ),
      body: SafeArea(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, bottom: 30, top: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      SizedBox(
                        height: 30,
                      ),
                      Text(
                        'Set a photo',
                      ),
                      SizedBox(
                        height: 8,
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(
                height: 8,
              ),
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Center(
                  child: GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: () {
                      _showSelectPhotoOptions(context);
                    },
                    child: Center(
                      child: Container(
                          height: 270.0,
                          width: 270.0,
                          decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.grey.shade200,
                          ),
                          child: const Center(
                            child: Text(
                              'No image selected',
                              style: TextStyle(fontSize: 20),
                            ),
                          )),
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const Text(
                    'Anonymous',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  CommonButtons(
                    onTap: () => _showSelectPhotoOptions(context),
                    backgroundColor: Colors.black,
                    textColor: Colors.white,
                    textLabel: 'Add a Photo',
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );

    //body: screens[currentIndex],

    /* bottomNavigationBar: BottomNavigationBar(
        elevation: 30.0,
        backgroundColor: Colors.white,
        type: BottomNavigationBarType.fixed,
         //currentIndex: currentIndex,
        onTap: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        items: [
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home,
              color: Colors.teal,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.medical_services,
              color: Colors.teal,
            ),
            label: 'Iris',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: getImage,
              icon: const Icon(
                Icons.camera_alt,
                color: Colors.teal,
              ),
            ),
            label: 'Camera',
          ),
          BottomNavigationBarItem(
            icon: IconButton(
              onPressed: () {
                getPhoto();
              },
              icon: const Icon(
                Icons.photo,
                color: Colors.teal,
              ),
            ),
            label: 'Gallery',
          ),
        ],
      ),*/
  }

  Future<String?> brightness(String img) async {
    // var formData = FormData.fromMap({
    // "image":
    //});

    Dio dio = Dio(
      BaseOptions(
        baseUrl: 'https://bdd3-154-178-211-152.ngrok.io/',
        receiveDataWhenStatusError: true,
      ),
    );
    try {
      Response response = await dio.post('predict', data: {"image": img});
      //return APIResponse.fromJson(response.data);
      //var response = await dio.post('predict', data: formData);
      //Response response = await dio.post('imgProcessing.php');
      print(response.toString());
      //print(response.data);
      final map = jsonDecode(response.toString());
      print("grayLevels");
      final res = map['result'].toString();
      print(res);
      return res;
      //print(response.data.toString());
      //return img;
    } catch (e) {
      print("web Services ----> $e ");
    }
  }
}
