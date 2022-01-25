import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:image_cropper/image_cropper.dart';

Future<File?> showImagePicker({
  int? maxWidth,
  int? maxHeight,
  int compressQuality = 90,
  required BuildContext context,
  cropStyle = CropStyle.rectangle,
}) async {

  var source = await showDialog(
    context: context,
    builder: (BuildContext context) => Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListView(shrinkWrap: true, children: [
        const SizedBox(height: 18),
        ListTile(
          leading: const Icon(Icons.camera_alt),
          title: const Text('OPEN CAMERA'),
          onTap: () => Navigator.pop(context, ImageSource.camera),
        ),
        const Divider(),
        ListTile(
          leading: const Icon(Icons.image),
          title: const Text('FROM GALLERY'),
          onTap: () => Navigator.pop(context, ImageSource.gallery),
        ),
        const Divider(),
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: const Text('CANCEL'),
        ),
      ]),
    ),
  );

  if (source == null) {
    return null;
  }

  final XFile? xFile = await ImagePicker().pickImage(source: source);

  if (xFile == null) {
    return null;
  }

  return await ImageCropper.cropImage(
    compressQuality: compressQuality,
    sourcePath: xFile.path,
    cropStyle: cropStyle,
    maxHeight: maxHeight,
    maxWidth: maxWidth,
  );
}
