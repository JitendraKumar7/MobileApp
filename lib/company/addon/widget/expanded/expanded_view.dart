import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import '../widget.dart';

class ItemView extends StatelessWidget {
  final VoidCallback? onRemoved;
  final ProductModal modal;
  final bool description;

  const ItemView(
    this.modal, {
    Key? key,
    this.onRemoved,
    required this.description,
  }) : super(key: key);

  Widget _showQuantity() {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
      Text('₹${modal.rate}'),
      SizedBox(
        width: 80,
        child: TextFormField(
          controller: TextEditingController(text: modal.quantity),
          onChanged: (value) => modal.quantity = value,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            fillColor: Colors.white,
            labelText: 'Quantity',
            isDense: true,
            filled: true,
          ),
        ),
      ),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          modal.name,
          style: const TextStyle(fontSize: 14),
        ),
        trailing: IconButton(
          alignment: Alignment.topRight,
          onPressed: onRemoved,
          //onPressed: () => setState(() => widget.modal.remove(item)),
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
        subtitle: description
            ? TextFormField(
                controller: TextEditingController(text: modal.description),
                onChanged: (value) => modal.description = value,
                decoration: const InputDecoration(
                  border: UnderlineInputBorder(),
                  fillColor: Colors.white,
                  labelText: 'Description',
                  filled: true,
                ),
              )
            : _showQuantity(),
      ),
    );
  }
}

class ExpandedView extends StatefulWidget {
  final QueryDocumentSnapshot<CompanyModal> document;
  final Function(bool value)? tax;
  final bool description;
  final BaseModal modal;

  const ExpandedView(
    this.document, {
    Key? key,
    this.tax,
    required this.modal,
    this.description = false,
  }) : super(key: key);

  @override
  State<ExpandedView> createState() => _ExpandedViewState();
}

class _ExpandedViewState extends State<ExpandedView> {
  late DocumentReference<CompanyModal> reference;
  bool integratedTax = true;

  @override
  void initState() {
    super.initState();
    reference = widget.document.reference;
    widget.modal.company = widget.document.data();

    Future.delayed(Duration.zero, () async {
      var reference = widget.document.reference;
      var pageLedger = SelectLedgerPage.page(reference);
      var ledger = await Navigator.push(context, pageLedger);

      if (ledger == null) {
        Navigator.pop(context);
        return;
      }
      widget.modal.ledger = ledger;
      onPressed();
    });
  }

  void onPressed() async {
    var page = SelectItemPage.page(reference);
    var result = await Navigator.push(context, page);

    widget.modal.setItems(result);
    widget.modal.items.removeWhere((item) {
      if (widget.tax != null || widget.description) {
        return item.g == 0 || item.p == 0;
      }
      return item.p == 0;
      //return false;
    });
    // notify item
    setState(() => debugPrint('${widget.modal}'));
  }

  @override
  Widget build(BuildContext context) {
    var remark = widget.modal.remark;
    var name = widget.modal.ledger.name;
    var address = widget.modal.ledger.address;
    var partyGstin = widget.modal.ledger.partyGstin;
    return Expanded(
      child: ListView(children: [
        CardView('TO', children: [
          Text(name?.toUpperCase() ?? ''),
          Text(partyGstin ?? ''),
          Text(address ?? ''),
        ]),
        if (widget.tax != null)
          Row(children: [
            Expanded(
              child: RadioListTile(
                title: const Text('Center Tax'),
                groupValue: integratedTax,
                value: true,
                onChanged: (bool? value) {
                  integratedTax = true;
                  setState(() => widget.tax!(true));
                },
              ),
            ),
            Expanded(
              child: RadioListTile(
                title: const Text('Local Tax'),
                groupValue: integratedTax,
                value: false,
                onChanged: (bool? value) {
                  integratedTax = false;
                  setState(() => widget.tax!(false));
                },
              ),
            ),
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
        ...widget.modal.items
            .map((item) => ItemView(
                  item,
                  onRemoved: () {
                    setState(() => widget.modal.remove(item));
                  },
                  description: widget.description,
                ))
            .toList(),
        if (widget.tax == null)
          Container(
            padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
            child: TextFormField(
              minLines: 3,
              maxLines: 9,
              onChanged: (value) => widget.modal.remark = value,
              keyboardType: TextInputType.multiline,
              decoration: const InputDecoration(
                fillColor: Colors.white,
                hintText: 'Remark',
                filled: true,
              ),
              controller: TextEditingController(text: remark),
            ),
          ),
        Container(
          alignment: const Alignment(0.9, 0.0),
          child: FloatingActionButton(
            child: const Icon(Icons.add_shopping_cart),
            onPressed: onPressed,
          ),
        ),
      ]),
    );
  }
}
