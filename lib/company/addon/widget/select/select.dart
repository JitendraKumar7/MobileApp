import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

class SelectItemPage extends StatelessWidget {
  final DocumentReference reference;
  final List<ItemModal> _list = [];

  SelectItemPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => SelectItemPage(reference));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('SELECT ITEMS'),
      body: Column(children: [
        Expanded(
          child: QueryStreamBuilder(
            stream: db.getItems(reference),
            filter: (ItemModal modal, String value) {
              var name = modal.name?.toLowerCase() ?? '';
              return name.contains(value);
            },
            builder: (ItemModal modal) => StatefulBuilder(
              builder: (_, setState) => ListTile(
                onTap: () => setState(() {
                  modal.changeSelection();
                  if (modal.isSelected) {
                    _list.add(modal);
                  }
                  // Remove Items
                  else {
                    _list.remove(modal);
                  }
                }),
                selectedTileColor: Colors.orange,
                selectedColor: Colors.white,
                selected: modal.isSelected,
                leading: modal.isSelected
                    ? const CircleAvatar(
                        child: Icon(
                          Icons.check,
                          color: Colors.orange,
                        ),
                        backgroundColor: Colors.white,
                      )
                    : const Leading(masterItem),
                title: ListTitle(modal.getName),
              ),
            ),
          ),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(minimumSize: const Size(180, 45)),
          onPressed: () => Navigator.pop(context, _list),
          child: const Text('VIEW CART'),
        ),
      ]),
    );
  }
}

class SelectLedgerPage extends StatelessWidget {
  final DocumentReference reference;

  const SelectLedgerPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => SelectLedgerPage(reference));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getLedger(reference),
        filter: (LedgerModal modal, String value) {
          var name = modal.getName.toLowerCase();
          return name.contains(value);
        },
        builder: (LedgerModal modal) => ListTile(
          onTap: () => Navigator.pop(context, modal),
          title: ListTitle(modal.getName),
          leading: const Leading(masterLedger),
          subtitle: ListSubTitle(modal.getAddress, ''),
        ),
      ),
      appBar: const Toolbar('SELECT LEDGER'),
    );
  }
}
