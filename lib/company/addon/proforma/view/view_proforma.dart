import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

class ViewProformaInvoice extends StatelessWidget {
  final ProformaModal modal;

  const ViewProformaInvoice(
    this.modal, {
    Key? key,
  }) : super(key: key);

  static Route page(ProformaModal modal) {
    return MaterialPageRoute(builder: (_) => ViewProformaInvoice(modal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('INVOICE SUMMARY'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) => getProformaPdf(modal),
      ),
    );
  }
}
