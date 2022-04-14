import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/modal/company/company_modal.dart';
import 'package:tally/widget/widget.dart';

import 'widget/bar.dart';
import 'items/master_items.dart';
import 'groups/master_groups.dart';
import 'ledger/master_ledger.dart';

class MasterView extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const MasterView(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => MasterView(document));
  }

  Widget body(int index) {
    switch (index) {
      case 0:
        return MasterLedger(document);
      case 1:
        return MasterItems(document.reference);
      case 2:
        return MasterGroups(document.reference);
      default:
        return Center(child: Text('Error $index'));
    }
  }

  String title(int index) {
    switch (index) {
      case 0:
        return 'ACCOUNT MASTERS';
      case 1:
        return 'ITEM MASTERS';
      case 2:
        return 'GROUP MASTERS';
      default:
        return 'MASTERS';
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigateCubit(),
      child: BlocBuilder<NavigateCubit, int>(
        builder: (_, index) => Scaffold(
          bottomNavigationBar: NavigatePage(index),
          appBar: Toolbar(title(index)),
          body: body(index),
        ),
      ),
    );
  }
}
