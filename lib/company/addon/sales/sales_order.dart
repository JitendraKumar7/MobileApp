import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../reports/statement/view/view_account.dart';
import 'add/add_sales.dart';
import 'view/view_sales.dart';

class SalesPage extends StatefulWidget {
  final DocumentReference reference;

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => SalesPage(reference));
  }

  const SalesPage(this.reference, {Key? key}) : super(key: key);

  @override
  State<SalesPage> createState() => _SalesPageState();
}

class _SalesPageState extends State<SalesPage> {
  late Stream<QuerySnapshot<OrderModal>> stream;

  @override
  void initState() {
    super.initState();
    stream = db
        .salesOrder(widget.reference)
        .orderBy('TIMESTAMP', descending: true)
        .snapshots();
  }

  void _sortSalesOrders() async {
    var result = await showMenu(
        context: context,
        elevation: 8.0,
        position: const RelativeRect.fromLTRB(100, 109, 9, 0),
        items: const [
          PopupMenuItem(
            value: 'ALL',
            child: Text('ALL'),
          ),
          PopupMenuItem(
            value: 'RECEIVED',
            child: Text('NEW'),
          ),
          PopupMenuItem(
            value: 'HOLD',
            child: Text('HOLD'),
          ),
          PopupMenuItem(
            value: 'CANCEL',
            child: Text('CANCELLED'),
          ),
          PopupMenuItem(
            value: 'CONFIRMED',
            child: Text('CONFIRMED'),
          ),
          PopupMenuItem(
            value: 'DISPATCHED',
            child: Text('DISPATCHED'),
          ),
        ]);
    if (result != null) {
      stream = result == 'ALL'
          ? db
              .salesOrder(widget.reference)
              .orderBy('TIMESTAMP', descending: true)
              .snapshots()
          : db
              .salesOrder(widget.reference)
              .where('STATUS', isEqualTo: result)
              .snapshots();
      setState(() => debugPrint('_sortSalesOrders $result'));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: QueryStreamBuilder(
        stream: stream,
        filter: (OrderModal modal, String value) {
          var name = modal.name.toLowerCase();
          return name.contains(value);
        },
        builder: (OrderModal modal) => ListTile(
          onTap: () {
            var route = ViewSalesOrder.page(widget.reference, modal);
            Navigator.push(context, route);
          },
          title: ListTitle(modal.name),
          subtitle: Column(children: [
            const SizedBox(height: 9),
            ListSubTitle(modal.id, modal.date),
            InkWell(
              onTap: () {
                var page = SalesStatementPage.page(
                  widget.reference,
                  modal.ledger.name,
                );
                Navigator.push(context, page);
              },
              child: const Padding(
                padding: EdgeInsets.all(6),
                child: Text(
                  'Account Statement',
                  style: TextStyle(fontSize: 11),
                ),
              ),
            ),
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
        ),
      ),
      appBar: Toolbar('SALES ORDER', actions: [
        IconButton(
          onPressed: _sortSalesOrders,
          icon: const Icon(Icons.sort),
        )
      ]),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          var route = AddSalesOrderPage.page(widget.reference);
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
        shape: shape,
        clipBehavior: Clip.hardEdge,
        child: StatefulBuilder(builder: (context, setState) {
          return Column(mainAxisSize: MainAxisSize.min, children: [
            Container(
              height: 55,
              color: Colors.blueGrey,
              alignment: Alignment.center,
              child: const Text(
                'ORDER STATUS',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.white,
                ),
              ),
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
                      .salesOrder(widget.reference)
                      .doc(modal.document)
                      .update(modal.doc);

                  Navigator.pop(context);
                },
                child: const Text('UPDATE STATUS'),
              ),
            ]),
          ]);
        }),
      ),
    );
  }
}

class SalesStatementPage extends StatelessWidget {
  final DocumentReference reference;
  final String? name;

  static Route page(DocumentReference reference, String? name) {
    return MaterialPageRoute(
        builder: (_) => SalesStatementPage(reference, name));
  }

  const SalesStatementPage(this.reference, this.name, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ACCOUNT STATEMENT'),
      body: StreamBuilder(
        stream: db.getStatementByQuery(reference, name),
        builder: (_, AsyncSnapshot<QuerySnapshot<StatementModal>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.docs ?? [];
            return data.isEmpty
                ? const EmptyView()
                : ViewStatementPage(reference, data.first.data());
          }
          return const LoaderPage();
        },
      ),
    );
  }
}
