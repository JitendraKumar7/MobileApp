import 'dart:async';
import 'dart:math' as math;
import 'dart:typed_data';
import 'dart:ui' as ui;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:tally/widget/toolbar/toolbar.dart';
import 'clipper.dart';

Matrix4 _layoutImage(
  Size imageSize,
  Size clipSize,
  Size viewSize,
  BoxFit layout,
) {
  Matrix4 mat = Matrix4.identity();
  var scale = 1.0;
  if (layout == BoxFit.contain) {
    if (imageSize.aspectRatio > clipSize.aspectRatio) {
      scale = clipSize.width / imageSize.width;
    } else {
      scale = clipSize.height / imageSize.height;
    }
  } else if (layout == BoxFit.cover) {
    if (imageSize.aspectRatio > clipSize.aspectRatio) {
      scale = clipSize.height / imageSize.height;
    } else {
      scale = clipSize.width / imageSize.width;
    }
  } else {
    throw 'Not supported BoxFit type';
  }
  mat.scale(scale);
  // Offset transform origin, so that origin is now at center of canvas
  mat.translate(
    -imageSize.width / 2,
    -imageSize.height / 2,
  );

  return mat;
}

class ImageCropper extends StatefulWidget {
  const ImageCropper({
    Key? key,
    this.fit = BoxFit.cover,
    this.exportSize = const Size(500, 500),
    this.exportBackgroundColor,
    this.clipShape = ClipShape.circle,
    this.clipImage = false,
    this.clipRRectRadius = const Radius.circular(10),
  }) : super(key: key);

  final Size exportSize;
  final BoxFit fit;
  final Color? exportBackgroundColor;
  final bool clipImage;
  final ClipShape clipShape;
  final Radius clipRRectRadius;

  @override
  State<ImageCropper> createState() => _ImageCropperState();

  static Future<ByteData?>? take(BuildContext context) async {
    return await Navigator.push<ByteData>(
      context,
      MaterialPageRoute(builder: (_) => const ImageCropper()),
    );
  }
}

class _ImageCropperState extends State<ImageCropper> {
  Matrix4 sessionMatrix = Matrix4.identity();
  Matrix4 matrix = Matrix4.identity();
  ui.Image? bitImage;
  Size? clipSize;
  Matrix4? txMatrix;
  Offset initialFocalPoint = Offset.zero;

  Image? image;

