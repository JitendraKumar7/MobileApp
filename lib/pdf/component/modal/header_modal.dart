import 'package:tally/modal/modal.dart';

class HeaderModal {
  String? date;
  String? name;
  String? title;
  String? gstin;
  String? address;
  String? invoiceNo;

  String get getDate => date ?? '';

  String get getName => name?.toUpperCase() ?? '';

  String get getGstin => 'GSTIN : ${gstin ?? ' '}';

  String get getTitle => title ?? '';

  String get getAddress => address?.toUpperCase() ?? '';

  String get getInvoiceNo => invoiceNo ?? '';

  HeaderModal.fromLedger(String label, LedgerModal modal, int timestamp,
      [String? id]) {
    invoiceNo = '${id ?? 'Invoice No.'} $timestamp';
    date = getDateTimeFormat(timestamp);
    address = modal.address;
    gstin = modal.partyGstin;
    name = modal.name;
    title = label;
  }

  HeaderModal.fromInvoice(String label, InvoiceModal modal, [String? id]) {
    invoiceNo = '${id ?? 'Invoice '} ${modal.id}';
    address = modal.ledger?.address;
    gstin = modal.ledger?.partyGstin;
    name = modal.partyName;
    date = modal.date;
    title = label;
  }
}
