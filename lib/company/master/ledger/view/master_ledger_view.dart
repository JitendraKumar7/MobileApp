import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/services/services.dart';

import '../../../reports/reports_view.dart';

class LedgerViewPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;
  final LedgerModal modal;

  const LedgerViewPage(this.document, this.modal, {Key? key}) : super(key: key);

  static Route page(
    QueryDocumentSnapshot<CompanyModal> document,
    LedgerModal modal,
  ) {
    return MaterialPageRoute(builder: (_) => LedgerViewPage(document, modal));
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
          //RowView(title: 'GSTIN', value: modal.partyGstin),
          Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
            SizedBox(
              width: MediaQuery.of(context).size.width / 3.5,
              child: const Text(
                'GSTIN',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            Expanded(child: Text(modal.partyGstin ?? '')),
            ElevatedButton(
              onPressed: () {},
              child: const Text('Verify'),
            ),
          ]),
          RowView(title: 'State', value: modal.priorStateName),
          RowView(title: 'PAN No.', value: modal.incomeTexNumber),
          RowView(
            title: 'GSTIN Type',
            value: modal.gstRegistrationType,
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
                var page = LedgerSalesPage.page(document, modal.name);
                Navigator.push(context, page);
              },
              child: const Text('SALES INVOICE'),
            ),
            ElevatedButton(
              onPressed: () {
                var page = LedgerPurchasePage.page(document, modal.name);
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

class LedgerSalesPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;
  final String? partyName;

  const LedgerSalesPage(this.document, this.partyName, {Key? key})
      : super(key: key);

  static Route page(
    QueryDocumentSnapshot<CompanyModal> document,
    String? partyName,
  ) {
    return MaterialPageRoute(
      builder: (_) => LedgerSalesPage(document, partyName),
    );
  }

  Widget getByMonth(QueryDocumentSnapshot<MonthModal> document) {
    return StreamBuilder(
      stream: db.getInvoiceByQuery(document.reference, partyName),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<InvoiceModal>> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.docs ?? [];
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
                  onTap: () {
                    var page =
                        ViewSalesPage.page(modal.setLedger(this.document));
                    Navigator.push(context, page);
                  },
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('SALES INVOICE'),
      body: StreamLoader(
        stream: db.getSales(document.reference),
        builder: (List<QueryDocumentSnapshot<MonthModal>> docs) {
          return ListView(children: docs.map(getByMonth).toList());
        },
      ),
    );
  }
}

class LedgerPurchasePage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;
  final String? partyName;

  const LedgerPurchasePage(this.document, this.partyName, {Key? key})
      : super(key: key);

  static Route page(
    QueryDocumentSnapshot<CompanyModal> document,
    String? partyName,
  ) {
    return MaterialPageRoute(
      builder: (_) => LedgerPurchasePage(document, partyName),
    );
  }

  Widget getByMonth(QueryDocumentSnapshot<MonthModal> document) {
    return StreamBuilder(
      stream: db.getInvoiceByQuery(document.reference, partyName),
      builder: (BuildContext context,
          AsyncSnapshot<QuerySnapshot<InvoiceModal>> snapshot) {
        if (snapshot.hasData) {
          var data = snapshot.data?.docs ?? [];
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
                  onTap: () {
                    var page =
                        ViewPurchasePage.page(modal.setLedger(this.document));
                    Navigator.push(context, page);
                  },
                ),
              );
            }).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('PURCHASE INVOICE'),
      body: StreamLoader(
        stream: db.getPurchase(document.reference),
        builder: (List<QueryDocumentSnapshot<MonthModal>> docs) {
          return ListView(children: docs.map(getByMonth).toList());
        },
      ),
    );
  }
}