  @override
  initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) async {
      if (await _showImagePicker()) {
        Navigator.pop(context);
      }
    });
  }

  Future<bool> _showImagePicker() async {
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
      return true;
    }

    final XFile? xFile = await ImagePicker().pickImage(source: source);

    if (xFile == null) {
      return true;
    }

    var imgBytes = await xFile.readAsBytes();

    bitImage = await _bytesToImage(imgBytes);
    setState(() => image = Image.memory(imgBytes));

    return false;
  }

  Future<ui.Image> _bytesToImage(Uint8List imgBytes) async {
    ui.Codec codec = await ui.instantiateImageCodec(imgBytes);
    ui.FrameInfo frame = await codec.getNextFrame();
    return frame.image;
  }

  Widget _buildImageView(
    BuildContext context,
    Size clipSize,
    Size viewSize,
    Matrix4 txMatrix,
  ) {
    // These two are used in image export
    this.clipSize = clipSize;
    this.txMatrix = txMatrix;

    var clipExportRatio = clipSize.width / widget.exportSize.width;
    return Stack(
      fit: StackFit.expand,
      alignment: Alignment.topLeft,
      children: [
        Positioned(
          left: viewSize.width / 2,
          top: viewSize.height / 2,
          child: Transform(
            transform: txMatrix,
            alignment: Alignment.topLeft,
            child: image,
          ),
        ),
        // black overlay on image
        ClipPath(
          clipper: InvertedClipper(
            clipSize: clipSize,
            shape: widget.clipShape,
            rrectRadius: widget.clipRRectRadius * clipExportRatio,
          ),
          child: Container(
            color: Colors.black54,
          ),
        ),
      ],
    );
  }

  _vFlipImage() {
    setState(() {
      var xf = Matrix4.identity()..scale(1.0, -1.0);
      matrix = xf * matrix;
    });
  }

  _hFlipImage() {
    setState(() {
      var xf = Matrix4.identity()..scale(-1.0, 1.0);
      matrix = xf * matrix;
    });
  }

  _rotateImage(double angle) {
    setState(() {
      var xf = Matrix4.identity()..rotateZ(angle);
      matrix = xf * matrix;
    });
  }

  _saveEdit() async {
    var edited = await _exportImage();
    Navigator.pop(
      context,
      edited,
    );
  }

  _onScaleStart(ScaleStartDetails d) {
    initialFocalPoint = d.focalPoint;
  }

  _onScaleUpdate(ScaleUpdateDetails d) {
    var center = context.size!.center(Offset.zero);
    var focal = d.localFocalPoint.translate(-center.dx, -center.dy);
    var focalDelta = d.focalPoint - initialFocalPoint;
    setState(() {
      sessionMatrix = Matrix4.identity()
        ..translate(focal.dx, focal.dy)
        ..scale(d.scale)
        ..rotateZ(d.rotation)
        ..translate(focalDelta.dx, focalDelta.dy)
        ..translate(-focal.dx, -focal.dy);
    });
  }

  _onScaleEnd(ScaleEndDetails d) {
    setState(() {
      // merge sessionMatrix into matrix
      matrix = sessionMatrix * matrix;
      sessionMatrix = Matrix4.identity();
    });
  }

  Future<ByteData?> _exportImage() async {
    if (bitImage == null || clipSize == null || txMatrix == null) {
      throw 'Image cannot be loaded';
    }

    var exportSize = widget.exportSize;
    ui.PictureRecorder recorder = ui.PictureRecorder();

    Canvas canvas = Canvas(recorder);
    var exportRect = Rect.fromLTWH(
      0,
      0,
      exportSize.width.toDouble(),
      exportSize.height.toDouble(),
    );
    // draw background
    if (widget.exportBackgroundColor != null) {
      canvas.drawRect(
          exportRect, Paint()..color = widget.exportBackgroundColor!);
    }
    // clip export image
    if (widget.clipImage) {
      Path? path;
      if (widget.clipShape == ClipShape.circle) {
        path = Path()..addOval(exportRect);
      } else if (widget.clipShape == ClipShape.rrect) {
        path = Path()
          ..addRRect(
            RRect.fromRectAndRadius(
              exportRect,
              widget.clipRRectRadius,
            ),
          );
      }
      if (path != null) {
        canvas.clipPath(path);
      }
    }
    // exportSize may be quite bigger than clipSize, hence this final scale
    var exportScale = exportSize.width / clipSize!.width;
    // Scale clip box to the size of exportSize
    canvas.scale(exportScale);
    // Move origin to center of clip box
    canvas.translate(clipSize!.width / 2, clipSize!.height / 2);
    canvas.transform(txMatrix!.storage);
    canvas.drawImage(
      bitImage!,
      Offset.zero,
      Paint(),
    );

    // var exportSize = const Size(100, 100);
    var img = await recorder.endRecording().toImage(
          exportSize.width.floor(),
          exportSize.height.floor(),
        );
    var buf = await img.toByteData(format: ui.ImageByteFormat.png);
    return buf;
  }

  @override
  Widget build(BuildContext context) {
    Widget imageView;
    imageView = bitImage == null
        ? const Center(child: CircularProgressIndicator())
        : LayoutBuilder(builder: (context, constraints) {
            var exportSize = widget.exportSize;
            var viewSize = constraints.biggest;
            var clipSize =
                constraints.deflate(const EdgeInsets.all(20)).biggest;
            // clipSize try to be as big as possible
            // while still keeps exportSize's ratio
            if (clipSize.aspectRatio > exportSize.aspectRatio) {
              clipSize = Size(
                clipSize.height * exportSize.aspectRatio,
                clipSize.height,
              );
            } else {
              clipSize = Size(
                clipSize.width,
                clipSize.width / exportSize.aspectRatio,
              );
            }
            // layoutMatrix ensure clip box either cover or contain the image
            var layoutMatrix = _layoutImage(
              Size(
                bitImage!.width.toDouble(),
                bitImage!.height.toDouble(),
              ),
              clipSize,
              viewSize,
              widget.fit,
            );

            return GestureDetector(
              onScaleStart: _onScaleStart,
              onScaleUpdate: _onScaleUpdate,
              onScaleEnd: _onScaleEnd,
              child: _buildImageView(
                context,
                clipSize,
                viewSize,
                sessionMatrix * matrix * layoutMatrix,
              ),
            );
          });

    return Scaffold(
      appBar: const Toolbar('CROPPER'),
      body: imageView,
      bottomNavigationBar: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                tooltip: 'Horizontal flip',
                onPressed: _hFlipImage,
                icon: const Icon(Icons.flip),
              ),
              IconButton(
                tooltip: 'Vertical flip',
                onPressed: _vFlipImage,
                icon: const RotatedBox(
                  quarterTurns: 1,
                  child: Icon(Icons.flip_rounded),
                ),
              ),
              IconButton(
                tooltip: 'Rotate left',
                onPressed: () => _rotateImage(math.pi / 2),
                icon: const Icon(Icons.rotate_90_degrees_ccw),
              ),
              IconButton(
                tooltip: 'Rotate right',
                onPressed: () => _rotateImage(-math.pi / 2),
                icon: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()..scale(-1.0, 1.0),
                  child: const Icon(Icons.rotate_90_degrees_ccw),
                ),
              ),
              ElevatedButton.icon(
                icon: const Icon(Icons.save),
                label: const Text('Save'),
                onPressed: _saveEdit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
