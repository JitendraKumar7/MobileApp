import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class LedgerViewPage extends StatelessWidget {
  final LedgerModal modal;

  const LedgerViewPage(this.modal, {Key? key}) : super(key: key);

  static Route page(LedgerModal modal) {
    return MaterialPageRoute(builder: (_) => LedgerViewPage(modal));
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
          RowView(title: 'GSTIN', value: modal.partyGstin),
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
            value: '₹${modal.openingBalance ?? '0.00'}',
          ),
          RowView(
            title: 'Closing Bal.',
            value: '₹${modal.closingBalance ?? '0.00'}',
          ),
        ]),
        //Account Info
        CardView('Banking Info', children: [
          RowView(title: 'Bank Name', value: modal.bankName),
          RowView(title: 'IFSC Code', value: modal.ifscCode),
          RowView(title: 'Acc. Number', value: modal.accountNumber),
        ])
      ]),
    );
  }
}
