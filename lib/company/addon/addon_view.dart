import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import 'card/card.dart';
import 'link/user.dart';
import 'proforma/proforma.dart';
import 'purchase/purchase_order.dart';
import 'quotation/quotation.dart';
import 'sales/sales_order.dart';

class AddonView extends StatelessWidget {
  const AddonView(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => AddonView(document));
  }

  final QueryDocumentSnapshot<CompanyModal> document;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ADDON'),
      body: Column(children: [
        Expanded(
          child: Row(children: [
            ButtonView(
              name: addonCard,
              label: 'Business Card',
              onTap: () {
                var page = CardPage.page(document.data());
                Navigator.push(context, page);
              },
            ),
            const VerticalDivider(),
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
        const Divider(),
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
            const VerticalDivider(),
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
        const Divider(),
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
            const VerticalDivider(),
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
      ]),
    );
  }
}
