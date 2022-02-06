import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';

import 'widget/widget.dart';

class OutstandingView extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const OutstandingView(this.document, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Column(children: [
        const TabBar(
          tabs: [
            Tab(text: 'RECEIVABLE'),
            Tab(text: 'PAYABLE'),
          ],
          labelColor: Colors.blue,
        ),
        Expanded(
          child: TabBarView(
            children: [
              PayableTab(document),
              ReceivableTab(document),
            ],
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ]),
      length: 2,
    );
  }
}
