import 'dart:collection';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_price_list.dart';

class PriceList extends StatefulWidget {
  final DocumentReference reference;

  const PriceList(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => PriceList(reference));
  }

  @override
  State<PriceList> createState() => _PriceListState();
}

class _PriceListState extends State<PriceList> {
  Map<String, bool> checked = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('PRICE LIST'),
      body: StreamLoader(
        stream: db.getItems(widget.reference),
        builder: (List<QueryDocumentSnapshot<ItemModal>> docs) {
          final groups = SplayTreeSet.from(docs.map((e) => e.data().parent));
          return groups.isEmpty
              ? const EmptyView()
              : Column(children: [
                  Expanded(
                    child: ListView(
                      children: groups.map((parent) {
                        checked['$parent'] = true;
                        return Card(
                          clipBehavior: Clip.hardEdge,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(6),
                          ),
                          child: ListTile(
                            onTap: () {
                              //TODO Price List
                            },
                            leading: const CircleAvatar(
                              child: Icon(
                                Icons.add_shopping_cart,
                                color: Colors.white,
                              ),
                            ),
                            title: ListTitle('$parent'),
                            trailing: Checkbox(
                              value: checked['$parent'] ?? false,
                              onChanged: (bool? value) {
                                setState(() => checked['$parent'] = value!);
                              },
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        minimumSize: const Size(180, 45)),
                    onPressed: () {
                      List<PriceListModal> items = [];
                      checked.forEach((key, value) {
                        if (value) {
                          var groups = docs
                              .where((e) => e.data().parent == key)
                              .toList();

                          var list = groups.map((e) => e.data().value).toList();
                          var itemModal = PriceListModal(list, key);
                          items.add(itemModal);
                        }
                      });
                      var page = ViewPriceList.page(widget.reference, items);
                      Navigator.push(context, page);
                    },
                    child: const Text('Continue'),
                  ),
                ]);
        },
      ),
    );
  }
}
