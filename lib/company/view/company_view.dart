import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/company/company.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';

class Company extends StatelessWidget {
  final DocumentSnapshot<Map<String, dynamic>> data;

  const Company(this.data, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChannels.lifecycle.setMessageHandler((msg) async {
      debugPrint('SystemChannels > $msg');
      return msg;
    });

    var size = MediaQuery.of(context).size;
    var style = TextButton.styleFrom(
      minimumSize: Size(size.width / 3.5, 36),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(18),
        side: const BorderSide(width: 0.6),
      ),
    );
    List<CompanyModal> list = [];
    try {
      var values = data.data();
      values?.forEach((key, value) {
        list.add(CompanyModal.fromJson(value, key));
        debugPrint('companyName $key');
      });
    } catch (ex) {
      debugPrint('$ex');
    }
    return ListView(
      children: list.map<Widget>((company) {
        return StreamBuilder(
          stream: db.getCompanyDoc(data.reference, company.key!),
          builder: (_, AsyncSnapshot<QuerySnapshot> snapshot) {
            var docs = snapshot.data?.docs ?? [];
            if (docs.isEmpty) {
              return Shimmer.fromColors(
                baseColor: Colors.grey,
                highlightColor: Colors.blue,
                child: Container(
                  height: 124,
                  padding: const EdgeInsets.all(30),
                  alignment: Alignment.centerLeft,
                  child: Text(
                    company.getName,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
            }
            // show company
            else {
              var reference = docs.first.reference;
              return Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(6),
                ),
                clipBehavior: Clip.hardEdge,
                child: Column(children: [
                  ListTile(
                    title: Text(
                      company.getName,
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
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: company.logo == null
                          ? Image.asset(logo)
                          : Image.network(
                              company.logo!,
                              fit: BoxFit.fill,
                            ),
                    ),
                  ),
                  Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        TextButton(
                          style: style,
                          onPressed: () {
                            var page = MasterView.page(reference);
                            Navigator.push(context, page);
                          },
                          child: const Text('MASTERS'),
                        ),
                        TextButton(
                          style: style,
                          onPressed: () {
                            var page = ReportsView.page(reference);
                            Navigator.push(context, page);
                          },
                          child: const Text('REPORTS'),
                        ),
                        TextButton(
                          style: style,
                          onPressed: () {
                            var page = AddonView.page(reference);
                            Navigator.push(context, page);
                          },
                          child: const Text('ADDONS'),
                        ),
                      ]),
                ]),
              );
            }
          },
        );
      }).toList(),
    );
  }
}
