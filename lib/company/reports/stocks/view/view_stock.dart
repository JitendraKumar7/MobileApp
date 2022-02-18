import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class ViewStockPage extends StatefulWidget {
  final StockModal modal;

  static Route page(StockModal modal) {
    return MaterialPageRoute(builder: (_) => ViewStockPage(modal));
  }

  const ViewStockPage(this.modal, {Key? key}) : super(key: key);

  @override
  State<ViewStockPage> createState() => _ViewStockPageState();
}

class _ViewStockPageState extends State<ViewStockPage> {
  ExpansionPanel itemView(StockItem modal) {
    return ExpansionPanel(
      body: Table(children: [
        TableRow(children: [
          Text('${modal.rate}'),
          Text('${modal.quantity}'),
        ]),
        TableRow(children: [
          Text('${modal.amount}'),
          Text('${modal.openingBalance}'),
        ]),
      ]),
      canTapOnHeader: true,
      isExpanded: modal.isExpanded,
      headerBuilder: (BuildContext context, bool isExpanded) {
        return ListTile(
          leading: const Leading(reportStocks),
          title: Text(
            modal.getName,
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(12),
          child: ExpansionPanelList(
            expansionCallback: (int index, bool isExpanded) {
              var item = widget.modal.items[index];
              setState(() => item.isExpanded = !item.isExpanded);
            },
            children: widget.modal.items.map(itemView).toList(),
          ),
        ),
      ),
      appBar: Toolbar(widget.modal.name),
    );
  }
}
