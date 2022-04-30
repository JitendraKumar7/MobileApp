import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import 'package:tally/app/app.dart';
import 'package:tally/home/home.dart';
import 'package:tally/services/services.dart';
import 'package:tally/widget/widget.dart';

import '../../constant/constant.dart';
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
    var size = MediaQuery.of(context).size;
    var style = TextButton.styleFrom(
      minimumSize: Size(size.width / 3.5, 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(width: 0.6),
      ),
    );
    return Scaffold(
      appBar: AppBar(title: const Text('HOME')),
      drawer: const DrawerLayout(),
      body: StreamBuilder(
        stream: db.getCompany(user.id),
        builder: (_,
            AsyncSnapshot<DocumentSnapshot<Map<String, dynamic>>> snapshot) {
          List<CompanyModal> list = [];
          if (snapshot.hasData) {
            var data = snapshot.data?.data() ?? {};

            try {
              data.forEach((key, value) {
                list.add(CompanyModal.fromJson(value));
                debugPrint('companyName $key');
              });
            } catch (ex) {
              debugPrint('$ex');
            }
            return list.isEmpty
                ? const EmptyView()
                : ListView(
                    children: list.map((name) {
                    return Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(children: [
                        ListTile(
                          title: Text(
                            name.getName,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          leading: Container(
                            width: 48,
                            clipBehavior: Clip.hardEdge,
                            child: name.logo == null
                                ? Image.asset(logo)
                                : Image.network(
                                    name.logo!,
                                    fit: BoxFit.fill,
                                  ),
                            decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                            ),
                          ),
                        ),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TextButton(
                                style: style,
                                onPressed: () {
                                  //var page = MasterView.page(docs);
                                  //Navigator.push(context, page);
                                },
                                child: const Text('MASTERS'),
                              ),
                              TextButton(
                                style: style,
                                onPressed: () {
                                  //var page = ReportsView.page(docs);
                                  //Navigator.push(context, page);
                                },
                                child: const Text('REPORTS'),
                              ),
                              TextButton(
                                style: style,
                                onPressed: () {
                                  //var page = AddonView.page(docs);
                                  //Navigator.push(context, page);
                                },
                                child: const Text('ADDONS'),
                              ),
                            ]),
                      ]),
                    );
                  }).toList());
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
