import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getSalesOrderPdf(OrderModal modal) async {
  var header = HeaderModal.fromLedger(
    'SALES ORDER',
    modal.ledger,
    modal.timestamp,
    'Order No. : ',
  );
  final page = Page(
    pageTheme: await pageTheme,
    build: (Context context) => Column(
      children: [
        headerTo(modal.company, header),
        bodyOrder(context, modal.data),
        Expanded(child: Text('')),
        Text('Remarks : '),
        SizedBox(height: 9),
        Text(modal.remark, style: const TextStyle(fontSize: 12)),
        footer(context, null),
      ],
      crossAxisAlignment: CrossAxisAlignment.start,
    ),
  );
  return create(page);
}
