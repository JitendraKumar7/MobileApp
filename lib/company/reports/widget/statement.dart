import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

class StatementPage extends StatelessWidget {
  final DocumentReference reference;

  const StatementPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => StatementPage(reference));
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db.getStatement(reference),
        filter: (StatementModal modal, String value) {
          var name = modal.name?.toLowerCase() ?? '';
          return name.contains(value.toLowerCase());
        },
        builder: (StatementModal modal) => Card(
          child: ListTile(
            leading: const CircleAvatar(
              child: Icon(
                Icons.person,
                color: Colors.white,
              ),
            ),
            title: Text(modal.name ?? ''),
          ),
        ),
      ),
      appBar: const Toolbar('ACC STATEMENT'),
    );
  }
}
