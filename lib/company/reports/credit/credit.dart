import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../reports_view.dart';

class CreditPage extends StatelessWidget {
  final DocumentReference reference;

  const CreditPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => CreditPage(reference));
  }

  void onClick(
    List<QueryDocumentSnapshot<MonthModal>> docs,
    BuildContext context,
    String month,
  ) {
    if (docs.any((e) => e.id == month)) {
      var doc = docs.firstWhere((e) => e.id == month);
      var page = ReportsPage.page(doc, (InvoiceModal modal) {
        var page = ViewCreditPage.page(modal.setLedger(reference));
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
      stream: db.getCreditNote(reference),
      builder: (List<QueryDocumentSnapshot<MonthModal>> docs) {
        return MonthGridView(
          'CREDIT NOTE',
          reference.parent.id,
          onPressed: docs.isEmpty
              ? null
              : () {
                  var page = AllReportsPage.page(docs, (InvoiceModal modal) {
                    var page = ViewCreditPage.page(modal.setLedger(reference));
                    Navigator.push(context, page);
                  });
                  Navigator.push(context, page);
                },
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
