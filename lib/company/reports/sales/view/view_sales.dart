import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

class ViewSalesPage extends StatelessWidget {
  final Future<InvoiceModal> modal;

  const ViewSalesPage({
    Key? key,
    required this.modal,
  }) : super(key: key);

  static Route page(Future<InvoiceModal> modal) {
    return MaterialPageRoute(
      builder: (_) => ViewSalesPage(modal: modal),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('SALES INVOICE'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) async => getSalesPdf(await modal),
      ),
    );
  }
}
