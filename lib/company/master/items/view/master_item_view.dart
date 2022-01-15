import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class MasterItemView extends StatelessWidget {
  final QueryDocumentSnapshot<ItemModal> document;

  const MasterItemView(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<ItemModal> document) {
    return MaterialPageRoute(builder: (_) => MasterItemView(document));
  }

  @override
  Widget build(BuildContext context) {
    var modal = document.data();

    var taxes = modal.taxDetails;
    var stock = modal.stockDetails;

    return Scaffold(
      appBar: const Toolbar('Item View'),
      body: ListView(children: [
        Image.asset(product, fit: BoxFit.cover),
        Container(
          padding: const EdgeInsets.all(12),
          child: Text(
            modal.name ?? '',
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.all(12),
          child: RowView(
            title: 'PARENT',
            value: modal.parent,
          ),
        ),

        //Stock Details
        CardView('Stock Detail', children: [
          RowView(title: 'HSN Code', value: stock.hsnCode),
          RowView(title: 'Tax Ability', value: stock.taxAbility),
          RowView(title: 'Applicable From', value: stock.applicableFrom),
        ]),

        //Tax Details
        CardView('Tax Detail', children: [
          for (TaxDetails tax in taxes.take(3)) ...[
            RowView(
              title: tax.title,
              value: tax.gstRate,
            ),
            RowView(
              title: 'Duty Head',
              value: tax.gstRateDutyHead,
            ),
            RowView(
              title: 'Valuation Type',
              value: tax.gstRateValuationType,
            ),
            Container(height: 6),
          ]
        ]),
      ]),
    );
  }
}
