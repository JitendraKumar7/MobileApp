import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:lazy_data_table/lazy_data_table.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/modal/modal.dart' as m;
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../reports_view.dart';
import '../pdf/view_pdf.dart';

class ViewStatementPage extends StatelessWidget {
  final DocumentReference reference;
  final StatementModal modal;

  const ViewStatementPage(
    this.reference,
    this.modal, {
    Key? key,
  }) : super(key: key);

  static Route page(DocumentReference reference, StatementModal modal) {
    return MaterialPageRoute(
      builder: (_) => ViewStatementPage(reference, modal),
    );
  }

  void onPressed(BuildContext context, int i) {
    InvoiceModal invoice = modal.transaction[i];
    var voucherType = '${invoice.vchType}'.toLowerCase();

    // Credit note
    if (voucherType == 'credit note') {
      var page = ViewCreditPage.page(invoice.setLedger(reference));
      Navigator.push(context, page);
    }
    // Debit
    if (voucherType == 'debit note') {
      var page = ViewDebitPage.page(invoice.setLedger(reference));
      Navigator.push(context, page);
    }
    // Purchase
    if (voucherType == 'purchase') {
      var page = ViewPurchasePage.page(invoice.setLedger(reference));
      Navigator.push(context, page);
    }
    // Payment
    if (voucherType == 'payment') {
      var page = ViewPaymentPage.page(invoice.setLedger(reference));
      Navigator.push(context, page);
    }
    // Receipt
    if (voucherType == 'receipt') {
      var page = ViewReceiptsPage.page(invoice.setLedger(reference));
      Navigator.push(context, page);
    }
    // Sales
    if (voucherType == 'sales') {
      var page = ViewSalesPage.page(invoice.setLedger(reference));
      Navigator.push(context, page);
    }

    debugPrint('${invoice.vchType}');
  }

  @override
  Widget build(BuildContext context) {
    var style = const TextStyle(color: Colors.white);
    var borderWhite = Border.all(color: Colors.white, width: 0.5);
    return Scaffold(
      appBar: Toolbar('ACCOUNT STATEMENT', actions: [
        IconButton(
          onPressed: () {
            var route = ViewAccountPdf.page(modal);
            Navigator.push(context, route);
          },
          icon: const Icon(Icons.picture_as_pdf),
        ),
      ]),
      body: FutureBuilder(
          future: db.getCompanyQuery(reference.parent),
          builder: (_, AsyncSnapshot<DocumentSnapshot<CompanyModal>> snapshot) {
            if (snapshot.hasData) {
              var company = snapshot.data?.data() ?? CompanyModal();
              modal.setDocument(reference.id, company);
              debugPrint('Company Name ${company.getName}');
              return Column(children: [
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    bottom: 9,
                    right: 18,
                    left: 18,
                    top: 18,
                  ),
                  child: Text(
                    company.getName,
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    bottom: 9,
                    right: 18,
                    left: 18,
                    top: 9,
                  ),
                  child: const Text('LEDGER ACCOUNT'),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    bottom: 9,
                    right: 18,
                    left: 18,
                    top: 9,
                  ),
                  child: Text(
                    modal.name,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    bottom: 9,
                    right: 18,
                    left: 18,
                    top: 9,
                  ),
                  child: Text(
                    modal.gst,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Container(
                  alignment: Alignment.center,
                  padding: const EdgeInsets.only(
                    bottom: 18,
                    right: 18,
                    left: 18,
                    top: 9,
                  ),
                  child: Text(
                    modal.period,
                    style: const TextStyle(fontWeight: FontWeight.w600),
                  ),
                ),
                Expanded(
                  child: StreamLoader(
                    stream: db.getTransactions(modal.reference!, modal.id),
                    builder: (List<QueryDocumentSnapshot<m.Transaction>> docs) {
                      modal.setTransaction(docs.map((e) => e.data()).toList());
                      return LazyDataTable(
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
                        dataCellBuilder: (i, j) => Center(
                          child: j == 2
                              ? TextButton(
                                  child: modal.data(i, j),
                                  onPressed: () => onPressed(context, i - 1),
                                )
                              : modal.data(i, j),
                        ),
                        leftHeaderBuilder: (i) =>
                            Center(child: Text(modal.date(i), style: style)),
                        topLeftCornerWidget:
                            Center(child: Text(header[0], style: style)),
                      );
                    },
                  ),
                )
              ]);
            }
            return const LoaderPage();
          }),
    );
  }
}
