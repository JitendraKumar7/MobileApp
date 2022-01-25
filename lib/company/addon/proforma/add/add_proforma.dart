import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../widget/widget.dart';
import '../view/view_proforma.dart';

class AddProformaInvoicePage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;
  final modal = ProformaModal();

  AddProformaInvoicePage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddProformaInvoicePage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ADD INVOICE'),
      body: Column(children: [
        ExpandedView(
          document,
          modal: modal,
          tax: (bool integratedTax) {
            modal.integratedTax = integratedTax;
          },
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              var route = ViewProformaInvoice.page(modal);
              Navigator.push(context, route);
            },
            child: const Text('VIEW SUMMARY'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (modal.items.isNotEmpty) {
                db
                    .proformaInvoice(document.reference)
                    .doc(modal.document)
                    .set(modal);
                Navigator.pop(context, true);
              }
            },
            child: const Text('SAVE INVOICE'),
          ),
        ]),
      ]),
    );
  }
}
