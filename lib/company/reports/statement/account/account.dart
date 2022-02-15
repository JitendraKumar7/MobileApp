import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_account.dart';

class AccountView extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const AccountView(this.document, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getStatement(document.reference),
      filter: (StatementModal modal, String value) {
        var name = modal.name.toLowerCase();
        return name.contains(value.toLowerCase());
      },
      builder: (StatementModal modal) => ListTile(
        leading: const Leading(reportStatement),
        onTap: () {
          modal.setDocument(document.id, document.data());
          var page = ViewStatementPage.page(modal);
          Navigator.push(context, page);
        },
        title: Text(
          modal.name,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: const TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
