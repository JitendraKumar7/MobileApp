import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import '../services/services.dart';

class ProfilePage extends StatelessWidget {
  final String id;

  const ProfilePage(this.id, {Key? key}) : super(key: key);

  static Route page(String? id) {
    return MaterialPageRoute(builder: (_) => ProfilePage(id ?? 'id'));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Toolbar('PROFILE'),
      body: StreamLoader(
        loader: (List<QueryDocumentSnapshot<ProfileModal>> docs) {
          debugPrint('PROFILE =>  ${jsonEncode(docs.first.data())}');
          ProfileModal modal = docs.first.data();
          return ListView(padding: const EdgeInsets.all(12), children: <Widget>[
            ProfileWidget(capture: (bytes) {}),
            Container(
              padding: const EdgeInsets.all(12),
              alignment: Alignment.center,
              child: Text(
                modal.name,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),

            //Address
            CardView('Information', children: [
              RowView(title: 'Mobile', value: modal.mobile),
              RowView(title: 'Email Id', value: modal.email),
              RowView(title: 'Password', value: modal.password),
              //RowView(title: 'PIN Code', value: '201015'),
            ]),
          ]);
        },
        stream: db.profile(id),
      ),
    );
  }
}
