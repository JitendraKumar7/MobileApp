import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/services/services.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../reports/reports_view.dart';

class LedgerViewPage extends StatelessWidget {
  final DocumentReference reference;
  final LedgerModal modal;

  const LedgerViewPage(this.reference, this.modal, {Key? key})
      : super(key: key);

  static Route page(
    DocumentReference reference,
    LedgerModal modal,
  ) {
    return MaterialPageRoute(builder: (_) => LedgerViewPage(reference, modal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Toolbar('ACCOUNT MASTER'),
      body: ListView(padding: const EdgeInsets.all(12), children: <Widget>[
        ProfileWidget(
          capture: (bytes) {},
          id: '',
        ),
        Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Text(
            modal.getName,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //Address
        CardView('address', children: [
          RowView(title: 'Address', value: modal.address),
          RowView(title: 'State', value: modal.ledStateName),
          RowView(title: 'Country', value: modal.countryName),
          RowView(title: 'PIN Code', value: modal.pinCode),
        ]),

        //Registration
        CardView('registration', children: [
          RowView(title: 'Parent', value: modal.parent),
          RowView(
            title: 'GSTIN',
            value: modal.partyGstin,
            button: ElevatedButton(
              child: const Text('Verify'),
              onPressed: () {},
            ),
          ),
          RowView(title: 'State', value: modal.priorStateName),
          RowView(title: 'PAN No.', value: modal.incomeTexNumber),
          RowView(
            title: 'GSTIN Type',
            value: modal.gstRegistrationType,
          ),
        ]),

        //Contact
        CardView('Contact', children: [
          RowView(
            title: 'Email Id',
            value: modal.email ?? '',
            button: IconButton(
              icon: const Icon(Icons.mail),
              onPressed: () async {
                var url = Uri.tryParse('mailto:${modal.email}');
                debugPrint('Email Id url ==> $url');
                if (url != null) {
                  launchUrl(url);
                }
              },
            ),
          ),
          RowView(
            title: 'Phone No.',
            value: modal.ledgerMobile ?? '',
            button: IconButton(
              icon: const Icon(Icons.call),
              onPressed: () async {
                var url = Uri.tryParse('tel:${modal.ledgerMobile}');
                debugPrint('Phone No. url ==> $url');
                if (url != null) {
                  launchUrl(url);
                }
              },
            ),
          ),
        ]),
        //Account Balance
        CardView('Account Balance', children: [
          RowView(
            title: 'Opening Bal.',
            value: '₹${modal.openingBal}',
          ),
          RowView(
            title: 'Closing Bal.',
            value: '₹${modal.closingBal}',
          ),
        ]),

        //Account Info
        CardView('Banking Info', children: [
          RowView(title: 'Bank Name', value: modal.bankName),
          RowView(title: 'IFSC Code', value: modal.ifscCode),
          RowView(title: 'Acc. Number', value: modal.accountNumber),
        ]),

        //Account Reports
        CardView('Transaction', children: [
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            ElevatedButton(
              onPressed: () {
                var page = LedgerSalesPage.page(reference, modal.name);
                Navigator.push(context, page);
              },
              child: const Text('SALES INVOICE'),
            ),
            ElevatedButton(
              onPressed: () {
                var page = LedgerPurchasePage.page(reference, modal.name);
                Navigator.push(context, page);
              },
              child: const Text('PURCHASE INVOICE'),
            ),
          ]),
        ]),
      ]),
    );
  }
}

class LedgerSalesPage extends SalesPage {
  final String? partyName;

  const LedgerSalesPage(reference, this.partyName, {Key? key})
      : super(reference, key: key);

  static Route page(DocumentReference reference, String? partyName) {
    return MaterialPageRoute(
      builder: (_) => LedgerSalesPage(reference, partyName),
    );
  }

  @override
  bool get showAllReports => true;

