import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

import '../../../../services/services.dart';

class ViewPriceList extends StatelessWidget {
  final DocumentReference reference;
  final List<PriceListModal> items;

  const ViewPriceList(
    this.reference,
    this.items, {
    Key? key,
  }) : super(key: key);

  static Route page(DocumentReference reference, List<PriceListModal> items) {
    return MaterialPageRoute(
      builder: (_) => ViewPriceList(reference, items),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('PRICE LIST'),
      body: FutureBuilder(
          future: db.getCompanyQuery(reference.parent),
          builder: (_, AsyncSnapshot<DocumentSnapshot<CompanyModal>> snapshot) {
            if (snapshot.hasData) {
              var company = snapshot.data?.data() ?? CompanyModal();
              return PdfPreview(
                canDebug: false,
                canChangePageFormat: false,
                canChangeOrientation: false,
                initialPageFormat: PdfPageFormat.a4,
                build: (format) => getPriceListPdf(company, items),
              );
            }
            return const LoaderPage();
          }),
    );
  }
}
