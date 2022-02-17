import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getProformaPdf(ProformaModal modal) async {
  var header = HeaderModal.fromLedger(
    'PROFORMA INVOICE',
    modal.ledger,
    modal.timestamp,
  );
  final page = MultiPage(
    build: (Context context) => bodyProforma(context, modal),
    header: (Context context) => headerFrom(modal.company, header),
    footer: (Context context) => footer(context, modal.company.name),
  );
  return create(page);
}
