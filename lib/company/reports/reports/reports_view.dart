import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

typedef TapCallback<InvoiceModal> = void Function(InvoiceModal modal);

class ReportsViewPage extends StatelessWidget {
  final QueryDocumentSnapshot<MonthModal> document;
  final TapCallback<InvoiceModal> callback;

  const ReportsViewPage({
    Key? key,
    required this.callback,
    required this.document,
  }) : super(key: key);

  static Route page(
    QueryDocumentSnapshot<MonthModal> document,
    TapCallback<InvoiceModal> callback,
  ) {
    return MaterialPageRoute(
      builder: (_) => ReportsViewPage(document: document, callback: callback),
    );
  }

  @override
  Widget build(BuildContext context) {
    var id = document.reference.parent.id;
    var title = '$id - ${document.id}'.toUpperCase();
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getInvoiceByMonth(document.reference),
        filter: (InvoiceModal modal, String value) {
          var name = modal.partyName.toLowerCase();
          return name.contains(value.toLowerCase());
        },
        builder: (InvoiceModal modal) => ListTile(
          onTap: () => callback(modal),
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
          leading: const Leading(report),
        ),
      ),
      appBar: Toolbar(title),
    );
  }
}
