import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/company/addon/select/select.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

import '../view/view_quotation.dart';

class AddQuotationPage extends StatefulWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const AddQuotationPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddQuotationPage(document));
  }

  @override
  State<AddQuotationPage> createState() => _QuotationState();
}

class _QuotationState extends State<AddQuotationPage> {
  late DocumentReference<CompanyModal> reference;
  final modal = QuotationModal();

  @override
  void initState() {
    super.initState();

    reference = widget.document.reference;
    modal.company = widget.document.data();

    Future.delayed(Duration.zero, () async {
      var pageLedger = SelectLedgerPage.page(reference);
      var ledger = await Navigator.push(context, pageLedger);

      if (ledger == null) {
        Navigator.pop(context);
        return;
      }
      modal.ledger = ledger;
      onPressed();
    });
  }

  void onPressed() async {
    var page = SelectItemPage.page(reference);
    var result = await Navigator.push(context, page);

    if (result != null) {
      List<Product> items = Product.formResults(result);
      setState(() => modal.addAll(items));
    }
  }

  Widget viewItem(Product item) {
    var controllerPrice = TextEditingController(text: item.price);
    var controller = TextEditingController(text: item.description);
    return CardView(item.name, children: [
      TextFormField(
        controller: controllerPrice,
        keyboardType: TextInputType.number,
        onChanged: (value) => item.price = value,
        decoration: InputDecoration(
          labelText: 'Price',
          suffixIcon: IconButton(
            alignment: Alignment.topRight,
            onPressed: () => setState(() => modal.remove(item)),
            icon: const Icon(
              Icons.remove_shopping_cart,
              color: Colors.red,
            ),
          ),
          border: const UnderlineInputBorder(),
        ),
      ),
      TextFormField(
        minLines: 1,
        maxLines: 3,
        controller: controller,
        onChanged: (value) => item.description = value,
        keyboardType: TextInputType.multiline,
        decoration: const InputDecoration(
          border: UnderlineInputBorder(),
          fillColor: Colors.white,
          labelText: 'Description',
          filled: true,
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ADD QUOTATION'),
      body: Column(children: [
        Expanded(
          child: ListView(children: [
            CardView('TO', children: [
              Text(modal.ledger.name ?? ''),
              Text(modal.ledger.partyGstin ?? ''),
              Text(modal.ledger.address ?? ''),
            ]),
            Container(
              child: const Text(
                'ITEMS',
                style: TextStyle(
                  fontSize: 18,
                  letterSpacing: 3,
                  fontWeight: FontWeight.bold,
                ),
              ),
              padding: const EdgeInsets.all(12),
            ),
            ...modal.items.map(viewItem).toList(),
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
              var route = ViewQuotation.page(modal);
              Navigator.push(context, route);
            },
            child: const Text('VIEW SUMMARY'),
          ),
          ElevatedButton(
            onPressed: () async {
              db.getQuotation(reference).add(modal);
              Navigator.pop(context, true);
            },
            child: const Text('SAVE QUOTATION'),
          ),
        ]),
      ]),
    );
  }
}
