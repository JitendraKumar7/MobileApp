import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/modal/modal.dart' as m;

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

  CollectionReference<FeedbackModal> get feedback {
    return _instance.collection('Feedback').withConverter<FeedbackModal>(
          fromFirestore: (snapshot, _) =>
              FeedbackModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        );
  }

  Stream<QuerySnapshot<ProfileModal>> profile(String id) {
    return _instance
        .collection(id)
        .doc('Tally Konnect')
        .collection('Users Info')
        .withConverter<ProfileModal>(
          fromFirestore: (snapshot, _) =>
              ProfileModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> carouselSlider() {
    return _instance.doc('TallyKonnect/CarouselSlider').snapshots();
  }

  Stream<DocumentSnapshot<Map<String, dynamic>>> getCompany(String id) {
    return _instance.collection(id).doc('Tally').snapshots();
  }

  Stream<QuerySnapshot> getCompanyDoc(
      DocumentReference reference, String name) {
    return reference.collection(name).snapshots();
  }

  Future<DocumentSnapshot<CompanyModal>> getCompanyQuery(
      CollectionReference reference) {
    return reference.parent!
        .withConverter<CompanyModal>(
          fromFirestore: (snapshot, _) =>
              CompanyModal.fromJson(snapshot.data()?[reference.id]),
          toFirestore: (model, _) => model.toJson(),
        )
        .get();
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

  Stream<QuerySnapshot<ItemModal>> getShowItems(DocumentReference reference) {
    return reference
        .collection('Item Master')
        .withConverter<ItemModal>(
          fromFirestore: (snapshot, _) => ItemModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('NAME')
        .where('SHOW', isEqualTo: true)
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
        .collection('Stock Summary')
        .withConverter<StockModal>(
          fromFirestore: (snapshot, _) => StockModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<MonthModal>> getSales(DocumentReference reference) {
    return reference
        .collection('Sales')
        .withConverter<MonthModal>(
          fromFirestore: (snapshot, _) => MonthModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<MonthModal>> getReceipts(DocumentReference reference) {
    return reference
        .collection('Receipt')
        .withConverter<MonthModal>(
          fromFirestore: (snapshot, _) => MonthModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<MonthModal>> getPayments(DocumentReference reference) {
    return reference
        .collection('Payment')
        .withConverter<MonthModal>(
          fromFirestore: (snapshot, _) => MonthModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<MonthModal>> getPurchase(DocumentReference reference) {
    return reference
        .collection('Purchase')
        .withConverter<MonthModal>(
          fromFirestore: (snapshot, _) => MonthModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<MonthModal>> getDebitNote(DocumentReference reference) {
    return reference
        .collection('Debit Note')
        .withConverter<MonthModal>(
          fromFirestore: (snapshot, _) => MonthModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<MonthModal>> getCreditNote(DocumentReference reference) {
    return reference
        .collection('Credit Note')
        .withConverter<MonthModal>(
          fromFirestore: (snapshot, _) => MonthModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Query<InvoiceModal> getInvoiceByMonth(DocumentReference reference) {
    return reference
        .collection('TRANSACTION')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .orderBy('VOUCHERDATE', descending: true);
  }

  Stream<QuerySnapshot<InvoiceModal>> getInvoiceByQuery(
    DocumentReference reference,
    String? name,
  ) {
    return reference
        .collection('TRANSACTION')
        .withConverter<InvoiceModal>(
          fromFirestore: (snapshot, _) =>
              InvoiceModal.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        //.orderBy('VOUCHERDATE', descending: true)
        .where('PARTYLEDGERNAME', isEqualTo: name)
        .snapshots();
  }

  Stream<QuerySnapshot<Outstanding>> getPayable(DocumentReference reference) {
    return reference
        .collection('Payable')
        .withConverter<Outstanding>(
          fromFirestore: (snapshot, _) => Outstanding.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<m.Transaction>> getTransactions(
      DocumentReference reference, String name) {
    return reference
        .collection(name)
        .withConverter<m.Transaction>(
          fromFirestore: (snapshot, _) =>
              m.Transaction.fromJson(snapshot.data()),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<StatementModal>> getStatement(
      DocumentReference reference) {
    return reference
        .collection('Account Statement')
        .withConverter<StatementModal>(
          fromFirestore: (snapshot, _) => StatementModal.fromJson(
            reference: snapshot.reference,
            json: snapshot.data(),
            id: snapshot.id,
          ),
          toFirestore: (model, _) => model.toJson(),
        )
        .snapshots();
  }

  Stream<QuerySnapshot<StatementModal>> getStatementByQuery(
    DocumentReference reference,
    String? name,
  ) {
    return reference
        .collection('Account Statement')
        .withConverter<StatementModal>(
          fromFirestore: (snapshot, _) => StatementModal.fromJson(
            reference: snapshot.reference,
            json: snapshot.data(),
            id: snapshot.id,
          ),
          toFirestore: (model, _) => model.toJson(),
        )
        .where('NAME', isEqualTo: name)
        .snapshots();
  }

  Stream<QuerySnapshot<Outstanding>> getReceivable(
      DocumentReference reference) {
    return reference
        .collection('Receivable')
        .withConverter<Outstanding>(
          fromFirestore: (snapshot, _) => Outstanding.fromJson(snapshot.data()),
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
