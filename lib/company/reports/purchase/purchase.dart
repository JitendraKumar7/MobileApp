import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_purchase.dart';

class PurchasePage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const PurchasePage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => PurchasePage(document));
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
      appBar: const Toolbar('PURCHASE'),
    );
  }
}
class PurchasePage1 extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const PurchasePage1(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => PurchasePage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getPurchase(document.reference),
        filter: (InvoiceModal modal, String value) {
          var name = modal.partyName.toLowerCase();
          return name.contains(value.toLowerCase());
        },
        builder: (InvoiceModal modal) => ListTile(
          onTap: () {
            var page = ViewPurchasePage.page(modal.setLedger(document));
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
          leading: const Leading(reportPurchase),
        ),
      ),
      appBar: const Toolbar('PURCHASE'),
    );
  }
}

/*
* body: SearchStreamBuilder(
        stream: db.getPurchase(document.reference),
        builder: (List<QueryDocumentSnapshot<InvoiceModal>> snapshot) {
          _list = snapshot;
          return StatefulBuilder(builder: (_, StateSetter setState) {
            controller.addListener(() => setState(() {
                  String value = controller.text;
                  if (value.isEmpty) {
                    _list = snapshot;
                  }
                  // Search Data
                  else {
                    _list = [];
                    for (var document in snapshot) {
                      var modal = document.data();
                      var name =  modal.partyName.toLowerCase();
                      if (name.contains(value.toLowerCase())) {
                        _list.add(document);
                      }
                    }
                  }
                }));
            return Column(
              children: _list.map<Widget>((document) {
                var modal = document.data();
                return Card(
                  child: ListTile(
                    onTap: () {
                      var page = ViewPurchasePage.page(
                        company: this.document.data(),
                        modal: modal,
                      );
                      Navigator.push(context, page);
                    },
                    title: Text(
                      modal.partyName,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    subtitle: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(modal.id),
                          Text(modal.date),
                        ]),
                    leading: const Leading(reportPurchase),
                  ),
                );
              }).toList(),
            );
          });
        },
        controller: controller,
      ),
* */
