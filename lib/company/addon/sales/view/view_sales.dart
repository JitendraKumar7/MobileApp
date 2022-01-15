import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/widget/widget.dart';

class ViewSalesOrder extends StatelessWidget {
  final OrderModal modal;

  const ViewSalesOrder(
      this.modal, {
        Key? key,
      }) : super(key: key);

  static Route page(OrderModal modal) {
    return MaterialPageRoute(builder: (_) => ViewSalesOrder(modal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('SALES SUMMARY'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) => getSalesOrderPdf(modal),
      ),
    );
  }
}