import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';
import 'package:lazy_data_table/lazy_data_table.dart';

import '../pdf/view_pdf.dart';

class ViewStatementPage extends StatelessWidget {
  final StatementModal modal;

  const ViewStatementPage(this.modal, {Key? key}) : super(key: key);

  static Route page(modal) {
    return MaterialPageRoute(
      builder: (_) => ViewStatementPage(modal),
    );
  }

  @override
  Widget build(BuildContext context) {
    for (var e in modal.jsonData.take(1)) {
      //debugPrint('statement $e');
      e.forEach((key, value) {
        debugPrint('key => $key value => $value');
      });
    }
    var style = const TextStyle(color: Colors.white);
    var borderWhite = Border.all(color: Colors.white, width: 0.5);

    return Scaffold(
      appBar: Toolbar('ACCOUNT STATEMENT', actions: [
        IconButton(
          onPressed: () {
            var route = ViewStatementPdf.page(modal);
            Navigator.push(context, route);
          },
          icon: const Icon(Icons.picture_as_pdf),
        ),
      ]),
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          child: Text(
            modal.company.getName,
            textAlign: TextAlign.center,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          padding: const EdgeInsets.only(
            bottom: 9,
            right: 18,
            left: 18,
            top: 18,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: const Text('LEDGER ACCOUNT'),
          padding: const EdgeInsets.only(
            bottom: 9,
            right: 18,
            left: 18,
            top: 9,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            modal.name,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          padding: const EdgeInsets.only(
            bottom: 9,
            right: 18,
            left: 18,
            top: 9,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            modal.gst,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          padding: const EdgeInsets.only(
            bottom: 9,
            right: 18,
            left: 18,
            top: 9,
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Text(
            modal.period,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          padding: const EdgeInsets.only(
            bottom: 18,
            right: 18,
            left: 18,
            top: 9,
          ),
        ),
        Expanded(
          child: LazyDataTable(
            columns: 5,
            rows: modal.length,
            tableDimensions: const LazyDataTableDimensions(
              leftHeaderWidth: 90,
              topHeaderHeight: 50,
              cellHeight: 50,
              cellWidth: 180,
            ),
            tableTheme: LazyDataTableTheme(
              alternateRowHeaderBorder: borderWhite,
              columnHeaderBorder: borderWhite,
              rowHeaderBorder: borderWhite,
              cornerBorder: borderWhite,
              cellBorder: const Border(),
              alternateCellBorder: const Border(),
              alternateColumnHeaderBorder: const Border(),
            ),
            topHeaderBuilder: (i) =>
                Center(child: Text(header[i + 1], style: style)),
            dataCellBuilder: (i, j) => Center(child: modal.data(i, j)),
            leftHeaderBuilder: (i) =>
                Center(child: Text(modal.date(i), style: style)),
            topLeftCornerWidget: Center(child: Text(header[0], style: style)),
          ),
        ),
      ]),
    );
  }
}
