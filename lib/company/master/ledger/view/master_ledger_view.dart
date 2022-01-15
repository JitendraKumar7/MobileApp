import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class LedgerViewPage extends StatelessWidget {
  final QueryDocumentSnapshot<LedgerModal> document;

  const LedgerViewPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<LedgerModal> document) {
    return MaterialPageRoute(builder: (_) => LedgerViewPage(document));
  }

  @override
  Widget build(BuildContext context) {
    var modal = document.data();
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Toolbar('LEDGER VIEW'),
      body: ListView(padding: const EdgeInsets.all(12), children: <Widget>[
        const ProfileWidget(),
        Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: Text(
            '${modal.name}',
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
          RowView(title: 'GSTIN', value: modal.partyGstin),
          RowView(title: 'Prior State', value: modal.priorStateName),
          RowView(title: 'IT Number', value: modal.incomeTexNumber),
          RowView(
            title: 'GSTIN Type',
            value: modal.gstRegistrationType,
          ),
        ]),

        //Account Balance
        CardView('Account Balance', children: [
          RowView(
            title: 'Opening Bal.',
            value: '₹${modal.openingBalance ?? '0.00'}',
          ),
          RowView(
            title: 'Closing Bal.',
            value: '₹${modal.closingBalance ?? '0.00'}',
          ),
        ]),
        //Account Info
        CardView('Account Info', children: [
          RowView(title: 'Mailing Name', value: modal.mailingName),
          RowView(title: 'Bank Name', value: modal.bankName),
          RowView(title: 'IFSC Code', value: modal.ifscCode),
          RowView(title: 'Account Number', value: modal.accountNumber),
        ])
      ]),
    );
  }
}
