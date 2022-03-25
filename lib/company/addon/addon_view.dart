import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import 'card/card.dart';
import 'link/user.dart';
import 'sales/sales_order.dart';
import 'proforma/proforma.dart';
import 'quotation/quotation.dart';
import 'purchase/purchase_order.dart';

class AddonView extends StatelessWidget {
  const AddonView(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddonView(document));
  }

  final QueryDocumentSnapshot<CompanyModal> document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('BUSINESS ADDONS'),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(18),
          alignment: Alignment.center,
          child: Text(
            document.data().getName,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: addonCard,
              label: 'Business Card',
              onTap: () {
                var page = BusinessCardPage.page(document);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: addonLinkUser,
              label: 'Link User',
              onTap: () {
                var page = UserPage.page(document.reference);
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
                var page = SalesPage.page(document);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: addonPurchaseOrder,
              label: 'Purchase Order',
              onTap: () {
                var page = PurchasePage.page(document);
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
                var page = QuotationPage.page(document);
                Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: addonProformaInvoice,
              label: 'Proforma Invoice',
              onTap: () {
                var page = ProformaPage.page(document);
                Navigator.push(context, page);
              },
            ),
          ]),
        ),
        //const Divider(),
        Expanded(
          child: Row(children: [
            ButtonView(
              name: report,
              label: 'M Box',
              onTap: () {
                //var page = QuotationPage.page(document);
                //Navigator.push(context, page);
              },
            ),
            //const VerticalDivider(),
            ButtonView(
              name: gst,
              label: 'Gst Window',
              onTap: () {
                //var page = ProformaPage.page(document);
                //Navigator.push(context, page);
              },
            ),
          ]),
        ),
      ]),
    );
  }
}
