import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getReceiptPdf(InvoiceModal modal) async {
  var header = HeaderModal.fromInvoice('RECEIPT', modal, 'Document ');
  final page = Page(
    pageFormat: PdfPageFormat.a4,
    build: (Context context) => Column(children: [
      headerFrom(modal.company, header),
      Divider(
        thickness: 9,
        color: colorBlue,
      ),
      bodySlip(context, modal.slip(false)),
      footer(context, modal.company.name),
    ]),
  );
  return create(page);
}
