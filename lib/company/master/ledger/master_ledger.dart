import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/master_ledger_view.dart';

class MasterLedger extends StatelessWidget {
  final DocumentReference reference;

  const MasterLedger(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getLedger(reference),
      filter: (LedgerModal modal, String value) {
        var name = modal.getName.toLowerCase();
        return name.contains(value);
      },
      builder: (LedgerModal modal) => ListTile(
        onTap: () {
          var page = LedgerViewPage.page(modal);
          Navigator.push(context, page);
        },
        leading: const CircleAvatar(
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: ListTitle(modal.getName),
        subtitle: ListSubTitle(modal.getAddress, ''),
      ),
    );
  }
}
