import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getCreditPdf(InvoiceModal modal) async {
  var header = HeaderModal.fromInvoice('CREDIT NOTE', modal, 'Document ');

  final page = MultiPage(
    pageTheme: await theme(modal.company),
    build: (Context context) => bodyProduct(context, modal),
    header: (Context context) => headerFrom(modal.company, header),
    footer: (Context context) => footer(context, modal.company.company),
  );
  return create(page);
}
