import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

class MasterGroups extends StatelessWidget {
  final DocumentReference reference;

  const MasterGroups(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getGroups(reference),
      filter: (GroupModal modal, String value) {
        var name = modal.name?.toLowerCase() ?? '';
        return name.contains(value.toLowerCase());
      },
      builder: (GroupModal modal) => ListTile(
        leading: const CircleAvatar(
          child: Icon(
            Icons.person,
            color: Colors.white,
          ),
        ),
        title: ListTitle(modal.getName),
        subtitle: Text(modal.parent?.trim() ?? ''),
      ),
    );
  }
}
