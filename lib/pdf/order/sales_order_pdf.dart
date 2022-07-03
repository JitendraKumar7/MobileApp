import 'dart:typed_data';

import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

// TODO [SALES ORDER PDF BODY]
Future<Uint8List> getSalesOrderPdf(OrderModal modal) async {
  var header = HeaderModal.fromLedger(
    'SALES ORDER',
    modal.ledger,
    modal.timestamp,
    'Order No. : ',
  );
  final page = Page(
    pageTheme: await theme(modal.company),
    build: (Context context) => Column(
      children: [
        headerTo(modal.company, header),
        bodyOrder(context, modal.data),
        Expanded(child: Text('')),
        Text('Remarks : ', style: const TextStyle(fontSize: 12)),
        SizedBox(height: 9),
        Text(modal.remark, style: const TextStyle(fontSize: 12)),
        footer(context, null),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
  return create(page);
}
