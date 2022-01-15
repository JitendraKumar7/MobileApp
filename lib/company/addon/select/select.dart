import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

class SelectItemPage extends StatelessWidget {
  final controller = TextEditingController();

  final DocumentReference reference;

  SelectItemPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => SelectItemPage(reference));
  }

  Widget itemView(ItemModal modal) {
    return StatefulBuilder(
        builder: (context, setState) => Card(
              child: ListTile(
                onTap: () => setState(() => modal.isSelected = true),
                selected: modal.isSelected,
                leading: CircleAvatar(
                  child: Icon(
                    modal.isSelected ? Icons.check : Icons.add_shopping_cart,
                    color: Colors.white,
                  ),
                ),
                title: Text(modal.name ?? ''),
              ),
            ));
  }

  @override
  Widget build(BuildContext context) {
    List<ItemModal> _list = [];
    return Scaffold(
      appBar: const Toolbar('ITEMS'),
      body: Column(children: [
        Expanded(
          child: SearchStreamBuilder(
            stream: db.getItems(reference),
            builder: (List<QueryDocumentSnapshot<ItemModal>> snapshot) {
              var items = snapshot.map((e) => e.data()).toList();
              _list.addAll(items);
              return StatefulBuilder(builder: (_, StateSetter setState) {
                controller.addListener(() => setState(() {
                      String value = controller.text;
                      _list.clear();

                      if (value.isEmpty) {
                        _list.addAll(items);
                      }
                      // Search Data
                      else {
                        for (var modal in items) {
                          var name = modal.name!.toLowerCase();
                          if (name.contains(value.toLowerCase())) {
                            _list.add(modal);
                          }
                        }
                      }
                    }));
                return Column(
                  children: _list.map<Widget>(itemView).toList(),
                );
              });
            },
            controller: controller,
          ),
        ),
        ElevatedButton(
          onPressed: () async {
            var list = _list.where((e) => e.isSelected).toList();
            Navigator.pop(context, list);
          },
          //style: ElevatedButton.styleFrom(minimumSize: const Size(240, 55)),
          child: const Text('VIEW ORDER'),
        ),
      ]),
    );
  }
}

class SelectLedgerPage extends StatelessWidget {
  SelectLedgerPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => SelectLedgerPage(reference));
  }

  final DocumentReference reference;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<LedgerModal>> _list = [];
    return Scaffold(
      appBar: const Toolbar('LEDGERS'),
      body: SearchStreamBuilder(
        stream: db.getLedger(reference),
        builder: (List<QueryDocumentSnapshot<LedgerModal>> snapshot) {
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
                      var name = modal.name!.toLowerCase();
                      if (name.contains(value.toLowerCase())) {
                        _list.add(document);
                      }
                    }
                  }
                }));
            return Column(
              children: snapshot.map<Widget>((document) {
                var modal = document.data();
                return Card(
                  child: ListTile(
                    onTap: () => Navigator.pop(context, modal),
                    leading: const CircleAvatar(
                      child: Icon(
                        Icons.person,
                        color: Colors.white,
                      ),
                    ),
                    title: Text(modal.name ?? ''),
                    subtitle: Text(modal.address ?? ''),
                  ),
                );
              }).toList(),
            );
          });
        },
        controller: controller,
      ),
    );
  }
}
