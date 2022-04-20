import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/modal/company/company_modal.dart';
import 'package:tally/widget/widget.dart';

import 'widget/bar.dart';
import 'items/master_items.dart';
import 'groups/master_groups.dart';
import 'ledger/master_ledger.dart';

class MasterView extends StatefulWidget {
  const MasterView(this.docs, {Key? key}) : super(key: key);

  static Route page(List<QueryDocumentSnapshot<CompanyModal>> docs) {
    return MaterialPageRoute(builder: (_) => MasterView(docs));
  }

  final List<QueryDocumentSnapshot<CompanyModal>> docs;

  @override
  State<MasterView> createState() => _MasterViewState();
}

class _MasterViewState extends State<MasterView> {
  QueryDocumentSnapshot<CompanyModal>? document;

  Widget body(int index) {
    var doc = document ?? widget.docs.first;
    switch (index) {
      case 0:
        return MasterLedger(doc);
      case 1:
        return MasterItems(doc.reference);
      case 2:
        return MasterGroups(doc.reference);
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
  void initState() {
    super.initState();
    document = widget.docs.first;
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigateCubit(),
      child: BlocBuilder<NavigateCubit, int>(
        builder: (_, index) => Scaffold(
          bottomNavigationBar: NavigatePage(index),
          appBar: Toolbar(title(index), actions: [
            SizedBox(
              width: 110,
              child: DropdownButtonFormField(
                value: document,
                dropdownColor: Colors.grey,
                iconEnabledColor: Colors.white,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                    borderSide: BorderSide(
                      style: BorderStyle.none,
                      width: 0,
                    ),
                  ),
                ),
                onChanged: (QueryDocumentSnapshot<CompanyModal>? value) {
                  if (value != null) {
                    setState(() => document = value);
                  }
                },
                items: widget.docs.map((value) {
                  return DropdownMenuItem(
                    value: value,
                    child: Text(
                      value.id,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    ),
                  );
                }).toList(),
              ),
            )
          ]),
          body: body(index),
        ),
      ),
    );
  }
}
