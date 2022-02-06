import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getStatementPdf(StatementModal modal) async {
  final page = MultiPage(
    pageFormat: PdfPageFormat.a4,
    crossAxisAlignment: CrossAxisAlignment.start,
    header: (Context context) => Column(children: [
      Container(
        alignment: Alignment.center,
        child: Text(
          modal.company.getName,
          textAlign: TextAlign.center,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        padding: const EdgeInsets.only(
          bottom: 9,
          right: 18,
          left: 18,
          top: 18,
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text('LEDGER ACCOUNT'),
        padding: const EdgeInsets.only(
          bottom: 9,
          right: 18,
          left: 18,
          top: 9,
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          modal.name,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        padding: const EdgeInsets.only(
          bottom: 9,
          right: 18,
          left: 18,
          top: 9,
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          modal.gst,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        padding: const EdgeInsets.only(
          bottom: 9,
          right: 18,
          left: 18,
          top: 9,
        ),
      ),
      Container(
        alignment: Alignment.center,
        child: Text(
          modal.period,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        padding: const EdgeInsets.only(
          bottom: 18,
          right: 18,
          left: 18,
          top: 9,
        ),
      ),
    ]),
    footer: (Context context) => footer(context, null),
    build: (Context context) => bodyStatement(context, modal),
  );
  return create(page);
}
