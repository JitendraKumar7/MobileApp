import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_quotation.dart';
import 'view/view_quotation.dart';

class QuotationPage extends StatelessWidget {
  final DocumentReference reference;

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => QuotationPage(reference));
  }

  const QuotationPage(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db
            .quotation(reference)
            .orderBy('TIMESTAMP', descending: true)
            .snapshots(),
        filter: (QuotationModal modal, String value) {
          var name = modal.name.toLowerCase();
          return name.contains(value);
        },
        builder: (QuotationModal modal) => ListTile(
          onTap: () {
            var route = ViewQuotation.page(reference, modal);
            Navigator.push(context, route);
          },
          title: ListTitle(modal.name),
          leading: const Leading(addonQuotation),
          subtitle: ListSubTitle(modal.id, modal.date),
          //subtitle: Text(modal.date),
        ),
      ),
      appBar: const Toolbar('QUOTATION'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var route = AddQuotationPage.page(reference);
          Navigator.push(context, route);
        },
      ),
    );
  }
}
