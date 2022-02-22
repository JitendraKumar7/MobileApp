import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_payment.dart';

class PaymentsPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const PaymentsPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => PaymentsPage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(children: [
        Expanded(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(onPressed: () {}, child: const Text('APRIL')),
            TextButton(onPressed: () {}, child: const Text('MAY')),
          ]),
        ),
        const Divider(),
        Expanded(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(onPressed: () {}, child: const Text('JUNE')),
            TextButton(onPressed: () {}, child: const Text('JULY')),
          ]),
        ),
        const Divider(),
        Expanded(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(onPressed: () {}, child: const Text('AUGUST')),
            TextButton(onPressed: () {}, child: const Text('SEPTEMBER')),
          ]),
        ),
        const Divider(),
        Expanded(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(onPressed: () {}, child: const Text('OCTOBER')),
            TextButton(onPressed: () {}, child: const Text('NOVEMBER')),
          ]),
        ),
        const Divider(),
        Expanded(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(onPressed: () {}, child: const Text('DECEMBER')),
            TextButton(onPressed: () {}, child: const Text('JANUARY')),
          ]),
        ),
        const Divider(),
        Expanded(
          child:
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(onPressed: () {}, child: const Text('FEBRUARY')),
            TextButton(onPressed: () {}, child: const Text('MARCH')),
          ]),
        ),
        const Divider(),
      ]),
      appBar: const Toolbar('PAYMENTS'),
    );
  }
}
class PaymentsPage1 extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const PaymentsPage1(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => PaymentsPage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getPayments(document.reference),
        filter: (InvoiceModal modal, String value) {
          var name = modal.partyName.toLowerCase();
          return name.contains(value.toLowerCase());
        },
        builder: (InvoiceModal modal) => ListTile(
          onTap: () {
            var page = ViewPaymentPage.page(modal.setLedger(document));
            Navigator.push(context, page);
          },
          title: Text(
            modal.partyName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Row(
            children: [
              Text(
                modal.id,
                style: const TextStyle(fontSize: 12),
              ),
              Text(
                modal.date,
                style: const TextStyle(fontSize: 12),
              ),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
          ),
          leading: const Leading(reportPayments),
        ),
      ),
      appBar: const Toolbar('PAYMENTS'),
    );
  }
}
