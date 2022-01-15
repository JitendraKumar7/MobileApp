import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

import 'view/master_item_view.dart';

class MasterItems extends StatelessWidget {
  final controller = TextEditingController();

  final DocumentReference reference;

  MasterItems(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<ItemModal>> _list = [];
    return SearchStreamBuilder(
      stream: db.getItems(reference),
      builder: (List<QueryDocumentSnapshot<ItemModal>> snapshot) {
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
                  onTap: () {
                    var page = MasterItemView.page(document);
                    Navigator.push(context, page);
                  },
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.add_shopping_cart,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(modal.name ?? ''),
                ),
              );
            }).toList(),
          );
        });
      },
      controller: controller,
    );
  }
}
