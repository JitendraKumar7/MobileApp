import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../widget/widget.dart';
import '../view/view_purchase.dart';

class AddPurchaseOrderPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;
  final modal = OrderModal();

  AddPurchaseOrderPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddPurchaseOrderPage(document));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ADD PURCHASE'),
      body: Column(children: [
        ExpandedView(document, modal: modal),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              var route = ViewPurchaseOrder.page(modal);
              Navigator.push(context, route);
            },
            child: const Text('VIEW SUMMARY'),
          ),
          ElevatedButton(
            onPressed: () async {
              if (modal.items.isNotEmpty) {
                db
                    .purchaseOrder(document.reference)
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
