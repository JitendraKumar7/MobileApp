import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_quotation.dart';
import 'view/view_quotation.dart';

class QuotationPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const QuotationPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => QuotationPage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db
            .quotation(document.reference)
            .orderBy('TIMESTAMP', descending: true)
            .snapshots(),
        filter: (QuotationModal modal, String value) {
          var name = modal.name.toLowerCase();
          return name.contains(value.toLowerCase());
        },
        builder: (QuotationModal modal) => ListTile(
          onTap: () {
            var route = ViewQuotation.page(modal);
            Navigator.push(context, route);
          },
          title: Text(
            modal.name,
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
          leading: const Leading(addonQuotation),
          //subtitle: Text(modal.date),
        ),
      ),
      appBar: const Toolbar('QUOTATION'),
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
