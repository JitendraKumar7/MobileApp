import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component.dart';

const colorBlue = PdfColor.fromInt(0xFF64B5F6);
const colorGray = PdfColor.fromInt(0xFFEFEFEF);
const colorBlack = PdfColor.fromInt(0x00000000);
const colorWhite = PdfColor.fromInt(0xFFFFFFFF);

const cellStyle = TextStyle(
  color: colorBlack,
  fontSize: 10,
);
const headerStyle = TextStyle(
  color: colorWhite,
  fontSize: 12,
);

const headerDecoration = BoxDecoration(color: colorBlue);
const oddRowDecoration = BoxDecoration(color: colorGray);

const headerSpace = EdgeInsets.only(bottom: 6, top: 6);

TableRow tableRow(String left, String right) {
  return TableRow(children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(0, 3, 3, 3),
      child: Text(left, style: const TextStyle(fontSize: 11)),
    ),
    Padding(
      padding: const EdgeInsets.fromLTRB(3, 3, 0, 3),
      child: Text(right, style: const TextStyle(fontSize: 11)),
    ),
  ]);
}

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
    cellStyle: cellStyle,
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
    Divider(thickness: 9, color: colorBlue),
    if (text != null) ...[
      Container(
        alignment: Alignment.centerRight,
        margin: margin,
        child: Text(
          text,
          style: const TextStyle(fontSize: 13),
        ),
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
      child: Column(children: [
        UrlLink(
          child: Text(
            'Powered by TallyKonnect.com',
            style: const TextStyle(fontSize: 12),
          ),
          destination: 'https://tallykonnect.com/',
        ),
        Text(
          'Page ${context.pageNumber} of ${context.pagesCount}',
          style: const TextStyle(fontSize: 12),
        ),
      ]),
    ),
  ]);
}

Widget headerAcc({
  required String gst,
  required String name,
  required String party,
  required String label,
  required String period,
}) {
  return Column(children: [
    Container(
      alignment: Alignment.center,
      child: Text(
        name,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      padding: const EdgeInsets.only(bottom: 6),
    ),
    Container(
      alignment: Alignment.center,
      child: Text(
        label,
        style: const TextStyle(fontSize: 10),
      ),
      padding: headerSpace,
    ),
    Container(
      alignment: Alignment.center,
      child: Text(
        party,
        style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
      ),
      padding: headerSpace,
    ),
    Container(
      alignment: Alignment.center,
      child: Text(
        gst,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
      padding: headerSpace,
    ),
    Container(
      alignment: Alignment.center,
      child: Text(
        period,
        style: TextStyle(fontSize: 11, fontWeight: FontWeight.bold),
      ),
      padding: const EdgeInsets.only(
        bottom: 12,
        top: 6,
      ),
    ),
  ]);
}

Widget headerTo(CompanyModal to, HeaderModal modal) {
  return Column(children: [
    Container(
      width: 19 * PdfPageFormat.cm,
      height: 40,
      child: Text(
        modal.getTitle,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.topCenter,
    ),
    Table(columnWidths: {
      0: const FlexColumnWidth(1),
      1: const FlexColumnWidth(1),
    }, children: [
      tableRow('FROM', 'TO'),
      tableRow(modal.getName, to.getName),
      tableRow(modal.getAddress, to.getAddress),
      tableRow(modal.getGstin, 'GSTIN : ${to.gstin ?? ''}'),
      tableRow(modal.getInvoiceNo, modal.getDate),
    ]),
    SizedBox(height: 18),
  ]);
}

Widget headerFrom(CompanyModal from, HeaderModal modal) {
  return Column(children: [
    Container(
      width: 19 * PdfPageFormat.cm,
      height: 40,
      child: Text(
        modal.getTitle,
        textAlign: TextAlign.center,
        style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
      ),
      alignment: Alignment.topCenter,
    ),
    Table(columnWidths: {
      0: const FlexColumnWidth(1),
      1: const FlexColumnWidth(1),
    }, children: [
      tableRow('FROM', 'TO'),
      tableRow(from.getName, modal.getName),
      tableRow(from.getAddress, modal.getAddress),
      tableRow('GSTIN : ${from.gstin ?? ''}', modal.getGstin),
      tableRow(modal.getInvoiceNo, modal.getDate),
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

List<Widget> bodyOutstanding(Context context, Outstanding modal) {
  var header = [
    'BILL DATE',
    'REFERENCE',
    'DUE DATE',
    'DUE DAYS',
    'AMOUNT',
  ];
  var cellAlignments = {
    0: Alignment.centerLeft,
    1: Alignment.centerLeft,
    2: Alignment.centerLeft,
    3: Alignment.centerRight,
    4: Alignment.centerRight,
  };
  var columnWidths = {
    0: const FlexColumnWidth(1.0),
    1: const FlexColumnWidth(1.0),
    2: const FlexColumnWidth(1.0),
    3: const FlexColumnWidth(0.8),
    4: const FlexColumnWidth(1.0),
  };
  return [
    table(
      data: modal.data,
      headers: header,
      context: context,
      columnWidths: columnWidths,
      cellAlignments: cellAlignments,
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
    0: const FlexColumnWidth(1.0),
    1: const FlexColumnWidth(1.3),
    2: const FlexColumnWidth(1.0),
    3: const FlexColumnWidth(1.3),
    4: const FlexColumnWidth(1.0),
    5: const FlexColumnWidth(1.0),
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
