import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../reports_view.dart';
import 'view/view_purchase.dart';

class PurchasePage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const PurchasePage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => PurchasePage(document));
  }

  void onClick(
    List<QueryDocumentSnapshot<MonthModal>> docs,
    BuildContext context,
    String month,
  ) {
    if (docs.any((e) => e.id == month)) {
      var doc = docs.firstWhere((e) => e.id == month);
      var page = ReportsViewPage.page(doc, (InvoiceModal modal) {
        var page = ViewPurchasePage.page(modal.setLedger(document));
        Navigator.push(context, page);
      });
      Navigator.push(context, page);
    }
    // No Records
    else {
      showAlertDialog(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamLoader(
      stream: db.getPurchase(document.reference),
      loader: (List<QueryDocumentSnapshot<MonthModal>> docs) {
        debugPrint('${docs.map((e) => e.id).toList()}');
        return MonthGridView(
          'PURCHASE',
          september: () => onClick(docs, context, 'September'),
          february: () => onClick(docs, context, 'February'),
          december: () => onClick(docs, context, 'December'),
          november: () => onClick(docs, context, 'November'),
          january: () => onClick(docs, context, 'January'),
          october: () => onClick(docs, context, 'October'),
          august: () => onClick(docs, context, 'August'),
          march: () => onClick(docs, context, 'March'),
          april: () => onClick(docs, context, 'April'),
          july: () => onClick(docs, context, 'July'),
          june: () => onClick(docs, context, 'June'),
          may: () => onClick(docs, context, 'May'),
        );
      },
    );
  }
}
