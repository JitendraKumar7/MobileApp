import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_stock.dart';

class StockPage extends StatelessWidget {
  final DocumentReference reference;

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => StockPage(reference));
  }

  const StockPage(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getStock(reference),
        filter: (StockModal modal, String value) {
          var name = modal.name.toLowerCase();
          var exist = modal.items.any((e) {
            return e.any(value.toLowerCase());
          });
          debugPrint('$name => exist $exist');
          return name.contains(value.toLowerCase());
        },
        builder: (StockModal modal) => ListTile(
          onTap: () {
            var page = ViewStockPage.page(modal);
            Navigator.push(context, page);
          },
          leading: const Leading(reportStocks),
          title: ListTitle(modal.name),
        ),
      ),
      appBar: const Toolbar('STOCKS'),
    );
  }
}
