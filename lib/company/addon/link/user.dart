import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/widget/widget.dart';

class UserPage extends StatelessWidget {
  const UserPage(this.reference, {Key? key}) : super(key: key);

  final DocumentReference reference;

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => UserPage(reference));
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: Toolbar('LINK USERS'),
      body: EmptyView(),
    );
  }
}
