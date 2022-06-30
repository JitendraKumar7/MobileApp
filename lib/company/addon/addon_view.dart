import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/widget/widget.dart';

import 'business/business.dart';
import 'price/price_list.dart';
import 'proforma/proforma.dart';
import 'purchase/purchase_order.dart';
import 'quotation/quotation.dart';
import 'sales/sales_order.dart';

class AddonView extends StatelessWidget {
  const AddonView(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => AddonView(reference));
  }

  final DocumentReference reference;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('BUSINESS ADDONS'),
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(18),
          child: ListTitle(reference.parent.id.split('-').first),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: addonCard,
              label: 'Business Card',
              onTap: () {
                var page = ShareCardPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: report,
              label: 'Price List',
              onTap: () {
                var page = PriceList.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: addonSalesOrder,
              label: 'Sales Order',
              onTap: () {
                var page = SalesPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: addonPurchaseOrder,
              label: 'Purchase Order',
              onTap: () {
                var page = PurchasePage.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: addonQuotation,
              label: 'Quotations',
              onTap: () {
                var page = QuotationPage.page(reference);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: addonProformaInvoice,
              label: 'Proforma Invoice',
              onTap: () {
                var page = ProformaPage.page(reference);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
