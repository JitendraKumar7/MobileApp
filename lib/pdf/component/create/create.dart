import 'dart:typed_data';
import 'package:pdf/widgets.dart';

//https://gist.github.com/JAICHANGPARK/be56df4464ad469e37af9099a82addfe
Future<Uint8List> create(Page page) async {
  final pdf = Document();
  pdf.addPage(page);

  return await pdf.save();
}
