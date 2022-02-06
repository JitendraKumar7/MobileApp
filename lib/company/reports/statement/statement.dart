import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import 'widget/bar.dart';
import 'account/account.dart';
import 'outstanding/outstanding.dart';

//_-_ ==> 1.) ACCOUNT STATEMENT
//_-_ ==> 2.) OUTSTANDING
//_-_ ==> 2.1) RECEIVABLES
//_-_ ==> 2.2) PAYABLE

class StatementPage extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const StatementPage(this.document, {Key? key}) : super(key: key);

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => StatementPage(document));
  }

  Widget body(int index) {
    switch (index) {
      case 0:
        return AccountView(document);
      case 1:
        return OutstandingView(document);
      default:
        return Center(child: Text('Error $index'));
    }
  }

  String title(int index) {
    switch (index) {
      case 0:
        return 'ACCOUNT STATEMENT';
      case 1:
        return 'OUTSTANDING';
      default:
        return 'STATEMENT';
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
