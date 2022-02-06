import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component.dart';

const colorBlue = PdfColor.fromInt(0xFF64B5F6);
const colorGray = PdfColor.fromInt(0xFFEFEFEF);
const colorWhite = PdfColor.fromInt(0xFFFFFFFF);

const headerStyle = TextStyle(color: colorWhite);
const headerDecoration = BoxDecoration(color: colorBlue);
const oddRowDecoration = BoxDecoration(color: colorGray);

Widget table({
  int headerCount = 1,
  List<dynamic>? headers,
  required Context context,
  required List<List<String>> data,
  Map<int, Alignment>? cellAlignments,
  Map<int, TableColumnWidth>? columnWidths,
}) {
  var _oddDecoration = headerCount == 1 ? oddRowDecoration : null;
  return Table.fromTextArray(
    data: data,
    border: null,
    headers: headers,
    headerCount: headerCount,
    headerStyle: headerStyle,
    columnWidths: columnWidths,
    cellAlignments: cellAlignments,
    oddRowDecoration: _oddDecoration,
    headerDecoration: headerDecoration,
    cellAlignment: Alignment.centerRight,
    headerAlignment: Alignment.centerRight,
  );
}

Widget footer(Context context, String? text) {
  const margin = EdgeInsets.only(top: 1.0 * PdfPageFormat.cm);
  return Column(children: [
    Divider(
      thickness: 9,
      color: colorBlue,
    ),
    if (text != null) ...[
      Container(
        alignment: Alignment.centerRight,
        margin: margin,
        child: Text(text),
      ),
      Container(
        alignment: Alignment.centerRight,
        margin: const EdgeInsets.only(top: 0.5 * PdfPageFormat.cm),
        child: Text(
          'Auth Signatory',
          style: const TextStyle(fontSize: 12),
        ),
      ),
    ],
    Container(
      margin: text == null ? margin : EdgeInsets.zero,
      child: Text(
        'Page ${context.pageNumber} of ${context.pagesCount}',
        style: const TextStyle(fontSize: 12),
      ),
    ),
  ]);
}

Widget headerTo(CompanyModal to, HeaderModal modal) {
  return Column(children: [
    Container(
      width: 19 * PdfPageFormat.cm,
      height: 40,
      child: Text(modal.getTitle, textScaleFactor: 1.5),
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
          child: Text(modal.getName),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(to.getName),
        ),
      ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getAddress),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(to.getAddress),
        ),
      ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getGstin),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text('GSTIN : ${to.gstin ?? ''}'),
        ),
      ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getInvoiceNo),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getDate),
        ),
      ]),
    ]),
    SizedBox(height: 18),
  ]);
}

Widget headerFrom(CompanyModal from, HeaderModal modal) {
  return Column(children: [
    Container(
      width: 19 * PdfPageFormat.cm,
      height: 40,
      child: Text(modal.getTitle, textScaleFactor: 1.5),
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
          child: Text(from.getName),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getName),
        ),
      ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(from.getAddress),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getAddress),
        ),
      ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text('GSTIN : ${from.gstin ?? ' '}'),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getGstin),
        ),
      ]),
      TableRow(children: [
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getInvoiceNo),
        ),
        Padding(
          padding: const EdgeInsets.all(3),
          child: Text(modal.getDate),
        ),
      ]),
    ]),
    SizedBox(height: 18),
  ]);
}

Widget bodySlip(Context context, List<List<String>> data) {
  var columnWidths = {
    0: const FlexColumnWidth(1),
    1: const FlexColumnWidth(2),
    2: const FlexColumnWidth(2.5),
  };
  return table(
    data: data,
    headerCount: 0,
    context: context,
    columnWidths: columnWidths,
  );
}

Widget bodyOrder(Context context, List<List<String>> data) {
  var headers = <String>['ITEM', 'RATE', 'QUANTITY'];
  var columnWidths = {
    0: const FlexColumnWidth(2),
    1: const FlexColumnWidth(1),
    2: const FlexColumnWidth(1),
  };
  var cellAlignments = {
    0: Alignment.centerLeft,
    1: Alignment.center,
    2: Alignment.center,
  };
  return table(
    data: data,
    context: context,
    headers: headers,
    columnWidths: columnWidths,
    cellAlignments: cellAlignments,
  );
}

