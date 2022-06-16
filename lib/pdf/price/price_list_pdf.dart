import 'dart:typed_data';

import 'package:pdf/widgets.dart';
import 'package:tally/modal/modal.dart';

import '../component/component.dart';

Future<Uint8List> getPriceListPdf(
  CompanyModal modal,
  List<PriceListModal> items,
) async {
  final page = MultiPage(
    maxPages: 999,
    build: (Context context) => bodyPriceList(context, items),
    header: (Context context) => headerPriceList(context, modal),
  );
  return create(page);
}
