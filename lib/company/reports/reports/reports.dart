import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/widget/widget.dart';

import '../reports_view.dart';

class ReportsView extends StatelessWidget {
  const ReportsView(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => ReportsView(reference));
  }

  final DocumentReference reference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFEECEA),
      appBar: const Toolbar('BUSINESS REPORTS'),
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(18),
          child: ListTitle(
            reference.parent.id.split('-').first,
            color: Colors.blue,
          ),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportSales,
              label: 'Sales',
              onTap: () {
                var page = SalesPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: reportPurchase,
              label: 'Purchase',
              onTap: () {
                var page = PurchasePage.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportReceipts,
              label: 'Receipts',
              onTap: () {
                var page = ReceiptsPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: reportPayments,
              label: 'Payments',
              onTap: () {
                var page = PaymentsPage.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportDebitNotes,
              label: 'Debit Notes',
              onTap: () {
                var page = DebitPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: reportCreditNotes,
              label: 'Credit Notes',
              onTap: () {
                var page = CreditPage.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportStatement,
              label: 'Statements',
              onTap: () {
                var page = StatementPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: reportStocks,
              label: 'Outstanding',
              onTap: () {
                var page = OutstandingPage.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
