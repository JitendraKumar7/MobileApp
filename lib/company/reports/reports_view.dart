import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import 'debit/debit.dart';
import 'sales/sales.dart';
import 'credit/credit.dart';
import 'payment/payment.dart';
import 'receipts/receipts.dart';
import 'purchase/purchase.dart';

import 'widget/statement.dart';
import 'widget/stock.dart';

class ReportsView extends StatelessWidget {
  const ReportsView(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => ReportsView(document));
  }

  final QueryDocumentSnapshot<CompanyModal> document;

  @override
  Widget build(BuildContext context) {
    var reference = document.reference;
    return Scaffold(
      appBar: const Toolbar('REPORTS'),
      body: Column(children: [
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportSales,
              label: 'Sales',
              onTap: () {
                var page = SalesPage.page(document);
                Navigator.push(context, page);
              },
            ),
            const VerticalDivider(),
            ButtonView(
              name: reportPurchase,
              label: 'Purchase',
              onTap: () {
                var page = PurchasePage.page(document);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportReceipts,
              label: 'Receipts',
              onTap: () {
                var page = ReceiptsPage.page(document);
                Navigator.push(context, page);
              },
            ),
            const VerticalDivider(),
            ButtonView(
              name: reportPayments,
              label: 'Payments',
              onTap: () {
                var page = PaymentsPage.page(document);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportDebitNotes,
              label: 'Debit Notes',
              onTap: () {
                var page = DebitPage.page(document);
                Navigator.push(context, page);
              },
            ),
            const VerticalDivider(),
            ButtonView(
              name: reportCreditNotes,
              label: 'Credit Notes',
              onTap: () {
                var page = CreditPage.page(document);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportStocks,
              label: 'Stocks',
              onTap: () {
                var page = StockPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            const VerticalDivider(),
            ButtonView(
              name: reportStatement,
              label: 'Acc. Statements',
              onTap: () {
                var page = StatementPage.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
