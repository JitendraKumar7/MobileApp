import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/widget/widget.dart';

import 'widget/bar.dart';
import 'account/account.dart';
import 'outstanding/outstanding.dart';

class StatementPage extends StatelessWidget {
  final DocumentReference reference;

  const StatementPage(this.reference, {Key? key}) : super(key: key);

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => StatementPage(reference));
  }

  Widget body(bool account) =>
      account ? AccountView(reference) : OutstandingView(reference);

  String title(bool account) => account ? 'ACCOUNT STATEMENT' : 'OUTSTANDING';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => NavigateCubit(),
      child: BlocBuilder<NavigateCubit, int>(
        builder: (_, index) => Scaffold(
          bottomNavigationBar: NavigatePage(index),
          appBar: Toolbar(title(index == 0)),
          body: body(index == 0),
        ),
      ),
    );
  }
}
