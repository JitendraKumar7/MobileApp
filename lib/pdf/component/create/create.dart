import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'package:pdf/widgets.dart';

//https://gist.github.com/JAICHANGPARK/be56df4464ad469e37af9099a82addfe
Future<Uint8List> create(Page page) async {
  final pdf = Document();
  pdf.addPage(page);

  return await pdf.save();
}

Future<PageTheme> get pageTheme async {
  var bundle = await rootBundle.load('assets/ic_launcher.jpg');
  var image = MemoryImage(bundle.buffer.asUint8List());
  return PageTheme(
    buildBackground: (Context context) => FullPage(
      child: Watermark.text('TALLY KONNECT'),
      ignoreMargins: false,
    ),
    buildForeground: (Context context) => Align(
      child: Image(image, width: 40, height: 40),
      alignment: Alignment.bottomLeft,
    ),
  );
}
