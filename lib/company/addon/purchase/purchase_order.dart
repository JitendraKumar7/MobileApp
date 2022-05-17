import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_purchase.dart';
import 'view/view_purchase.dart';

class PurchasePage extends StatelessWidget {
  final DocumentReference reference;

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => PurchasePage(reference));
  }

  const PurchasePage(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db
            .purchaseOrder(reference)
            .orderBy('TIMESTAMP', descending: true)
            .snapshots(),
        filter: (OrderModal modal, String value) {
          var name = modal.name.toLowerCase();
          return name.contains(value);
        },
        builder: (OrderModal modal) => ListTile(
          onTap: () {
            var route = ViewPurchaseOrder.page(reference, modal);
            Navigator.push(context, route);
          },
          title: ListTitle(modal.name),
          leading: const Leading(addonPurchaseOrder),
          subtitle: ListSubTitle(modal.id, modal.date),
          //subtitle: Text(modal.date),
        ),
      ),
      appBar: const Toolbar('PURCHASE ORDER'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var route = AddPurchaseOrderPage.page(reference);
          Navigator.push(context, route);
        },
      ),
    );
  }
}
