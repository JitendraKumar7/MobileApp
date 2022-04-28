import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:tally/app/app.dart';
import 'package:tally/home/home.dart';
import 'package:tally/company/company.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../modal/modal.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(
        child: HomePage(),
        name: '/index',
      );

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return Scaffold(
      appBar: AppBar(title: const Text('HOME')),
      drawer: const DrawerLayout(),
      body: StreamBuilder(
        stream: db.getCompany(user.id),
        builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            if (data == null) return const EmptyView();

            List<CompanyModal> names = [];
            try {
              data.get('companyName').map((e) {
                names.add(CompanyModal.fromJson(e));
              });
            } catch (ex) {
              debugPrint('$ex');
            }
            return names.isEmpty
                ? const EmptyView()
                : Company(data.reference, names: names);
          }
          return Shimmer.fromColors(
            baseColor: Colors.grey,
            highlightColor: Colors.blue,
            child: const Center(child: CupertinoActivityIndicator()),
          );
        },
      ),
    );
  }
}
