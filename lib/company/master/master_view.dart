import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/widget/widget.dart';

import 'widget/bar.dart';
import 'items/master_items.dart';
import 'groups/master_groups.dart';
import 'ledger/master_ledger.dart';

class MasterView extends StatelessWidget {
  const MasterView(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => MasterView(reference));
  }

  final DocumentReference reference;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigateCubit(),
      child: Scaffold(
        appBar: const Toolbar('MASTERS'),
        body: BlocBuilder<NavigateCubit, int>(
          builder: (_, index) {
            switch (index) {
              case 0:
                return MasterLedger(reference);
              case 1:
                return MasterItems(reference);
              case 2:
                return MasterGroups(reference);
              default:
                return Center(child: Text('Error $index'));
            }
          },
        ),
        bottomNavigationBar: const NavigatePage(),
      ),
    );
  }
}



