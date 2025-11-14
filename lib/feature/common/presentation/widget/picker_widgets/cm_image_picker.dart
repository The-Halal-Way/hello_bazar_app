import 'package:flutter/material.dart';
import 'package:hello_bazar/core/constants/my_color.dart';
import 'package:hello_bazar/core/constants/my_image.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class CmImagePicker extends StatefulWidget {
  const CmImagePicker({super.key, required this.imagePickFn});
  final Function imagePickFn;
  @override
  State<CmImagePicker> createState() => _CmImagePickerState();
}

class _CmImagePickerState extends State<CmImagePicker> {
  File? _pickedImage;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _circleAvatar(),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _imageIcon(ImageSource.camera, Icons.camera_alt_sharp),
              const Text(
                'Add image',
                style: TextStyle(color: MyColor.gray500),
              ),
              _imageIcon(ImageSource.gallery, Icons.image),
            ],
          ),
        ],
      ),
    );
  }

  Widget _circleAvatar() => CircleAvatar(
        radius: 47,
        backgroundColor: MyColor.gray300,
        child: _pickedImage == null
            ? const CircleAvatar(
                radius: 46.5,
                backgroundImage: AssetImage(MyImage.imagePlaceHolder),
              )
            : CircleAvatar(
                radius: 46.5,
                backgroundImage: FileImage(_pickedImage!),
              ),
      );

  Widget _imageIcon(ImageSource source, IconData icon) => IconButton(
        onPressed: () => _pickImage(source),
        icon: Icon(icon, color: MyColor.gray900),
      );

  void _pickImage(ImageSource source) async {
    final pickedImageFile = await ImagePicker()
        .pickImage(source: source, maxHeight: 640, maxWidth: 640);
    if (pickedImageFile != null) {
      _pickedImage = File(pickedImageFile.path);
      widget.imagePickFn(_pickedImage);
    }
    setState(() {});
  }
}
