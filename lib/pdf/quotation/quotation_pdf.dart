import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

//https://gist.github.com/JAICHANGPARK/be56df4464ad469e37af9099a82addfe
Future<Uint8List> getQuotationPdf(QuotationModal modal) async {
  var from = modal.company;
  var to = modal.ledger;

  final page = MultiPage(
      pageFormat: PdfPageFormat.a4,
      crossAxisAlignment: CrossAxisAlignment.start,
      header: (Context context) => Column(children: [
            Container(
              width: 19 * PdfPageFormat.cm,
              height: 40,
              child: Text('QUOTATION', textScaleFactor: 2),
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
                  child: Text(to.name ?? ''),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(from.address ?? ''),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text(to.address ?? ''),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('GSTIN : ${from.gstin ?? ' '}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('GSTIN : ${to.partyGstin ?? ''}'),
                ),
              ]),
              TableRow(children: [
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('ID : #${modal.timestamp}'),
                ),
                Padding(
                  padding: const EdgeInsets.all(3),
                  child: Text('Date : ${modal.date}'),
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
              context: context,
              headers: <String>[
                'ITEM',
                'HSN',
                'UNIT',
                'GST',
                'PRICE',
                'DESCRIPTION'
              ],
              headerDecoration: const BoxDecoration(
                color: PdfColor.fromInt(0xFF64B5F6),
              ),
              headerStyle: const TextStyle(
                color: PdfColor.fromInt(0xFFFFFFFF),
              ),
              cellAlignment: Alignment.centerRight,
              headerAlignment: Alignment.centerRight,
              cellDecoration: (int index, _, int rowNum) {
                return rowNum % 2 == 0
                    ? const BoxDecoration(color: PdfColor.fromInt(0xFFEFEFEF))
                    : const BoxDecoration();
              },
              columnWidths: {
                0: const FlexColumnWidth(2),
                1: const FlexColumnWidth(1),
                2: const FlexColumnWidth(1),
                3: const FlexColumnWidth(1),
                4: const FlexColumnWidth(1),
                5: const FlexColumnWidth(2),
              },
              cellAlignments: {
                0: Alignment.centerLeft,
                1: Alignment.center,
                2: Alignment.center,
                3: Alignment.center,
                4: Alignment.center,
                5: Alignment.centerLeft,
              },
              data: modal.data,
            ),
            SizedBox(height: 24),
            Text(modal.remark ?? ''),
          ]);

  final pdf = Document();
  pdf.addPage(page);

  return await pdf.save();
}
