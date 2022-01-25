import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

class ViewQuotation extends StatelessWidget {
  final QuotationModal modal;

  const ViewQuotation(
    this.modal, {
    Key? key,
  }) : super(key: key);

  static Route page(QuotationModal modal) {
    return MaterialPageRoute(builder: (_) => ViewQuotation(modal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('QUOTATION'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) => getQuotationPdf(modal),
      ),
    );
  }
}
