import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../reports_view.dart';
import 'view/view_credit.dart';

class CreditPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const CreditPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => CreditPage(document));
  }

  void onClick(
    List<QueryDocumentSnapshot<MonthModal>> docs,
    BuildContext context,
    String month,
  ) {
    if (docs.any((e) => e.id == month)) {
      var doc = docs.firstWhere((e) => e.id == month);
      var page = ReportsViewPage.page(doc, (InvoiceModal modal) {
        var page = ViewCreditPage.page(modal.setLedger(document));
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
      stream: db.getCreditNote(document.reference),
      builder: (List<QueryDocumentSnapshot<MonthModal>> docs) {
        return MonthGridView(
          'CREDIT NOTE',
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