Widget bodyQuotation(Context context, List<List<String>> data) {
  var headers = <String>['ITEM', 'HSN', 'RATE', 'GST', 'DESCRIPTION'];
  var columnWidths = {
    0: const FlexColumnWidth(2),
    1: const FlexColumnWidth(1),
    2: const FlexColumnWidth(1),
    3: const FlexColumnWidth(1),
    4: const FlexColumnWidth(2),
  };
  var cellAlignments = {
    0: Alignment.centerLeft,
    1: Alignment.center,
    2: Alignment.center,
    3: Alignment.center,
    4: Alignment.centerLeft,
  };

  return table(
    data: data,
    context: context,
    headers: headers,
    columnWidths: columnWidths,
    cellAlignments: cellAlignments,
  );
}

List<Widget> bodyProduct(Context context, InvoiceModal modal) {
  // sales, purchase, hsn
  var headers = <String>['ITEM', 'HSN', 'PRICE', 'QTY', 'AMOUNT'];
  var cellAlignments = {
    0: Alignment.centerLeft,
    1: Alignment.center,
    2: Alignment.center,
    3: Alignment.center,
    4: Alignment.centerRight,
  };
  var columnWidths = {
    0: const FlexColumnWidth(2),
    1: const FlexColumnWidth(1),
    2: const FlexColumnWidth(1.2),
    3: const FlexColumnWidth(1.2),
    4: const FlexColumnWidth(1.2),
  };
  return <Widget>[
    table(
      data: modal.data,
      context: context,
      headers: headers,
      columnWidths: columnWidths,
      cellAlignments: cellAlignments,
    ),
    SizedBox(height: 24),
    table(
      headerCount: 0,
      context: context,
      data: modal.sundry,
      columnWidths: {
        0: const FlexColumnWidth(4),
        1: const FlexColumnWidth(2),
        2: const FlexColumnWidth(1),
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
      },
    ),
  ];
}

List<Widget> bodyProforma(Context context, ProformaModal modal) {
  var headers = <String>['ITEM', 'HSN', 'RATE', 'GST', 'QTY', 'AMOUNT'];
  var cellAlignments = {
    0: Alignment.centerLeft,
    1: Alignment.center,
    2: Alignment.center,
    3: Alignment.center,
    4: Alignment.center,
    5: Alignment.centerRight,
  };
  var columnWidths = {
    0: const FlexColumnWidth(4),
    1: const FlexColumnWidth(1),
    2: const FlexColumnWidth(1.5),
    3: const FlexColumnWidth(1),
    4: const FlexColumnWidth(1),
    5: const FlexColumnWidth(1.5),
  };
  return [
    table(
      data: modal.data,
      context: context,
      headers: headers,
      columnWidths: columnWidths,
      cellAlignments: cellAlignments,
    ),
    SizedBox(height: 24),
    table(
      headerCount: 0,
      context: context,
      data: modal.sundry,
      columnWidths: {
        0: const FlexColumnWidth(4),
        1: const FlexColumnWidth(2),
        2: const FlexColumnWidth(1),
      },
      cellAlignments: {
        0: Alignment.centerLeft,
        1: Alignment.centerLeft,
        2: Alignment.centerRight,
      },
    ),
  ];
}

List<Widget> bodyStatement(Context context, StatementModal modal) {
  var cellAlignments = {
    0: Alignment.centerLeft,
    1: Alignment.centerLeft,
    2: Alignment.centerLeft,
    3: Alignment.centerLeft,
    4: Alignment.centerRight,
    5: Alignment.centerRight,
  };
  var columnWidths = {
    0: const FlexColumnWidth(1),
    1: const FlexColumnWidth(1.3),
    2: const FlexColumnWidth(1),
    3: const FlexColumnWidth(1),
    4: const FlexColumnWidth(1),
    5: const FlexColumnWidth(1),
  };
  return [
    table(
      data: modal.value,
      context: context,
      headers: modal.header,
      columnWidths: columnWidths,
      cellAlignments: cellAlignments,
    ),
  ];
}
