import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';
import 'package:tally/company/addon/select/select.dart';

import '../view/view_proforma.dart';

class AddProformaInvoicePage extends StatefulWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const AddProformaInvoicePage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddProformaInvoicePage(document));
  }

  @override
  State<AddProformaInvoicePage> createState() => _ProformaInvoiceState();
}

class _ProformaInvoiceState extends State<AddProformaInvoicePage> {
  late DocumentReference<CompanyModal> reference;
  final modal = ProformaModal();

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
      List<ProductModal> items = ProductModal.formResults(result);
      var value = await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => builder(items),
      );
      setState(() {
        if (value != null) {
          modal.addAll(items);
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ADD INVOICE'),
      body: Column(children: [
        Expanded(
          child: ListView(children: [
            CardView('TO', children: [
              Text(modal.ledger.name ?? ''),
              Text(modal.ledger.partyGstin ?? ''),
              Text(modal.ledger.address ?? ''),
            ]),
            Row(children: [
              Expanded(
                child: RadioListTile(
                  title: const Text('Center Tax'),
                  groupValue: modal.integratedTax,
                  value: true,
                  onChanged: (bool? value) {
                    setState(() => modal.integratedTax = true);
                  },
                ),
              ),
              Expanded(
                child: RadioListTile(
                  title: const Text('Local Tax'),
                  groupValue: modal.integratedTax,
                  value: false,
                  onChanged: (bool? value) {
                    setState(() => modal.integratedTax = false);
                  },
                ),
              ),
            ]),
            ...modal.products.map(viewItem).toList(),
            Container(
              alignment: const Alignment(0.9, 0.0),
              child: FloatingActionButton(
                child: const Icon(Icons.add_shopping_cart),
                onPressed: onPressed,
              ),
            ),
          ]),
        ),
        Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          ElevatedButton(
            onPressed: () {
              var route = ViewProformaInvoice.page(modal);
              Navigator.push(context, route);
            },
            child: const Text('VIEW SUMMARY'),
          ),
          ElevatedButton(
            onPressed: () async {
              db.getProforma(reference).add(modal);
              Navigator.pop(context, true);
            },
            child: const Text('SAVE INVOICE'),
          ),
        ]),
      ]),
    );
  }

  Widget viewItem(ProductModal item) {
    return Card(
      child: ListTile(
        title: Text(
          item.name,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          alignment: Alignment.topRight,
          onPressed: () => setState(() => modal.remove(item)),
          icon: const Icon(
            Icons.remove_shopping_cart,
            color: Colors.red,
          ),
        ),
        leading: const CircleAvatar(
          child: Icon(
            Icons.shopping_cart,
            color: Colors.white,
          ),
        ),
        subtitle:
            Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
          Text('₹${item.price} x ${item.quantity} ${item.unit}'),
          Text('${item.gst}%'),
          Text('₹${item.totalAmount.toStringAsFixed(2)}'),
        ]),
      ),
    );
  }

  Widget builder(List<ProductModal> products) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      appBar: const Toolbar('ITEMS DETAILS'),
      body: BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5.0,
          sigmaY: 5.0,
        ),
        child: DefaultTabController(
          length: products.length,
          child: StatefulBuilder(builder: (context, setState) {
            return TabBarView(
              physics: const NeverScrollableScrollPhysics(),
              children: products.map((item) {
                var controller = DefaultTabController.of(context);
                var index = products.indexWhere((e) => e == item);
                return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      CardView(item.name, children: [
                        const SizedBox(height: 0),
                        TextFormField(
                          controller: TextEditingController(text: item.unit),
                          onChanged: (value) => item.unit = value,
                          decoration: InputDecoration(
                            errorText: item.unitError,
                            labelText: 'Unit',
                            helperText: '',
                          ),
                        ),
                        TextFormField(
                          controller: TextEditingController(text: item.price),
                          onChanged: (value) => item.price = value,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            errorText: item.priceError,
                            labelText: 'Price',
                            helperText: '',
                          ),
                        ),
                        TextFormField(
                          controller:
                              TextEditingController(text: item.quantity),
                          onChanged: (value) => item.quantity = value,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            errorText: item.quantityError,
                            labelText: 'Quantity',
                            helperText: '',
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                onPressed: index == 0
                                    ? null
                                    : () {
                                        controller?.index -= 1;
                                      },
                                child: const Text('BACK'),
                              ),
                              Text('${index + 1} / ${products.length}'),
                              index == products.length - 1
                                  ? ElevatedButton(
                                      onPressed: () {
                                        setState(() => debugPrint('SAVE'));
                                        Navigator.pop(context, products);
                                      },
                                      child: const Text('SUMMERY'),
                                    )
                                  : ElevatedButton(
                                      onPressed: () {
                                        if (item.isValid()) {
                                          controller?.index += 1;
                                        }
                                        setState(() => debugPrint('NEXT'));
                                      },
                                      child: const Text('NEXT'),
                                    ),
                            ]),
                      ]),
                    ]);
              }).toList(),
            );
          }),
        ),
      ),
    );
  }
}
