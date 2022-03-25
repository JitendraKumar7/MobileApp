import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import '../constant/constant.dart';
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
        builder: (List<QueryDocumentSnapshot<ProfileModal>> docs) {
          ProfileModal modal = docs.first.data();
          debugPrint('PROFILE =>  $modal');
          return ListView(padding: const EdgeInsets.all(12), children: <Widget>[
            ImageWidget(
              capture: (url) async {
                var data = modal.setProfile(url);
                await docs.first.reference.set(data);
              },
              url: modal.profile ?? '',
              asset: person,
              ref: 'profile',
              id: id,
            ),
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

            // About
            CardView('About', children: [
              RowView(title: 'Mobile', value: modal.mobile),
              RowView(title: 'Email Id', value: modal.email),
              RowView(title: 'Password', value: modal.password),
              //RowView(title: 'PIN Code', value: '201015'),
            ]),
          ]);
        },
        stream: db.profile(id),
        empty: true,
      ),
    );
  }
}
