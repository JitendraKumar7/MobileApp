import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/view_payable.dart';

class PayableTab extends StatelessWidget {
  final DocumentReference reference;

  const PayableTab(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getPayable(reference),
      filter: (Outstanding modal, String value) {
        var name = modal.name.toLowerCase();
        return name.contains(value);
      },
      builder: (Outstanding modal) => ListTile(
        leading: const Leading(reportStatement),
        onTap: () {
          var page = ViewPayable.page(reference, modal);
          Navigator.push(context, page);
        },
        title: ListTitle(modal.name),
      ),
    );
  }
}
