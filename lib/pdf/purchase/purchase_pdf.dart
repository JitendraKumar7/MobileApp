import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getPurchasePdf(InvoiceModal modal) async {
  var header = HeaderModal.fromInvoice('PURCHASE INVOICE', modal);
  final page = MultiPage(
    pageTheme: await pageTheme,
    crossAxisAlignment: CrossAxisAlignment.start,
    build: (Context context) => bodyProduct(context, modal),
    header: (Context context) => headerTo(modal.company, header),
    footer: (Context context) => footer(context, modal.company.name),
  );
  return create(page);
}
