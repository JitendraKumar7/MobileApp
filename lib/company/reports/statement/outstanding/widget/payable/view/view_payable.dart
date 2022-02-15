import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/pdf/pdf.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

class ViewPayable extends StatelessWidget {
  final Outstanding modal;

  const ViewPayable(
    this.modal, {
    Key? key,
  }) : super(key: key);

  static Route page(Outstanding modal) {
    return MaterialPageRoute(builder: (_) => ViewPayable(modal));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('PAYABLE'),
      body: PdfPreview(
        canDebug: false,
        canChangePageFormat: false,
        canChangeOrientation: false,
        initialPageFormat: PdfPageFormat.a4,
        build: (format) async => getPayablePdf(modal),
      ),
    );
  }
}
