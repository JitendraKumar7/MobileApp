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
  Widget build(BuildContext context) {
    names.sort();
    return ListView(
      children: names
          .map<Widget>((name) => StreamBuilder(
                stream: db.getCompanyDoc(reference, name),
                builder: (_, AsyncSnapshot snapshot) {
                  return builder(name, snapshot.data);
                },
              ))
          .toList(),
    );
  }

  Widget builder(String name, QuerySnapshot<CompanyModal>? snapshot) {
    var docs = snapshot?.docs ?? [];
    if (docs.isEmpty) {
      return Shimmer.fromColors(
        baseColor: Colors.grey,
        highlightColor: Colors.blue,
        child: Container(
          height: 124,
          padding: const EdgeInsets.all(30),
          alignment: Alignment.centerLeft,
          child: Text(
            name.toUpperCase(),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      );
    }
    // show company
    else {
      QueryDocumentSnapshot<CompanyModal> document = docs.first;
      return StatefulBuilder(builder: (BuildContext context, setState) {
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
                child: modal.logo == null
                    ? Image.asset(logo)
                    : Image.network(
                        modal.logo!,
                        fit: BoxFit.fill,
                      ),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  shape: BoxShape.circle,
                ),
              ),
              subtitle: DropdownButtonFormField(
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
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              TextButton(
                style: style,
                onPressed: () {
                  var page = MasterView.page(document);
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
}
