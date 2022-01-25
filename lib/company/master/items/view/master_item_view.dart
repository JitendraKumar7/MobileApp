import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class MasterItemView extends StatelessWidget {
  final ItemModal modal;

  const MasterItemView(this.modal, {Key? key}) : super(key: key);

  static Route page(ItemModal modal) {
    return MaterialPageRoute(builder: (_) => MasterItemView(modal));
  }

  @override
  Widget build(BuildContext context) {
    var stock = modal.stockDetails;
    var taxes = modal.taxDetails;
    debugPrint(modal.toString());

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

        Container(
          padding: const EdgeInsets.all(12),
          child: RowView(
            title: 'RATE',
            value: modal.rate,
          ),
        ),

        //Stock Details
        CardView('Stock Detail', children: [
          RowView(title: 'HSN Code', value: stock.hsnCode),
          RowView(title: 'Tax Ability', value: stock.taxAbility),
          RowView(title: 'From', value: stock.applicableFrom),
        ]),

        //Tax Details
        CardView('Tax Detail', children: [
          for (TaxDetails tax in taxes.take(3)) ...[
            RowView(
              title: tax.title,
              value: '${tax.gstRate}%',
            ),
            RowView(
              title: 'Duty Head',
              value: tax.gstRateDutyHead,
            ),
            const Divider(),
          ]
        ]),
      ]),
    );
  }
}
