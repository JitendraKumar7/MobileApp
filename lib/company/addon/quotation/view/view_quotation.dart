import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

import '../../../../services/services.dart';

class ViewQuotation extends StatelessWidget {
  final DocumentReference reference;
  final QuotationModal modal;

  const ViewQuotation(
    this.reference,
    this.modal, {
    Key? key,
  }) : super(key: key);

  static Route page(DocumentReference reference, QuotationModal modal) {
    return MaterialPageRoute(
      builder: (_) => ViewQuotation(reference, modal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('QUOTATION'),
      body: FutureBuilder(
          future: db.getCompanyQuery(reference.parent),
          builder: (_, AsyncSnapshot<DocumentSnapshot<CompanyModal>> snapshot) {
            if (snapshot.hasData) {
              var company = snapshot.data?.data() ?? CompanyModal();
              modal.company = company;
              return PdfPreview(
                canDebug: false,
                canChangePageFormat: false,
                canChangeOrientation: false,
                initialPageFormat: PdfPageFormat.a4,
                build: (format) => getQuotationPdf(modal),
              );
            }
            return const LoaderPage();
          }),
    );
  }
}
