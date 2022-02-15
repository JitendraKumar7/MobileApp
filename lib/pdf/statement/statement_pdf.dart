import 'dart:typed_data';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getAccountPdf(StatementModal modal) async {
  final page = MultiPage(
    pageTheme: await pageTheme,
    crossAxisAlignment: CrossAxisAlignment.start,
    header: (Context context) => headerAcc(
      name: modal.company.getName,
      label: 'LEDGER ACCOUNT',
      party: modal.name,
      gst: modal.gst,
      period: modal.period,
    ),
    footer: (Context context) => footer(context, null),
    build: (Context context) => bodyStatement(context, modal),
  );
  return create(page);
}

Future<Uint8List> getReceivablePdf(Outstanding modal) async {
  final page = MultiPage(
    pageTheme: await pageTheme,
    crossAxisAlignment: CrossAxisAlignment.start,
    header: (Context context) => headerAcc(
      name: modal.company.getName,
      period: modal.period,
      party: modal.name,
      label: 'RECEIVABLE',
      gst: modal.gst,
    ),
    footer: (Context context) => footer(context, null),
    build: (Context context) => bodyOutstanding(context, modal),
  );
  return create(page);
}

Future<Uint8List> getPayablePdf(Outstanding modal) async {
  final page = MultiPage(
    pageTheme: await pageTheme,
    crossAxisAlignment: CrossAxisAlignment.start,
    header: (Context context) => headerAcc(
      name: modal.company.getName,
      period: modal.period,
      party: modal.name,
      label: 'PAYABLE',
      gst: modal.gst,
    ),
    footer: (Context context) => footer(context, null),
    build: (Context context) => bodyOutstanding(context, modal),
  );
  return create(page);
}
