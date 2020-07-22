import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File) imagePickFn;

  const UserImagePicker(this.imagePickFn);

  @override
  _UserImagePickerState createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File _image;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickerFile = await picker.getImage(
      source: ImageSource.camera,
      imageQuality: 40,
      maxWidth: 150,
    );
    setState(() {
      _image = File(pickerFile.path);
    });
    widget.imagePickFn(_image);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        CircleAvatar(
          radius: 60,
          backgroundColor: Colors.grey[500],
          backgroundImage: _image != null ? FileImage(_image) : null,
        ),
        FlatButton.icon(
          onPressed: _pickImage,
          textColor: Theme.of(context).primaryColor,
          icon: Icon(Icons.save),
          label: Text('Add Image'),
        ),
      ],
    );
  }
}
