import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

class ViewReceiptsPage extends StatelessWidget {
  final CompanyModal company;
  final InvoiceModal modal;

  const ViewReceiptsPage({
    Key? key,
    required this.company,
    required this.modal,
  }) : super(key: key);

  static Route page({
    required InvoiceModal modal,
    required CompanyModal company,
  }) {
    return MaterialPageRoute(
      builder: (_) => ViewReceiptsPage(
        company: company,
        modal: modal,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(modal.toString());
    return Scaffold(
      appBar: const Toolbar('RECEIPTS'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) => getReceiptPdf(company, modal),
      ),
    );
  }
}