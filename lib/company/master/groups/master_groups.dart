import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

class MasterGroups extends StatelessWidget {
  MasterGroups(this.reference, {Key? key}) : super(key: key);

  final DocumentReference reference;
  final controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    List<QueryDocumentSnapshot<GroupModal>> _list = [];
    return SearchStreamBuilder(
      stream: db.getGroups(reference),
      builder: (List<QueryDocumentSnapshot<GroupModal>> snapshot) {
        _list = snapshot;
        return StatefulBuilder(builder: (_, StateSetter setState) {
          controller.addListener(() => setState(() {
            String value = controller.text;
            if (value.isEmpty) {
              _list = snapshot;
            }
            // Search Data
            else {
              _list = [];
              for (var document in snapshot) {
                var modal = document.data();
                var name = modal.name!.toLowerCase();
                if (name.contains(value.toLowerCase())) {
                  _list.add(document);
                }
              }
            }
          }));
          return Column(
            children: _list.map<Widget>((document) {
              var modal = document.data();
              return Card(
                child: ListTile(
                  leading: const CircleAvatar(
                    child: Icon(
                      Icons.person,
                      color: Colors.white,
                    ),
                  ),
                  title: Text(modal.name ?? ''),
                  subtitle: Text(modal.parent ?? ''),
                ),
              );
            }).toList(),
          );
        });
      },
      controller: controller,
    );
  }
}