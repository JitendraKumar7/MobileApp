import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/widget/widget.dart';

import 'widget/widget.dart';

class OutstandingPage extends StatelessWidget {
  final DocumentReference reference;

  const OutstandingPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => OutstandingPage(reference));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
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
            child: TabBarView(children: [
              PayableTab(reference),
              ReceivableTab(reference),
            ]),
          ),
        ]),
      ),
      appBar: const Toolbar('OUTSTANDING'),
    );
  }
}
