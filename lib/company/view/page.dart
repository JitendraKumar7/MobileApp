import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/company/company.dart';
import 'package:tally/company/reports/reports_view.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/services/firestore_services.dart';
import 'package:tally/widget/widget.dart';

class CompanyButton extends StatelessWidget {
  final QueryDocumentSnapshot<CompanyModal> document;

  const CompanyButton(
    this.document, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var style = TextButton.styleFrom(
      minimumSize: Size(size.width / (kIsWeb ? 4.5 : 3.5), 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(width: 0.6),
      ),
      backgroundColor: Colors.white,
      primary: Colors.blue,
      elevation: 0,
    );
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      ElevatedButton(
        style: style,
        onPressed: () {
          var page = MasterView.page(document.reference);
          Navigator.push(context, page);
        },
        child: const Text('MASTERS'),
      ),
      ElevatedButton(
        style: style,
        onPressed: () {
          var page = ReportsView.page(document);
          Navigator.push(context, page);
        },
        child: const Text('REPORTS'),
      ),
      ElevatedButton(
        style: style,
        onPressed: () {
          var page = AddonView.page(document);
          Navigator.push(context, page);
        },
        child: const Text('ADDONS'),
      ),
    ]);
  }
}

class CompanyPage extends StatelessWidget {
  final DocumentReference reference;
  final String companyName;

  const CompanyPage({
    Key? key,
    required this.reference,
    required this.companyName,
  }) : super(key: key);

  Widget listTile({Widget? subtitle}) {
    return ListTile(
      title: Text(
        companyName.toUpperCase(),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.bold,
        ),
      ),
      leading: Container(
        width: 48,
        decoration: BoxDecoration(
          color: Colors.grey[100],
          shape: BoxShape.circle,
        ),
        child: Image.asset(logo),
      ),
      subtitle: subtitle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: db.getCompanyDoc(reference, companyName),
      builder: (_, AsyncSnapshot<QuerySnapshot<CompanyModal>> snapshot) {
        QueryDocumentSnapshot<CompanyModal>? document;

        if (snapshot.hasData) {
          var docs = snapshot.data?.docs ?? [];
          return docs.isEmpty
              ? const EmptyView()
              : StatefulBuilder(builder: (_, setState) {
                  document ??= docs.first;
                  var modal = document!.data();
                  return Card(
                    clipBehavior: Clip.hardEdge,
                    child: Column(children: [
                      listTile(
                        subtitle:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          const SizedBox(height: 6),
                          Row(children: [
                            Image.asset(
                              gst,
                              height: 20,
                              width: 20,
                            ),
                            Text(
                              modal.gstin?.toUpperCase() ?? '',
                              style: Theme.of(context).textTheme.subtitle2,
                            ),
                          ]),
                          Row(children: [
                            Image.asset(
                              calendar,
                              height: 24,
                              width: 24,
                            ),
                            Expanded(
                              child: Text(
                                modal.booksFrom?.toUpperCase() ?? '',
                                style: Theme.of(context).textTheme.subtitle2,
                              ),
                            ),
                            DropdownButtonHideUnderline(
                              child: DropdownButton<
                                  QueryDocumentSnapshot<CompanyModal>>(
                                value: document,
                                borderRadius: BorderRadius.circular(6),
                                onChanged: (newValue) {
                                  if (newValue != null) {
                                    setState(() => document = newValue);
                                    debugPrint('newValue ${newValue.id}');
                                  }
                                },
                                items: docs.map((value) {
                                  return DropdownMenuItem<
                                      QueryDocumentSnapshot<CompanyModal>>(
                                    value: value,
                                    child: Text(
                                      value.id,
                                      style:
                                          Theme.of(context).textTheme.subtitle2,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ]),
                        ]),
                      ),
                      CompanyButton(document!),
                    ]),
                  );
                });
        }

        return Shimmer.fromColors(
          baseColor: Colors.grey,
          highlightColor: Colors.blue,
          child: listTile(
              subtitle: const SizedBox(
            width: double.infinity,
            height: 100,
          )),
        );
      },
    );
  }
}
