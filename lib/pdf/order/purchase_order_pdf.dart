import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

// TODO [PURCHASE PDF BODY]
Future<Uint8List> getPurchaseOrderPdf(OrderModal modal) async {
  var header = HeaderModal.fromLedger(
    'PURCHASE ORDER',
    modal.ledger,
    modal.timestamp,
    'Order No. : ',
  );
  final page = Page(
    pageTheme: await theme(modal.company),
    build: (Context context) => Column(
      children: [
        headerFrom(modal.company, header),
        bodyOrder(context, modal.data),
        Expanded(child: Text('')),
        Text(modal.remark, style: const TextStyle(fontSize: 12)),
        footer(context, modal.company.company),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
  return create(page);
}
