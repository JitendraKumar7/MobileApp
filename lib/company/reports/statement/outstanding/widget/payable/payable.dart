import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_payable.dart';

class PayableTab extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const PayableTab(this.document, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getPayable(document.reference),
      filter: (Outstanding modal, String value) {
        var name = modal.name.toLowerCase();
        return name.contains(value.toLowerCase());
      },
      builder: (Outstanding modal) => ListTile(
        leading: const Leading(reportStatement),
        onTap: () {
          modal.setDocument(document.id, document.data());
          var page = ViewPayable.page(modal);
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
