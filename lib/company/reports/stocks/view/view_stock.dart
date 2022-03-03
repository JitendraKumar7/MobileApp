import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class ViewStockPage extends StatelessWidget {
  final StockModal modal;

  static Route page(StockModal modal) {
    return MaterialPageRoute(builder: (_) => ViewStockPage(modal));
  }

  const ViewStockPage(this.modal, {Key? key}) : super(key: key);

  Widget itemView(StockItem modal) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        leading: const Leading(reportStocks),
        title: ListTitle(modal.getName),
        subtitle: ListSubTitle(
          'Op Bal. ${modal.openingBalance}',
          'Cl Bal. ${modal.quantity}',
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(6),
        children: modal.items.map(itemView).toList(),
      ),
      appBar: Toolbar(modal.name),
    );
  }
}
