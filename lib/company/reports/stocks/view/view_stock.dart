import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class ViewStockPage extends StatelessWidget {
  final StockModal modal;

  static Route page(StockModal modal) {
    return MaterialPageRoute(builder: (_) => ViewStockPage(modal));
  }

  const ViewStockPage(this.modal, {Key? key}) : super(key: key);

  Widget itemView(ItemModal modal) {
    return Card(
      clipBehavior: Clip.hardEdge,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(6),
      ),
      child: ListTile(
        onTap: () {
          //var page = MasterItemView.page(modal);
          //Navigator.push(context, page);
        },
        leading: const CircleAvatar(
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
        ),
        title: Text(
          modal.getName,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        padding: const EdgeInsets.all(12),
        children: modal.items.map(itemView).toList(),
      ),
      appBar: const Toolbar('STOCKS'),
    );
  }
}
