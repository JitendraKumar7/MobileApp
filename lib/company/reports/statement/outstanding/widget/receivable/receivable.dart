import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_receivable.dart';

class ReceivableTab extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const ReceivableTab(this.document, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getReceivable(document.reference),
      filter: (Outstanding modal, String value) {
        var name = modal.name.toLowerCase();
        return name.contains(value);
      },
      builder: (Outstanding modal) => ListTile(
        leading: const Leading(reportStatement),
        onTap: () {
          modal.setDocument(document.id, document.data());
          var page = ViewReceivable.page(modal);
          Navigator.push(context, page);
        },
        title: ListTitle(modal.name),
      ),
    );
  }
}
