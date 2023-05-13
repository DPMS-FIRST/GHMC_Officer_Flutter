import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ghmcofficerslogin/res/components/textwidget.dart';
import 'package:ghmcofficerslogin/res/constants/Images/image_constants.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:image_picker/image_picker.dart';

class ImageCapture extends StatefulWidget {
  const ImageCapture({super.key, required this.callbackValue});

  final void Function(XFile) callbackValue;

  @override
  State<ImageCapture> createState() => _ImageCaptureState();
}

class _ImageCaptureState extends State<ImageCapture> {
  File? _image;
  Future getImage(ImageSource type) async {
    final XFile? img = await ImagePicker().pickImage(source: type);
    setState(() {
      _image = File(img!.path);
      this.widget.callbackValue(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return _image != null
        ? Image.file(
            _image!,
            width: 70,
            height: 100,
            fit: BoxFit.cover,
          )
        : Padding(
            padding: const EdgeInsets.symmetric(vertical: 5.0),
            child: GestureDetector(
                onTap: () {
                  print("tap");
                  getImage(ImageSource.camera);
                },
                child: Image.asset(
                  ImageConstants.cam,
                  height: 100,
                  width: 100,
                )));
  }
}

class ShowImageCapture extends StatefulWidget {
  const ShowImageCapture({super.key, required this.callbackValue});

  final void Function(XFile) callbackValue;

  @override
  State<ShowImageCapture> createState() => _ShowImageCaptureState();
}

class _ShowImageCaptureState extends State<ShowImageCapture> {
  File? _image;
  final imagePickingOptions = [
    "Choose from Gallery",
    "Take Photo",
    "Choose Document",
    "cancel"
  ];
  var phototype = "";
  ValueNotifier<String?> imageSelect = ValueNotifier(null);
  /* Future getImage(ImageSource type) async {
    final XFile? img = await ImagePicker().pickImage(source: type);
    setState(() {
      _image = File(img!.path);
      this.widget.callbackValue(img);
    });
  } */
  Future getImage(ImageSource type) async {
    final XFile? img = await ImagePicker().pickImage(source: type);

    setState(() {
      _image = File(img!.path);
      this.widget.callbackValue(img);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _image != null
            ? Image.file(
                _image!,
                width: 70,
                height: 100,
                fit: BoxFit.cover,
              )
            : Padding(
                padding: const EdgeInsets.symmetric(vertical: 5.0),
                child: GestureDetector(
                    onTap: () {
                      selectImageAlert("Add Photo");
                    },
                    child: Image.asset(
                      ImageConstants.cam,
                      height: 100,
                      width: 100,
                    ))),
      ],
    );
  }

  selectImageAlert(String message, {String text = ""}) async {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color.fromARGB(255, 45, 88, 124),
            title: Center(
              child: TextWidget(
                text: message + text,
                left: 0,
                right: 0,
                top: 0,
                bottom: 0,
                fontsize: 15,
                textcolor: Colors.white,
              ),
            ),

            // title: Text(message + text),
            actions: [
              ValueListenableBuilder(
                valueListenable: imageSelect,
                builder: (context, value, child) {
                  return RadioGroup<String>.builder(
                    textStyle: TextStyle(color: Colors.white),
                    groupValue: value ?? "",
                    onChanged: (value) {
                      imageSelect.value = value;
                      phototype = imageSelect.value!;
                      if (value == "Choose Document") {
                        getImage(ImageSource.gallery);
                      } else if (value == "Take Photo") {
                        getImage(ImageSource.camera);
                      } else if (value == "Choose from Gallery") {
                        getImage(ImageSource.gallery);
                      } else if (value == "cancel") {
                        //Navigator.pop(context);
                      }
                      Navigator.pop(context);
                    },
                    items: imagePickingOptions,
                    itemBuilder: (item) => RadioButtonBuilder(
                      item,
                    ),
                  );
                },
              ),
            ],
          );
        });
    //showDialog
  }
}
