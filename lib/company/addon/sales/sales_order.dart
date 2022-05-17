import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import 'add/add_sales.dart';
import 'view/view_sales.dart';

class SalesPage extends StatelessWidget {
  final DocumentReference reference;

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => SalesPage(reference));
  }

  const SalesPage(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: db
            .salesOrder(reference)
            .orderBy('TIMESTAMP', descending: true)
            .snapshots(),
        filter: (OrderModal modal, String value) {
          var name = modal.name.toLowerCase();
          return name.contains(value);
        },
        builder: (OrderModal modal) => ListTile(
          onTap: () {
            var route = ViewSalesOrder.page(reference, modal);
            Navigator.push(context, route);
          },
          title: ListTitle(modal.name),
          subtitle: Column(children: [
            ListSubTitle(modal.id, modal.date),
            if (modal.message?.isNotEmpty ?? false)
              Text(
                modal.message ?? '',
                style: const TextStyle(
                  fontSize: 12,
                  color: Colors.red,
                ),
              ),
          ]),
          trailing: IconButton(
            onPressed: modal.isCancel || modal.isDispatched
                ? null
                : () => showDialogBox(context, modal),
            icon: Icon(
              Icons.reorder,
              color: modal.color,
            ),
          ),
          leading: const Leading(addonSalesOrder),
          //subtitle: Text(modal.date),
        ),
      ),
      appBar: const Toolbar('SALES ORDER'),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var route = AddSalesOrderPage.page(reference);
          Navigator.push(context, route);
        },
      ),
    );
  }

  showDialogBox(BuildContext context, OrderModal modal) {
    var shape = RoundedRectangleBorder(borderRadius: BorderRadius.circular(12));
    return showDialog(
      context: context,
      builder: (context) => Dialog(
        child: StatefulBuilder(builder: (context, setState) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              child: const Text(
                'ORDER STATUS',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
              alignment: Alignment.center,
              color: Colors.blueGrey,
              height: 55,
            ),
            RadioListTile(
              value: hold,
              groupValue: modal.status,
              onChanged: (value) => setState(() {
                modal.status = hold;
              }),
              selected: modal.isHold,
              title: const Text(hold),
              activeColor: Colors.white,
              selectedTileColor: Colors.yellow,
            ),
            RadioListTile(
              value: cancel,
              groupValue: modal.status,
              onChanged: (value) => setState(() {
                modal.status = cancel;
              }),
              selected: modal.isCancel,
              activeColor: Colors.white,
              title: const Text(cancel),
              selectedTileColor: Colors.red,
            ),
            RadioListTile(
              value: confirmed,
              groupValue: modal.status,
              onChanged: (value) => setState(() {
                modal.status = confirmed;
              }),
              activeColor: Colors.white,
              selected: modal.isConfirmed,
              title: const Text(confirmed),
              selectedTileColor: Colors.green,
            ),
            RadioListTile(
              value: dispatched,
              groupValue: modal.status,
              onChanged: (value) => setState(() {
                modal.status = dispatched;
              }),
              activeColor: Colors.white,
              selected: modal.isDispatched,
              title: const Text(dispatched),
              selectedTileColor: Colors.brown,
            ),
            Container(
              padding: const EdgeInsets.fromLTRB(6, 12, 6, 12),
              child: TextFormField(
                minLines: 2,
                maxLines: 3,
                onChanged: (value) => modal.message = value,
                keyboardType: TextInputType.multiline,
                decoration: const InputDecoration(
                  fillColor: Colors.white,
                  hintText: 'message',
                  filled: true,
                ),
                controller: TextEditingController(text: modal.message),
              ),
            ),
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('CANCEL'),
              ),
              TextButton(
                onPressed: () {
                  db
                      .salesOrder(reference)
                      .doc(modal.document)
                      .update(modal.doc);

                  Navigator.pop(context);
                },
                child: const Text('UPDATE STATUS'),
              ),
            ]),
          ]);
        }),
        clipBehavior: Clip.hardEdge,
        shape: shape,
      ),
    );
  }
}
