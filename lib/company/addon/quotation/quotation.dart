import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_quotation.dart';
import 'view/view_quotation.dart';

class QuotationPage extends StatelessWidget {
  QuotationPage(this.document,{Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => QuotationPage(document));
  }

  final QueryDocumentSnapshot<CompanyModal> document;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<QuotationModal>> _list = [];
    return Scaffold(
      appBar: const Toolbar('QUOTATION'),
      body: SearchStreamBuilder(
        stream: db.getQuotation(document.reference).snapshots(),
        builder: (List<QueryDocumentSnapshot<QuotationModal>> snapshot) {
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
                      var route = ViewQuotation.page(modal);
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
          var route = AddQuotationPage.page(document);
          Navigator.push(context, route);
        },
      ),
    );
  }
}