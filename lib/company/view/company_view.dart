import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/company/company.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/services/services.dart';

class Company extends StatelessWidget {
  final DocumentReference reference;
  final List<String> names;

  const Company(
    this.reference, {
    Key? key,
    required this.names,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ListView(
        children: names
            .map<Widget>((name) => StreamBuilder(
                  stream: db.getCompanyDoc(reference, name),
                  builder:
                      (_, AsyncSnapshot<QuerySnapshot<CompanyModal>> snapshot) {
                    if (snapshot.hasData) {
                      var docs = snapshot.data?.docs ?? [];
                      if (docs.isNotEmpty) {
                        return companyRow(docs);
                      }
                    }
                    return Shimmer.fromColors(
                      baseColor: Colors.grey,
                      highlightColor: Colors.blue,
                      child: ListTile(
                        title: Text(
                          name.toUpperCase(),
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
                        subtitle: const SizedBox(
                          width: double.infinity,
                          height: 124,
                        ),
                      ),
                    );
                  },
                ))
            .toList(),
      );

  Widget companyRow(List<QueryDocumentSnapshot<CompanyModal>> docs) {
    QueryDocumentSnapshot<CompanyModal> document = docs.first;
    return StatefulBuilder(builder: (BuildContext context, setState) {
      debugPrint('document ${document.id}');
      var size = MediaQuery.of(context).size;
      var style = TextButton.styleFrom(
        minimumSize: Size(size.width / 3.5, 36),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(18),
          side: const BorderSide(width: 0.6),
        ),
      );
      var modal = document.data();
      return Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(6)),
        clipBehavior: Clip.hardEdge,
        child: Column(children: [
          ListTile(
            title: Text(
              modal.getName,
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
              child: modal.companyLogo.isEmpty
                  ? Image.asset(logo)
                  : Image.memory(
                      Uint8List.fromList(modal.companyLogo),
                      fit: BoxFit.cover,
                      height: 48,
                      width: 48,
                    ),
              decoration: BoxDecoration(
                color: Colors.grey[100],
                shape: BoxShape.circle,
              ),
            ),
            subtitle: Column(mainAxisSize: MainAxisSize.min, children: [
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
                SizedBox(
                  width: 120,
                  child: DropdownButtonFormField(
                    value: document,
                    decoration: const InputDecoration(
                      border: OutlineInputBorder(
                        borderSide: BorderSide(
                          style: BorderStyle.none,
                          width: 0,
                        ),
                      ),
                    ),
                    onChanged: (QueryDocumentSnapshot<CompanyModal>? value) {
                      if (value != null) {
                        setState(() => document = value);
                      }
                    },
                    items: docs.map((value) {
                      return DropdownMenuItem(
                        value: value,
                        child: Text(
                          value.id,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: Theme.of(context).textTheme.subtitle2,
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ]),
            ]),
          ),
          Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
            TextButton(
              style: style,
              onPressed: () {
                var page = MasterView.page(document.reference);
                Navigator.push(context, page);
              },
              child: const Text('MASTERS'),
            ),
            TextButton(
              style: style,
              onPressed: () {
                var page = ReportsView.page(document);
                Navigator.push(context, page);
              },
              child: const Text('REPORTS'),
            ),
            TextButton(
              style: style,
              onPressed: () {
                var page = AddonView.page(document);
                Navigator.push(context, page);
              },
              child: const Text('ADDONS'),
            ),
          ]),
        ]),
      );
    });
  }
}
