import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/picker/picker.dart';

class ProfileWidget extends StatefulWidget {
  final Function(List<int> bytes) capture;
  final List<int> bytes;

  const ProfileWidget({
    Key? key,
    this.bytes = const [],
    required this.capture,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileWidget> {
  Uint8List? bytes;

  void onClicked() async {
    var data = await showImagePicker(context: context);
    if (data != null) {
      var int8List = await data.readAsBytes();
      setState(() {
        widget.capture(int8List.toList());
        bytes = int8List;
      });
    }
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
          widget.bytes.isEmpty ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget buildImage() {
    var _bytes = Uint8List.fromList(widget.bytes);
    var boxFit = BoxFit.cover;

    final image = bytes != null
        ? Image.memory(bytes!, fit: boxFit)
        : widget.bytes.isEmpty
            ? Image.asset(person, fit: boxFit)
            : Image.memory(_bytes, fit: boxFit);

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

class CompanyLogoWidget extends StatefulWidget {
  final Function(List<int> bytes) capture;
  final List<int> bytes;

  const CompanyLogoWidget({
    Key? key,
    this.bytes = const [],
    required this.capture,
  }) : super(key: key);

  @override
  State<CompanyLogoWidget> createState() => _CompanyLogoState();
}

class _CompanyLogoState extends State<CompanyLogoWidget> {
  Uint8List? bytes;

  void onClicked() async {
    var data = await showImagePicker(
      compressQuality: 60,
      context: context,
      maxHeight: 120,
      maxWidth: 180,
    );
    if (data != null) {
      var int8List = await data.readAsBytes();
      setState(() {
        widget.capture(int8List.toList());
        bytes = int8List;
      });
    }
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
          widget.bytes.isEmpty ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget buildImage() {
    var _bytes = Uint8List.fromList(widget.bytes);
    var boxFit = BoxFit.cover;

    final image = bytes != null
        ? Image.memory(bytes!, fit: boxFit)
        : widget.bytes.isEmpty
            ? Image.asset(logo, fit: boxFit)
            : Image.memory(_bytes, fit: boxFit);

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
