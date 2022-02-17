import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

// TODO [QUOTATION PDF BODY]
Future<Uint8List> getQuotationPdf(QuotationModal modal) async {
  var header = HeaderModal.fromLedger(
    'QUOTATION',
    modal.ledger,
    modal.timestamp,
  );
  final page = Page(
    build: (Context context) => Column(
      children: [
        headerFrom(modal.company, header),
        bodyQuotation(context, modal.data),
        Expanded(child: Text('')),
        Text('NOTE : ', style: const TextStyle(fontSize: 12)),
        SizedBox(height: 6),
        Text('Terms & Conditions', style: const TextStyle(fontSize: 12)),
        SizedBox(height: 9),
        Text(modal.remark, style: const TextStyle(fontSize: 11)),
        footer(context, modal.company.name),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
  return create(page);
}
