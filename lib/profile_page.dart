import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class ProfilePage extends StatefulWidget {

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  File? imgFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Container(
          margin: EdgeInsets.all(11),
          width: 30,
          height: 30,
          decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                    color: Colors.amber,
                    blurRadius: 2,
                    spreadRadius: 1
                )
              ],
              shape: BoxShape.circle,
              image: imgFile != null ? DecorationImage(image: FileImage(imgFile!)):null,
              border: Border.all(
                  width: 1,
                  color: Colors.amber
              )
          ),
        ),
        title: Text('Profile'),
      ),
      body: Center(
        child: InkWell(
          onTap: () async{
            XFile? imgPicked = await ImagePicker().pickImage(source: ImageSource.gallery);

            if(imgPicked!=null){
              CroppedFile? croppedFile = await ImageCropper().cropImage(sourcePath: imgPicked.path, uiSettings: [
                AndroidUiSettings(
                  toolbarTitle: 'Cropper',
                  toolbarColor: Colors.deepOrange,
                  toolbarWidgetColor: Colors.white,
                  aspectRatioPresets: [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                  ],
                ),
                IOSUiSettings(
                  title: 'Cropper',
                  aspectRatioPresets: [
                    CropAspectRatioPreset.original,
                    CropAspectRatioPreset.square,
                  ],
                ),
                WebUiSettings(
                  context: context,
                ),
              ]);

              if(croppedFile!=null){
                imgFile = File(croppedFile.path);
                setState(() {

                });
              }
            }

          },
          child: Container(
            width: 200,
            height: 200,
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.amber,
                  blurRadius: 21,
                  spreadRadius: 2
                )
              ],
              shape: BoxShape.circle,
              image: imgFile != null ? DecorationImage(image: FileImage(imgFile!)):null,
              border: Border.all(
                width: 4,
                color: Colors.amber
              )
            ),
          ),
        ),
      ),
    );
  }
}
