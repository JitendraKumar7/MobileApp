import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/company/company.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/services/services.dart';

class Company extends StatelessWidget {
  final DocumentReference reference;
  final List<CompanyModal> names;

  const Company(
    this.reference, {
    Key? key,
    required this.names,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = TextButton.styleFrom(
      minimumSize: Size(size.width / 3.5, 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(width: 0.6),
      ),
    );
    return ListView(
      children: names
          .map<Widget>((name) => StreamBuilder(
                stream: db.getCompanyDoc(reference, name.name ?? ''),
                builder: (_, AsyncSnapshot snapshot) {
                  var docs = snapshot.data?.docs ?? [];
                  if (docs.isEmpty) {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
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
                      ]),
                    );
                  }
                  // show company
                  else {
                    return Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6)),
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
                                  var page = MasterView.page(docs);
                                  Navigator.push(context, page);
                                },
                                child: const Text('MASTERS'),
                              ),
                              TextButton(
                                style: style,
                                onPressed: () {
                                  var page = ReportsView.page(docs);
                                  Navigator.push(context, page);
                                },
                                child: const Text('REPORTS'),
                              ),
                              TextButton(
                                style: style,
                                onPressed: () {
                                  var page = AddonView.page(docs);
                                  Navigator.push(context, page);
                                },
                                child: const Text('ADDONS'),
                              ),
                            ]),
                      ]),
                    );
                  }
                },
              ))
          .toList(),
    );
  }
}
