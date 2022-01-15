import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/company/addon/select/select.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

import '../view/view_sales.dart';

class AddSalesOrderPage extends StatefulWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const AddSalesOrderPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddSalesOrderPage(document));
  }

  @override
  State<AddSalesOrderPage> createState() => _SalesOrderState();
}

class _SalesOrderState extends State<AddSalesOrderPage> {
  late DocumentReference<CompanyModal> reference;
  final modal = OrderModal();

  @override
  void initState() {
    super.initState();

    reference = widget.document.reference;
    modal.company = widget.document.data();

    Future.delayed(Duration.zero, () async {
      var reference = widget.document.reference;
      var pageLedger = SelectLedgerPage.page(reference);
      var ledger = await Navigator.push(context, pageLedger);

      if (ledger == null) {
        Navigator.pop(context);
      }
      modal.ledger = ledger;
      onPressed();
    });
  }

  void onPressed() async {
    var page = SelectItemPage.page(widget.document.reference);
    var result = await Navigator.push(context, page);

    if (result != null) {
      List<ProductModal> items = ProductModal.formResults(result);
      setState(() => modal.addAll(items));
    }
  }

  Widget viewItem(ProductModal item) {
    return Card(
      child: ListTile(
        //contentPadding: EdgeInsets.zero,
        title: Text(
          item.name,
          style: const TextStyle(fontSize: 14),
        ),
        leading: const CircleAvatar(
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
        trailing: IconButton(
          alignment: Alignment.topRight,
          onPressed: () => setState(() => modal.remove(item)),
          icon: const Icon(
            Icons.remove_shopping_cart,
            color: Colors.red,
          ),
        ),
        subtitle: StatefulBuilder(builder: (context, setState) {
          var controller = TextEditingController(text: item.quantity);
          return Row(mainAxisAlignment: MainAxisAlignment.end, children: [
            SizedBox(
              width: 150,
              child: TextFormField(
                keyboardType: TextInputType.number,
                controller: controller,
                onChanged: (String? value) {
                  double q = double.tryParse('$value') ?? 1;
                  if (q > 1) {
                    item.quantity = '$q';
                  }
                  // default o
                  else {
                    item.quantity = '1';
                    controller.text = '1';
                  }
                },
                decoration: InputDecoration(
                    border: const UnderlineInputBorder(),
                    hintText: 'Quantity',
                    suffixIcon: IconButton(
                      alignment: Alignment.centerRight,
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() {
                        double q = double.tryParse(item.quantity) ?? 1;
                        item.quantity = '${q += 1}';
                      }),
                      icon: const Icon(Icons.add_circle),
                    ),
                    prefixIcon: IconButton(
                      alignment: Alignment.centerLeft,
                      padding: EdgeInsets.zero,
                      onPressed: () => setState(() {
                        double q = double.tryParse(item.quantity) ?? 1;
                        if (q > 1) {
                          item.quantity = '${q -= 1}';
                        }
                      }),
                      icon: const Icon(Icons.remove_circle),
                    ),
                    contentPadding: const EdgeInsets.fromLTRB(0, 12, 0, 12)),
              ),
            ),
          ]);
        }),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ADD SALES'),
      body: Column(children: [
        Expanded(
          child: ListView(children: [
            CardView('FROM', children: [
              Text(modal.ledger.name ?? ''),
              Text(modal.ledger.partyGstin ?? ''),
              Text(modal.ledger.address ?? ''),
            ]),
            ...modal.products.map(viewItem).toList(),
            Container(
              alignment: const Alignment(0.9, 0.0),
              child: FloatingActionButton(
                child: const Icon(Icons.add_shopping_cart),
                onPressed: onPressed,
              ),
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
              child: TextFormField(
                minLines: 3,
                maxLines: 9,
                onChanged: (value) => modal.remark = value,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'Remark',
                  filled: true,
                ),
                controller: TextEditingController(text: modal.remark),
              ),
            ),
          ]),
        ),
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
              db.getSalesOrder(reference).add(modal);
              Navigator.pop(context, true);
            },
            child: const Text('PLACE ORDER'),
          ),
        ]),
      ]),
    );
  }
}
