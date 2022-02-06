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
      appBar: Toolbar('ADD SALES ORDER', actions: [
        IconButton(
          onPressed: () {
            var route = ViewSalesOrder.page(modal);
            Navigator.push(context, route);
          },
          icon: const Icon(Icons.picture_as_pdf),
        ),
      ]),
      body: Column(children: [
        ExpandedView(
          document,
          modal: modal,
          header: 'YOUR CART',
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(180, 45)),
          onPressed: () async {
            if (modal.items.isNotEmpty) {
              db.salesOrder(document.reference).doc(modal.document).set(modal);
              Navigator.pop(context, true);
            }
          },
          child: const Text('CONFIRM'),
        ),
      ]),
    );
  }
}
