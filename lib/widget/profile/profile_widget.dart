import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/picker/picker.dart';

class ProfileWidget extends StatefulWidget {
  final String? imagePath;
  final bool isEdit;

  const ProfileWidget({
    Key? key,
    String? path,
  })  : imagePath = path,
        isEdit = path == null,
        super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  Uint8List? bytes;

  void onClicked() async {
    var data = await ImageCropper.take(context);
    if (data != null) {
      setState(() => bytes = data.buffer.asUint8List());
    }
    debugPrint('Image Picker ${data?.buffer.lengthInBytes}');
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: InkWell(
        onTap: onClicked,
        child: Stack(children: [
          buildImage(),
          Positioned(
            bottom: 0,
            right: 4,
            child: buildEditIcon(color),
          ),
        ]),
      ),
    );
  }

  Widget buildEditIcon(Color color) {
    return buildCircle(
      color: Colors.white,
      all: 3,
      child: buildCircle(
        color: color,
        all: 8,
        child: Icon(
          widget.isEdit ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget buildImage() {
    var imagePath = widget.imagePath;
    var boxFit = BoxFit.cover;
    var byte = bytes;

    final image = byte != null
        ? Image.memory(byte, fit: boxFit)
        : imagePath == null
            ? Image.asset(person, fit: boxFit)
            : Image.network(imagePath, fit: boxFit);

    return Container(
      width: 128,
      height: 128,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(color: Colors.blueAccent),
      ),
      child: image,
    );
  }

  Widget buildCircle({
    required Widget child,
    required double all,
    required Color color,
  }) {
    return ClipOval(
      child: Container(
        padding: EdgeInsets.all(all),
        color: color,
        child: child,
      ),
    );
  }
}
