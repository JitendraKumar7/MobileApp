import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

class ViewCreditPage extends StatelessWidget {
  final Future<InvoiceModal> modal;

  const ViewCreditPage({
    Key? key,
    required this.modal,
  }) : super(key: key);

  static Route page(Future<InvoiceModal> modal) {
    return MaterialPageRoute(
      builder: (_) => ViewCreditPage(modal: modal),
    );
  }

  @override
  Widget build(BuildContext context) {
    debugPrint(modal.toString());
    return Scaffold(
      appBar: const Toolbar('CREDIT NOTE'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) async => getCreditPdf(await modal),
      ),
    );
  }
}
