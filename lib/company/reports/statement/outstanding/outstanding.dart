import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';

import 'widget/widget.dart';

class OutstandingView extends StatelessWidget {
  final DocumentReference reference;

  const OutstandingView(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Column(children: [
        const TabBar(
          tabs: [
            Tab(text: 'PAYABLE'),
            Tab(text: 'RECEIVABLE'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
        ),
        Expanded(
          child: TabBarView(
            children: [
              PayableTab(reference),
              ReceivableTab(reference),
            ],
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ]),
      length: 2,
    );
  }
}
