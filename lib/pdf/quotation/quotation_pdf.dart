import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getQuotationPdf(QuotationModal modal) async {
  var header = HeaderModal.fromLedger(
    'QUOTATION',
    modal.ledger,
    modal.timestamp,
  );
  final page = Page(
    pageTheme: await pageTheme,
    build: (Context context) => Column(
      children: [
        headerFrom(modal.company, header),
        bodyQuotation(context,modal.data),
        Expanded(child: Text('')),
        Text('NOTE : '),
        SizedBox(height: 6),
        Text('Terms & Conditions', style: const TextStyle(fontSize: 14)),
        SizedBox(height: 9),
        Text(modal.remark, style: const TextStyle(fontSize: 12)),
        footer(context,  modal.company.name),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
  return create(page);
}
