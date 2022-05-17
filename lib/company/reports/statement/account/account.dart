import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_account.dart';

class AccountView extends StatelessWidget {
  final DocumentReference reference;

  const AccountView(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getStatement(reference),
      filter: (StatementModal modal, String value) {
        var name = modal.name.toLowerCase();
        return name.contains(value);
      },
      builder: (StatementModal modal) => ListTile(
        leading: const Leading(reportStatement),
        onTap: () {
          var page = ViewStatementPage.page(reference, modal);
          Navigator.push(context, page);
        },
        title: ListTitle(modal.name),
      ),
    );
  }
}
