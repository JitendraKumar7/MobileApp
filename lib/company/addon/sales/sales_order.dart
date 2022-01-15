import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_sales.dart';
import 'view/view_sales.dart';

class SalesPage extends StatelessWidget {
  SalesPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => SalesPage(document));
  }

  final QueryDocumentSnapshot<CompanyModal> document;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<OrderModal>> _list = [];
    return Scaffold(
      appBar: const Toolbar('SALES ORDER'),
      body: SearchStreamBuilder(
        stream: db.getSalesOrder(document.reference).snapshots(),
        builder: (List<QueryDocumentSnapshot<OrderModal>> snapshot) {
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
                      var route = ViewSalesOrder.page(modal);
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
        child: const Icon(Icons.shopping_cart),
        onPressed: () {
          var route = AddSalesOrderPage.page(document);
          Navigator.push(context, route);
        },
      ),
    );
  }
}
