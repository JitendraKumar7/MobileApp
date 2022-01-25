import 'package:collection/collection.dart';

import '../../modal.dart';

class ProformaModal extends BaseModal {
  bool integratedTax = true;

  ProformaModal();

  List<List<String>> get data {
    return items.map((e) => e.proforma).toList();
  }

  List<List<String>> get sundry {
    var taxAmount = items.map((e) => e.taxAmount).sum;
    var beforeTax = items.map((e) => e.beforeTax).sum;
    var totalAmount = items.map((e) => e.totalAmount).sum;

    var taxLocal = (taxAmount / 2).toStringAsFixed(2);
    var taxCentral = taxAmount.toStringAsFixed(2);

    var totalRoundAmount = totalAmount.round();
    var roundOff = totalRoundAmount - totalAmount;

    return [
      ['', 'BEFORE TAX', beforeTax.toStringAsFixed(2)],
      ...integratedTax
          ? [
        ['', 'IGST', taxCentral]
      ]
          : [
        ['', 'CGST', taxLocal],
        ['', 'CGST', taxLocal],
      ],
      [
        '',
        'ROUND OFF (${roundOff > 0 ? '+' : '-'})',
        roundOff.toStringAsFixed(2),
      ],
      ['', 'TOTAL AMOUNT', totalRoundAmount.toStringAsFixed(2)],
    ];
  }

  @override
  Map<String, dynamic> toJson() {
    Map<String, dynamic> data = jsonData();
    data['INTEGRATED'] = integratedTax;
    return data;
  }

  ProformaModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    integratedTax = json['INTEGRATED'];
    jsonParse(json);
  }
}
