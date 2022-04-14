import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tally/constant/constant.dart';
import 'package:tally/widget/widget.dart';
import 'package:tally/modal/modal.dart';

import '../reports_view.dart';

class ReportsView extends StatelessWidget {
  const ReportsView(this.docs, {Key? key}) : super(key: key);

  static Route page(List<QueryDocumentSnapshot<CompanyModal>> docs) {
    return MaterialPageRoute(builder: (_) => ReportsView(docs));
  }

  final List<QueryDocumentSnapshot<CompanyModal>> docs;

  @override
  Widget build(BuildContext context) {
    QueryDocumentSnapshot<CompanyModal> document = docs.first;
    return Scaffold(
      appBar: Toolbar('BUSINESS REPORTS', actions: [
        SizedBox(
          width: 110,
          child: StatefulBuilder(builder: (context, setState) {
            return DropdownButtonFormField(
              value: document,
              dropdownColor: Colors.grey,
              iconEnabledColor: Colors.white,
              decoration: const InputDecoration(
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                    style: BorderStyle.none,
                    width: 0,
                  ),
                ),
              ),
              onChanged: (QueryDocumentSnapshot<CompanyModal>? value) {
                if (value != null) {
                  setState(() => document = value);
                }
              },
              items: docs.map((value) {
                return DropdownMenuItem(
                  value: value,
                  child: Text(
                    value.id,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 10,
                    ),
                  ),
                );
              }).toList(),
            );
          }),
        )
      ]),
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(18),
          child: ListTitle(document.data().getName),
        ),
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
            //const VerticalDivider(),
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
        //const Divider(),
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
            //const VerticalDivider(),
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
        //const Divider(),
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
            //const VerticalDivider(),
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
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: reportStocks,
              label: 'Stocks',
              onTap: () {
                var page = StockPage.page(document.reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: reportStatement,
              label: 'Statements',
              onTap: () {
                var page = StatementPage.page(document);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
