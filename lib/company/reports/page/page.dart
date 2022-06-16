import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

typedef TapCallback<InvoiceModal> = void Function(InvoiceModal modal);

class ReportsPage extends StatelessWidget {
  final QueryDocumentSnapshot<MonthModal> document;
  final TapCallback<InvoiceModal> callback;

  const ReportsPage({
    Key? key,
    required this.callback,
    required this.document,
  }) : super(key: key);

  static Route page(
    QueryDocumentSnapshot<MonthModal> document,
    TapCallback<InvoiceModal> callback,
  ) {
    return MaterialPageRoute(
      builder: (_) => ReportsPage(document: document, callback: callback),
    );
  }

  @override
  Widget build(BuildContext context) {
    var id = document.reference.parent.id;
    var title = '$id - ${document.id}'.toUpperCase();
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getInvoiceByMonth(document.reference).snapshots(),
        filter: (InvoiceModal modal, String value) {
          var name = modal.partyName.toLowerCase();
          return name.contains(value);
        },
        builder: (InvoiceModal modal) => ListTile(
          subtitle: ListSubTitle(modal.id, modal.date),
          title: ListTitle(modal.partyName),
          leading: const Leading(report),
          onTap: () => callback(modal),
        ),
      ),
      appBar: Toolbar(title),
    );
  }
}

class AllReportsPage extends StatelessWidget {
  final List<QueryDocumentSnapshot<MonthModal>> docs;
  final TapCallback<InvoiceModal> callback;

  const AllReportsPage({
    Key? key,
    required this.docs,
    required this.callback,
  }) : super(key: key);

  static Route page(
    List<QueryDocumentSnapshot<MonthModal>> docs,
    TapCallback<InvoiceModal> callback,
  ) {
    return MaterialPageRoute(
      builder: (_) => AllReportsPage(docs: docs, callback: callback),
    );
  }

  Future<List<QueryDocumentSnapshot<InvoiceModal>>> getInvoiceAllMonth() async {
    List<QueryDocumentSnapshot<InvoiceModal>> list = [];
    await Future.forEach(docs, (QueryDocumentSnapshot<MonthModal> doc) async {
      var data = await db.getInvoiceByMonth(doc.reference).get();
      list.addAll(data.docs);
    });
    return list;
  }

  @override
  Widget build(BuildContext context) {
    var id = docs.first.reference.parent.id;
    var title = id.toUpperCase();
    return Scaffold(
      body: FutureBuilder(
        future: getInvoiceAllMonth(),
        builder: (_,
            AsyncSnapshot<List<QueryDocumentSnapshot<InvoiceModal>>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data ?? [];
            return data.isEmpty
                ? const EmptyView()
                : SearchView(data, (InvoiceModal modal, String value) {
                    var name = modal.partyName.toLowerCase();
                    return name.contains(value);
                  },
                    (InvoiceModal modal) => ListTile(
                          subtitle: ListSubTitle(modal.id, modal.date),
                          title: ListTitle(modal.partyName),
                          leading: const Leading(report),
                          onTap: () => callback(modal),
                        ));
          }
          return const LoaderPage();
        },
      ),
      appBar: Toolbar(title),
    );
  }
}
