import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../view/view_sales.dart';
import '../../widget/widget.dart';

class AddSalesOrderPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;
  final modal = OrderModal();

  AddSalesOrderPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddSalesOrderPage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ADD SALES'),
      body: Column(children: [
        ExpandedView(document, modal: modal),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              var route = ViewSalesOrder.page(modal);
              Navigator.push(context, route);
            },
            child: const Text('VIEW SUMMARY'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (modal.items.isNotEmpty) {
                db
                    .salesOrder(document.reference)
                    .doc(modal.document)
                    .set(modal);
                Navigator.pop(context, true);
              }
            },
            child: const Text('PLACE ORDER'),
          ),
        ]),
      ]),
    );
  }
}
