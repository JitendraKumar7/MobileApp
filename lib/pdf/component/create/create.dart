import 'dart:typed_data';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:tally/modal/modal.dart';
import 'package:pdf/widgets.dart';

import '../../../widget/widget.dart';

//https://gist.github.com/JAICHANGPARK/be56df4464ad469e37af9099a82addfesse
Future<PageTheme> theme(CompanyModal modal) async {
  if (kIsWeb) return const PageTheme();
  var signature = await int8List(modal.signature);
  var logo = await int8List(modal.logo);
  return PageTheme(
    buildBackground: signature != null
        ? (_) => Align(
              child: Image(
                MemoryImage(signature),
                height: 60,
                width: 120,
              ),
              alignment: const Alignment(.95, -.95),
            )
        : null,
    buildForeground: logo != null
        ? (_) => Align(
              child: Image(
                MemoryImage(logo),
                width: 40,
                height: 40,
              ),
              alignment: const Alignment(-1, 1),
            )
        : null,
  );
}

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
