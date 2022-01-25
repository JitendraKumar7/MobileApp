import '../../modal.dart';

class QuotationModal extends BaseModal{

  QuotationModal();

  List<List<String>> get data {
    return items.map((e) => e.quotation).toList();
  }

  QuotationModal.fromJson(Map<String, dynamic>? json) {
    if (json == null) return;
    jsonParse(json);
  }

}
