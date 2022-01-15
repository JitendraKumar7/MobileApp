import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_receipts.dart';

class ReceiptsPage extends StatelessWidget {
  ReceiptsPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => ReceiptsPage(document));
  }

  final QueryDocumentSnapshot<CompanyModal> document;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<InvoiceModal>> _list = [];
    return Scaffold(
      appBar: const Toolbar('RECEIPTS'),
      body: SearchStreamBuilder(
        stream: db.getReceipts(document.reference),
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
                      var name = modal.partyLedgerName!.toLowerCase();
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
                      var page = ViewReceiptsPage.page(
                        company: this.document.data(),
                        modal: modal,
                      );
                      Navigator.push(context, page);
                    },
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(modal.partyLedgerName ?? ''),
                  ),
                );
              }).toList(),
            );
          });
        },
        controller: controller,
      ),
    );
  }
}
