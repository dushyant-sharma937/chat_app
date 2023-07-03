import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class UserImagePicker extends StatefulWidget {
  final void Function(File pickedImage) imagePickedFn;

  const UserImagePicker({super.key, required this.imagePickedFn});

  @override
  State<UserImagePicker> createState() => _UserImagePickerState();
}

class _UserImagePickerState extends State<UserImagePicker> {
  File? _pickedImage;

  void _pickImage() async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(
      source: ImageSource.camera,
      imageQuality: 75,
      maxWidth: 150,
    );
    final pickedImageFile = File(pickedImage!.path);
    setState(() {
      _pickedImage = pickedImageFile;
    });
    widget.imagePickedFn(pickedImageFile);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 2),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Colors.black,
            backgroundImage:
                _pickedImage != null ? FileImage(_pickedImage!) : null,
          ),
        ),
        TextButton.icon(
          onPressed: _pickImage,
          icon: Icon(
            Icons.image,
            color: Theme.of(context).colorScheme.onSecondary,
          ),
          label: Text(
            'Add Image',
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSecondary,
            ),
          ),
        )
      ],
    );
  }
}
