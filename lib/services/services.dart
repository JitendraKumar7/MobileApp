import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:tally/modal/modal.dart';

FirebaseFirestore get _instance => FirebaseFirestore.instance;

FirestoreServices get db => FirestoreServices();

class FirestoreServices {
  static final FirestoreServices _singleton = FirestoreServices._internal();

  factory FirestoreServices() => _singleton;

  FirestoreServices._internal() {
    if (kIsWeb) {
      var settings = const PersistenceSettings(synchronizeTabs: true);
      _instance.enablePersistence(settings);
    } else {
      _instance.settings = const Settings(
        cacheSizeBytes: Settings.CACHE_SIZE_UNLIMITED,
        persistenceEnabled: true,
      );
    }
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCompany(String id) {
    return _instance.collection(id).doc('Tally').snapshots();
  }

  Stream<QuerySnapshot<CompanyModal>> getCompanyDoc(
    DocumentReference reference,
    String name,
  ) {
    return reference
        .collection(name)
        .withConverter<CompanyModal>(
          fromFirestore: (snapshot, _) =>
              CompanyModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  /* Master <Start> */
  Stream<QuerySnapshot<ItemModal>> getItems(DocumentReference reference) {
    return reference
        .collection('Item Master')
        .withConverter<ItemModal>(
          fromFirestore: (snapshot, _) => ItemModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('NAME')
        .snapshots();
  }

  Stream<QuerySnapshot<GroupModal>> getGroups(DocumentReference reference) {
    return reference
        .collection('Groups')
        .withConverter<GroupModal>(
          fromFirestore: (snapshot, _) => GroupModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('NAME')
        .snapshots();
  }

  Stream<QuerySnapshot<LedgerModal>> getLedger(DocumentReference reference) {
    return reference
        .collection('Ledger')
        .withConverter<LedgerModal>(
          fromFirestore: (snapshot, _) => LedgerModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('NAME')
        .snapshots();
  }

  Future<DocumentSnapshot<LedgerModal>> getLedgerQuery(
    DocumentReference reference,
    String name,
  ) {
    return reference
        .collection('Ledger')
        .doc(name.replaceAll('/', '-'))
        .withConverter<LedgerModal>(
          fromFirestore: (snapshot, _) => LedgerModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
  }

  /* Master <End> */

  /* Reports <Start> */
  Stream<QuerySnapshot<StockModal>> getStock(DocumentReference reference) {
    return reference
        .collection('Stock')
        .withConverter<StockModal>(
          fromFirestore: (snapshot, _) => StockModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<InvoiceModal>> getSales(DocumentReference reference) {
    return reference
        .collection('Sales')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('VOUCHERDATE', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<InvoiceModal>> getReceipts(DocumentReference reference) {
    return reference
        .collection('Receipt')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('VOUCHERDATE', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<InvoiceModal>> getPayments(DocumentReference reference) {
    return reference
        .collection('Payment')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('VOUCHERDATE', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<InvoiceModal>> getPurchase(DocumentReference reference) {
    return reference
        .collection('Purchase')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('VOUCHERDATE', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<InvoiceModal>> getDebitNote(
      DocumentReference reference) {
    return reference
        .collection('Debit Note')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('VOUCHERDATE', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<InvoiceModal>> getCreditNote(
      DocumentReference reference) {
    return reference
        .collection('Credit Note')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('VOUCHERDATE', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<StatementModal>> getStatement(
      DocumentReference reference) {
    return reference
        .collection('statement')
        .withConverter<StatementModal>(
          fromFirestore: (snapshot, _) =>
              StatementModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  /* Reports <End> */

  /* Addon <Start> */
  CollectionReference<OrderModal> salesOrder(DocumentReference reference) {
    return reference.collection('Sales Order').withConverter<OrderModal>(
          fromFirestore: (snapshot, _) => OrderModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  CollectionReference<ProformaModal> proformaInvoice(
      DocumentReference reference) {
    return reference
        .collection('Proforma Invoice')
        .withConverter<ProformaModal>(
          fromFirestore: (snapshot, _) =>
              ProformaModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  CollectionReference<OrderModal> purchaseOrder(DocumentReference reference) {
    return reference.collection('Purchase Order').withConverter<OrderModal>(
          fromFirestore: (snapshot, _) => OrderModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  CollectionReference<QuotationModal> quotation(DocumentReference reference) {
    return reference.collection('Quotation').withConverter<QuotationModal>(
          fromFirestore: (snapshot, _) =>
              QuotationModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        );
  }
/* Addon <End> */
}
