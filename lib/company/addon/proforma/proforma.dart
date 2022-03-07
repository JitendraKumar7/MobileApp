import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_proforma.dart';
import 'view/view_proforma.dart';

class ProformaPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const ProformaPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => ProformaPage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db
            .proformaInvoice(document.reference)
            .orderBy('TIMESTAMP', descending: true)
            .snapshots(),
        filter: (ProformaModal modal, String value) {
          var name = modal.name.toLowerCase();
          return name.contains(value);
        },
        builder: (ProformaModal modal) => ListTile(
          onTap: () {
            var route = ViewProformaInvoice.page(modal);
            Navigator.push(context, route);
          },
          title: ListTitle(modal.name),
          leading: const Leading(addonProformaInvoice),
          subtitle: ListSubTitle(modal.id, modal.date),
          //subtitle: Text(modal.date),
        ),
      ),
      appBar: const Toolbar('PROFORMA INVOICE'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var route = AddProformaInvoicePage.page(document);
          Navigator.push(context, route);
        },
      ),
    );
  }
}
