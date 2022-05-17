import 'dart:typed_data';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/picker/picker.dart';

import '../widget.dart';

class ProfileWidget extends StatefulWidget {
  final Function(String url) capture;
  final String url;
  final String id;

  const ProfileWidget({
    Key? key,
    this.url = '',
    required this.id,
    required this.capture,
  }) : super(key: key);

  @override
  State<ProfileWidget> createState() => _ProfileState();
}

class _ProfileState extends State<ProfileWidget> {
  void onClicked() async {
    var file = await showImagePicker(context: context);
    if (file != null) {
      var reference = FirebaseStorage.instance.ref('profile');
      var snapshot = await reference.child(widget.id).putFile(file);
      var url = await snapshot.ref.getDownloadURL();
      setState(() => widget.capture(url));
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
          widget.url.isEmpty ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget buildImage() {
    var boxFit = BoxFit.cover;

    final image = widget.url.isEmpty
        ? Image.asset(person, fit: boxFit)
        : Image.network(widget.url, fit: boxFit);
    //: Image.memory(_bytes, fit: boxFit);

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

class ImageWidget extends StatefulWidget {
  final Function(String url) capture;
  final BoxShape shape;
  final double height;
  final double width;
  final String asset;
  final String ref;
  final String url;
  final String id;

  const ImageWidget({
    Key? key,
    this.url = '',
    required this.id,
    required this.ref,
    required this.capture,
    this.width = 128,
    this.height = 128,
    this.asset = logo,
    this.shape = BoxShape.circle,
  }) : super(key: key);

  @override
  State<ImageWidget> createState() => _ImageWidgetState();
}

class _ImageWidgetState extends State<ImageWidget> {
  bool uploading = false;
  String fileUrl = '';

  @override
  void initState() {
    super.initState();
    fileUrl = widget.url;
  }

  void onClicked() async {
    var file = await showImagePicker(context: context);
    if (file != null) {
      setState(() => uploading = true);
      var reference = FirebaseStorage.instance.ref(widget.ref);

      // upload snapshot
      var snapshot = await reference.child(widget.id).putFile(file);
      fileUrl = await snapshot.ref.getDownloadURL();
      widget.capture(fileUrl);

      // update state
      setState(() => uploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme.primary;
    return Center(
      child: uploading
          ? SizedBox(
              child: const LoaderPage(),
              height: widget.height,
              width: widget.width,
            )
          : InkWell(
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
          widget.url.isEmpty ? Icons.add_a_photo : Icons.edit,
          color: Colors.white,
          size: 20,
        ),
      ),
    );
  }

  Widget buildImage() {
    var boxFit = BoxFit.cover;

    final image = fileUrl.isNotEmpty
        ? Image.network(fileUrl, fit: boxFit)
        : Image.asset(widget.asset, fit: boxFit);

    return Container(
      width: widget.width,
      height: widget.height,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blueAccent),
        shape: widget.shape,
      ),
      child: image,
    );
  }

  Widget buildCircle({
    required Widget child,
    required Color color,
    required double all,
  }) {
    return ClipOval(
      child: Container(
        clipBehavior: Clip.hardEdge,
        padding: EdgeInsets.all(all),
        decoration: BoxDecoration(color: color),
        child: child,
      ),
    );
  }
}

Future<Uint8List?> int8List(String? url) async {
  try {
    if (url == null) return null;
    var reference = FirebaseStorage.instance;
    return reference.refFromURL(url).getData();
  } catch (ignore) {
    return null;
  }
}
