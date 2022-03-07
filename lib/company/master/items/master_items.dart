import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/master_item_view.dart';

class MasterItems extends StatelessWidget {
  final DocumentReference reference;

  const MasterItems(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getItems(reference),
      filter: (ItemModal modal, String value) {
        var name = modal.getName.toLowerCase();
        return name.contains(value);
      },
      builder: (ItemModal modal) => ListTile(
        onTap: () {
          var page = MasterItemView.page(modal);
          Navigator.push(context, page);
        },
        leading: const CircleAvatar(
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
        ),
        title: ListTitle(modal.getName),
      ),
    );
  }
}
