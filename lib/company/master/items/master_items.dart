import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'view/master_item_view.dart';

class MasterItems extends StatelessWidget {
  final DocumentReference reference;

  const MasterItems(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      child: Column(children: [
        const TabBar(
          tabs: [
            Tab(text: 'ALL ITEMS'),
            Tab(text: 'GROUP ITEMS'),
          ],
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
        ),
        Expanded(
          child: TabBarView(
            children: [
              MasterAllItems(reference),
              StreamLoader(
                stream: db.getItems(reference),
                builder: (List<QueryDocumentSnapshot<ItemModal>> docs) {
                  var groups = docs.map((e) => e.data().parent).toSet();
                  return ListView(
                    children: groups.map((parent) {
                      var isShow =
                          docs.firstWhere((e) => e.data().parent == parent);
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: ListTile(
                          onTap: () {
                            var groups = docs
                                .where((e) => e.data().parent == parent)
                                .toList();
                            var page = MasterGroupItems.page(groups);
                            Navigator.push(context, page);
                          },
                          leading: const CircleAvatar(
                            child: Icon(
                              Icons.add_shopping_cart,
                              color: Colors.white,
                            ),
                          ),
                          title: ListTitle('$parent'),
                          trailing: Checkbox(
                            value: isShow.data().isShow,
                            onChanged: (bool? value) {
                              var groups = docs
                                  .where((e) => e.data().parent == parent)
                                  .toList();
                              for (var e in groups) {
                                var modal = e.data();
                                modal.isShow = value!;
                                e.reference.set(modal);
                              }
                            },
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              )
            ],
            physics: const NeverScrollableScrollPhysics(),
          ),
        ),
      ]),
      length: 2,
    );
  }
}

class MasterAllItems extends StatelessWidget {
  final DocumentReference reference;

  const MasterAllItems(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return QueryStreamBuilder(
      stream: db.getItems(reference),
      filter: (ItemModal modal, String value) {
        var name = modal.getName.toLowerCase();
        return name.contains(value);
      },
      builder: (ItemModal modal) => ListTile(
        onTap: () {
          var page = MasterItemView.page(modal);
          Navigator.push(context, page);
        },
        leading: const CircleAvatar(
          child: Icon(
            Icons.add_shopping_cart,
            color: Colors.white,
          ),
        ),
        title: ListTitle(modal.getName),
      ),
    );
  }
}

class MasterGroupItems extends StatelessWidget {
  final List<QueryDocumentSnapshot<ItemModal>> snapshot;

  const MasterGroupItems(this.snapshot, {Key? key}) : super(key: key);

  static Route page(List<QueryDocumentSnapshot<ItemModal>> modal) {
    return MaterialPageRoute(builder: (_) => MasterGroupItems(modal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ITEM MASTERS'),
      body: SearchView(
        snapshot,
        (ItemModal modal, String value) {
          var name = modal.getName.toLowerCase();
          return name.contains(value);
        },
        (ItemModal modal) => ListTile(
          onTap: () {
            var page = MasterItemView.page(modal);
            Navigator.push(context, page);
          },
          leading: const CircleAvatar(
            child: Icon(
              Icons.add_shopping_cart,
              color: Colors.white,
            ),
          ),
          title: ListTitle(modal.getName),
          trailing: Checkbox(
            value: modal.isShow,
            onChanged: (bool? value) {},
          ),
        ),
      ),
    );
  }
}
