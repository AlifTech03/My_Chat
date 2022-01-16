//packages
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImage extends StatefulWidget {
  PickImage(this.profImage);
  final void Function(File? image) profImage;

  @override
  PickImageState createState() => PickImageState();
}

class PickImageState extends State<PickImage> {
  XFile? _pickedImage;
  void _savedImage() async {
    final ImagePicker _picker = ImagePicker();
    final XFile? image = await _picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 50,
      maxWidth: 200,
    );
    setState(
      () {
        _pickedImage = image;
      },
    );
    widget.profImage(
      File(_pickedImage?.path ?? ''),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          alignment: AlignmentDirectional.center,
          children: [
            CircleAvatar(
              radius: 40,
              backgroundColor: Theme.of(context).primaryColor,
              backgroundImage: FileImage(
                File(_pickedImage?.path ?? ''),
              ),
            ),
            IconButton(
              alignment: Alignment.center,
              onPressed: _savedImage,
              icon: _pickedImage == null
                  ? const Icon(
                      Icons.camera_alt_outlined,
                      color: Colors.white,
                    )
                  : const Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
            ),
          ],
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            'Add Image...',
            style: TextStyle(color: Theme.of(context).primaryColor),
          ),
        ),
      ],
    );
  }
}
