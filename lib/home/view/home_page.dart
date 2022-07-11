import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/app/app.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../company/company.dart';
import '../../gstin_window/gstin_window.dart';
import '../home.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Column(children: [
      CarouselSlider(
        options: CarouselOptions(
          viewportFraction: 1,
          autoPlay: true,
          height: 180.0,
        ),
        items: [1, 2, 3, 4, 5].map((i) {
          return SizedBox(
            width: double.infinity,
            child: Image.network(
              'https://picsum.photos/30$i/200',
              fit: BoxFit.cover,
            ),
          );
        }).toList(),
      ),
      Expanded(
        child: StreamBuilder(
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
      ),
    ]);
  }
}

class IndexPage extends StatefulWidget {
  const IndexPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: IndexPage());

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  checkForUpdate() {
    if (Platform.isAndroid) {
      InAppUpdate.checkForUpdate().then((updateInfo) {
        if (updateInfo.updateAvailability ==
            UpdateAvailability.updateAvailable) {
          InAppUpdate.performImmediateUpdate().catchError((e) {
            debugPrint('PerformImmediateUpdate => $e');
          });
        }
        debugPrint('InAppUpdate Info =>  $updateInfo');
      }).catchError((e) {
        debugPrint('InAppUpdate =>  $e');
      });
    }
  }

  int _index = 0;

  @override
  void initState() {
    super.initState();
    checkForUpdate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _index,
        children: const [HomePage(), GstinWindow(), DrawerLayout()],
      ),
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        elevation: _index == 2 ? 0 : 4,
        title: Text(
          _index == 0
              ? 'DASHBOARD'
              : _index == 1
                  ? 'GSTIN WINDOW'
                  : 'APP SETTINGS',
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (newIndex) {
            //debugPrint('DASHBOARD $_index, $newIndex');
            setState(() => _index = newIndex);
          },
          currentIndex: _index,
          unselectedFontSize: 8,
          selectedFontSize: 8,
          iconSize: 18,
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/new/home.png',
                fit: BoxFit.fill,
                height: 24,
              ),
              label: 'DASHBOARD',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/new/gstin.png',
                fit: BoxFit.fill,
                height: 24,
              ),
              label: 'GSTIN WINDOW',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(
                'assets/new/settings.png',
                fit: BoxFit.fill,
                height: 24,
              ),
              label: 'APP SETTINGS',
            ),
          ]),
    );
  }
}
