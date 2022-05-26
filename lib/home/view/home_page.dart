import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shimmer/shimmer.dart';

import 'package:tally/app/app.dart';
import 'package:tally/home/home.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../company/company.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(
        child: HomePage(),
        name: '/index',
      );

  checkForUpdate() {
    InAppUpdate.checkForUpdate().then((updateInfo) {
      if (updateInfo.updateAvailability == UpdateAvailability.updateAvailable) {
        InAppUpdate.performImmediateUpdate().catchError((e) {
          debugPrint('PerformImmediateUpdate => $e');
        });
      }
      debugPrint('InAppUpdate Info =>  $updateInfo');
    }).catchError((e) {
      debugPrint('InAppUpdate =>  $e');
    });
  }

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    checkForUpdate();
    return Scaffold(
      appBar: AppBar(title: const Text('HOME')),
      drawer: const DrawerLayout(),
      body: StreamBuilder(
        stream: db.getCompany(user.id),
        builder: (_,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          if (snapshot.hasData) {
            var data = snapshot.data;
            return data == null ? const EmptyView() : Company(data);
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
