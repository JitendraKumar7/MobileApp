import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_proforma.dart';
import 'view/view_proforma.dart';

class ProformaPage extends StatelessWidget {
  ProformaPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => ProformaPage(document));
  }

  final QueryDocumentSnapshot<CompanyModal> document;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<ProformaModal>> _list = [];
    return Scaffold(
      appBar: const Toolbar('PROFORMA INVOICE'),
      body: SearchStreamBuilder(
        stream: db.getProforma(document.reference).snapshots(),
        builder: (List<QueryDocumentSnapshot<ProformaModal>> snapshot) {
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
                      var name = modal.ledger.name!.toLowerCase();
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
                      var route = ViewProformaInvoice.page(modal);
                      Navigator.push(context, route);
                    },
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.domain,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(modal.ledger.name ?? ''),
                    subtitle: Text(modal.date),
                  ),
                );
              }).toList(),
            );
          });
        },
        controller: controller,
      ),
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
