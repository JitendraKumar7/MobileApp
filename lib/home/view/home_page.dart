import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:tally/app/app.dart';
import 'package:tally/home/home.dart';
import 'package:tally/company/company.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: HomePage());

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);

    return  Scaffold(
            appBar: AppBar(title: const Text('HOME')),
            drawer: const DrawerLayout(),
            body: StreamBuilder(
              stream: db.getCompany(user.id),
              builder: (_, AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasData) {
                  var data = [];
                  try {
                    data = snapshot.data?.get('companyName');
                  } catch (ex) {
                    debugPrint('$ex');
                  }
                  var reference = snapshot.data?.reference;

                  return data.isEmpty
                      ? const EmptyView()
                      : ListView(
                          children: data
                              .map<Widget>((companyName) => CompanyPage(
                                    companyName: companyName,
                                    reference: reference!,
                                  ))
                              .toList(),
                        );
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
