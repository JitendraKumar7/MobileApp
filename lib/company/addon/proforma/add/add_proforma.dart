import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../widget/widget.dart';
import '../view/view_proforma.dart';

class AddProformaInvoicePage extends StatelessWidget {
  final DocumentReference reference;
  final modal = ProformaModal();

  AddProformaInvoicePage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => AddProformaInvoicePage(reference));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Toolbar('ADD PROFORMA INVOICE', actions: [
        IconButton(
          onPressed: () {
            var route = ViewProformaInvoice.page(reference, modal);
            Navigator.push(context, route);
          },
          icon: const Icon(Icons.picture_as_pdf),
        ),
      ]),
      body: Column(children: [
        ExpandedView(
          reference,
          modal: modal,
          tax: (bool integratedTax) {
            modal.integratedTax = integratedTax;
          },
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(180, 45)),
          onPressed: () async {
            if (modal.items.isNotEmpty) {
              db.proformaInvoice(reference).doc(modal.document).set(modal);
              Navigator.pop(context, true);
            }
          },
          child: const Text('CONFIRM'),
        ),
      ]),
    );
  }
}
