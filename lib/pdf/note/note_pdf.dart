import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

//https://gist.github.com/JAICHANGPARK/be56df4464ad469e37af9099a82addfe
Future<Uint8List> getCreditPdf(CompanyModal from, InvoiceModal modal) async {
  final page = MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) => Column(children: [
            Container(
              width: 19 * PdfPageFormat.cm,
              height: 40,
              child: Text('TAX INVOICE', textScaleFactor: 2),
              alignment: Alignment.topCenter,
            ),
            Table(columnWidths: {
              0: const FlexColumnWidth(1),
              1: const FlexColumnWidth(1),
            }, children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('FROM'),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('TO'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(from.name ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(modal.partyLedgerName ?? ''),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(from.address ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(modal.narration ?? ''),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('GSTIN : ${from.gstin ?? ' '}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('GSTIN : '),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('ID : #${modal.reference}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('Date : ${modal.voucherDate}'),
                ),
              ]),
            ]),
            SizedBox(height: 18),
          ]),
      footer: (Context context) => Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}'),
          ),
      build: (Context context) => <Widget>[
            Table.fromTextArray(
              border: null,
              headerCount: 0,
              headers: <String>[
                '',
                '',
                '',
              ],
              headerDecoration: const BoxDecoration(
                color: PdfColor.fromInt(0xFF64B5F6),
              ),
              context: context,
              columnWidths: {
                0: const FlexColumnWidth(1),
                1: const FlexColumnWidth(2),
                2: const FlexColumnWidth(1),
              },
              cellAlignments: {
                0: Alignment.centerLeft,
                1: Alignment.centerLeft,
                2: Alignment.centerRight,
              },
              data: modal.sundry,
            ),
          ]);

  final pdf = Document();
  pdf.addPage(page);

  return await pdf.save();
}

Future<Uint8List> getDebitPdf(CompanyModal to, InvoiceModal modal) async {
  final page = MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) => Column(children: [
            Container(
              width: 19 * PdfPageFormat.cm,
              height: 40,
              child: Text('TAX INVOICE', textScaleFactor: 2),
              alignment: Alignment.topCenter,
            ),
            Table(columnWidths: {
              0: const FlexColumnWidth(1),
              1: const FlexColumnWidth(1),
            }, children: [
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('FROM'),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('TO'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(modal.partyLedgerName ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(to.name ?? ''),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(modal.narration ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(to.address ?? ''),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('GSTIN : '),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('GSTIN : ${to.gstin ?? ''}'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('ID : #${modal.voucherNumber}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('Date : ${modal.voucherDate}'),
                ),
              ]),
            ]),
            SizedBox(height: 18),
          ]),
      footer: (Context context) => Container(
            alignment: Alignment.centerRight,
            margin: const EdgeInsets.only(top: 1.0 * PdfPageFormat.cm),
            child: Text('Page ${context.pageNumber} of ${context.pagesCount}'),
          ),
      build: (Context context) => <Widget>[
            Table.fromTextArray(
              border: null,
              headerCount: 0,
              headers: <String>[
                '',
                '',
                '',
              ],
              headerDecoration: const BoxDecoration(
                color: PdfColor.fromInt(0xFF64B5F6),
              ),
              context: context,
              columnWidths: {
                0: const FlexColumnWidth(1),
                1: const FlexColumnWidth(2),
                2: const FlexColumnWidth(1),
              },
              cellAlignments: {
                0: Alignment.centerLeft,
                1: Alignment.centerLeft,
                2: Alignment.centerRight,
              },
              data: modal.sundry,
            ),
          ]);

  final pdf = Document();
  pdf.addPage(page);

  return await pdf.save();
}
