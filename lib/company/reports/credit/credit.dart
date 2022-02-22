import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_credit.dart';

class CreditPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const CreditPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => CreditPage(document));
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
      appBar: const Toolbar('CREDIT NOTE'),
    );
  }
}

class CreditPage1 extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const CreditPage1(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => CreditPage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getCreditNote(document.reference),
        filter: (InvoiceModal modal, String value) {
          var name = modal.partyName.toLowerCase();
          return name.contains(value.toLowerCase());
        },
        builder: (InvoiceModal modal) => ListTile(
          onTap: () {
            var page = ViewCreditPage.page(modal.setLedger(document));
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
          leading: const Leading(reportCreditNotes),
        ),
      ),
      appBar: const Toolbar('CREDIT NOTE'),
    );
  }
}
