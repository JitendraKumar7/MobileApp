import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/master_ledger_view.dart';

class MasterLedger extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const MasterLedger(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => MasterLedger(document));
  }

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getLedger(document.reference),
      filter: (LedgerModal modal, String value) {
        var name = modal.getName.toLowerCase();
        return name.contains(value);
      },
      builder: (LedgerModal modal) =>
          ListTile(
            onTap: () {
              var page = LedgerViewPage.page(document, modal);
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
