import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

class ViewAccountPdf extends StatelessWidget {
  final StatementModal modal;

  const ViewAccountPdf(this.modal, {Key? key})
      : super(key: key);

  static Route page(StatementModal modal) {
    return MaterialPageRoute(builder: (_) => ViewAccountPdf(modal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('ACCOUNT STATEMENT'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) => getAccountPdf(modal),
      ),
    );
  }
}