  @override
  void onClick(
    List<QueryDocumentSnapshot<MonthModal>> docs,
    BuildContext context,
    String month,
  ) {
    if (docs.any((e) => e.id == month)) {
      var doc = docs.firstWhere((e) => e.id == month);
      var page = LedgerSalesListPage.page(doc, (InvoiceModal modal) {
        var page = ViewSalesPage.page(modal.setLedger(reference));
        Navigator.push(context, page);
      }, partyName);
      Navigator.push(context, page);
    }
    // No Records
    else {
      showAlertDialog(context);
    }
  }
}

class LedgerPurchasePage extends PurchasePage {
  final String? partyName;

  const LedgerPurchasePage(reference, this.partyName, {Key? key})
      : super(reference, key: key);

  static Route page(DocumentReference reference, String? partyName) {
    return MaterialPageRoute(
      builder: (_) => LedgerPurchasePage(reference, partyName),
    );
  }

  @override
  bool get showAllReports => true;

  @override
  void onClick(
    List<QueryDocumentSnapshot<MonthModal>> docs,
    BuildContext context,
    String month,
  ) {
    if (docs.any((e) => e.id == month)) {
      var doc = docs.firstWhere((e) => e.id == month);
      var page = LedgerPurchaseListPage.page(doc, (InvoiceModal modal) {
        var page = ViewPurchasePage.page(modal.setLedger(reference));
        Navigator.push(context, page);
      }, partyName);
      Navigator.push(context, page);
    }
    // No Records
    else {
      showAlertDialog(context);
    }
  }
}

class LedgerSalesListPage extends StatelessWidget {
  final QueryDocumentSnapshot<MonthModal> document;
  final TapCallback<InvoiceModal> callback;
  final String? partyName;

  const LedgerSalesListPage(this.document, this.callback, this.partyName,
      {Key? key})
      : super(key: key);

  static Route page(
    QueryDocumentSnapshot<MonthModal> document,
    TapCallback<InvoiceModal> callback,
    String? partyName,
  ) {
    return MaterialPageRoute(
      builder: (_) => LedgerSalesListPage(document, callback, partyName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('SALES INVOICE'),
      body: StreamBuilder(
        stream: db.getInvoiceByQuery(document.reference, partyName),
        builder: (_, AsyncSnapshot<QuerySnapshot<InvoiceModal>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.docs ?? [];
            if (data.isEmpty) return const EmptyView();
            data.sort((a, b) => b.data().date.compareTo(a.data().date));
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: data.map((e) {
                var modal = e.data();
                return Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListTile(
                    subtitle: ListSubTitle(modal.id, modal.date),
                    title: ListTitle(modal.partyName),
                    leading: const Leading(report),
                    onTap: () => callback(modal),
                  ),
                );
              }).toList(),
            );
          }
          return const EmptyView();
        },
      ),
    );
  }
}

class LedgerPurchaseListPage extends StatelessWidget {
  final QueryDocumentSnapshot<MonthModal> document;
  final TapCallback<InvoiceModal> callback;
  final String? partyName;

  const LedgerPurchaseListPage(this.document, this.callback, this.partyName,
      {Key? key})
      : super(key: key);

  static Route page(
    QueryDocumentSnapshot<MonthModal> document,
    TapCallback<InvoiceModal> callback,
    String? partyName,
  ) {
    return MaterialPageRoute(
      builder: (_) => LedgerPurchaseListPage(document, callback, partyName),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('PURCHASE INVOICE'),
      body: StreamBuilder(
        stream: db.getInvoiceByQuery(document.reference, partyName),
        builder: (_, AsyncSnapshot<QuerySnapshot<InvoiceModal>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data?.docs ?? [];
            if (data.isEmpty) return const EmptyView();
            data.sort((a, b) => b.data().date.compareTo(a.data().date));
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: data.map((e) {
                var modal = e.data();
                return Card(
                  clipBehavior: Clip.hardEdge,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ListTile(
                    subtitle: ListSubTitle(modal.id, modal.date),
                    title: ListTitle(modal.partyName),
                    leading: const Leading(report),
                    onTap: () => callback(modal),
                  ),
                );
              }).toList(),
            );
          }
          return const EmptyView();
        },
      ),
    );
  }
}
