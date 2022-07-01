import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:tally/company/company.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/services/services.dart';

import '../addon/business/business.dart';

class Company extends StatefulWidget {
  final DocumentSnapshot<Map<String, dynamic>> data;

  const Company(this.data, {Key? key}) : super(key: key);

  @override
  State<Company> createState() => _CompanyState();
}

class _CompanyState extends State<Company> {
  List<CompanyModal> list = [];

  @override
  void initState() {
    super.initState();
    try {
      var values = widget.data.data();
      values?.forEach((key, value) {
        list.add(CompanyModal.fromJson(value, key));
      });
    } catch (ex) {
      debugPrint('$ex');
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Column(children: [
      Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 48,
          vertical: 12,
        ),
        child: TextFormField(
          decoration: InputDecoration(
            hintText: 'Search Companies',
            suffixIcon: const Icon(Icons.search),
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(18)),
          ),
        ),
      ),
      Expanded(
        child: ListView(
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          children: list.map<Widget>((company) {
            return StreamBuilder(
              stream: db.getCompanyDoc(widget.data.reference, company.key!),
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
                  return Container(
                    height: size.width,
                    width: size.width,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 42,
                      vertical: 6,
                    ),
                    child: Card(
                      color: const Color(0xFFFEECEA),
                      elevation: 6,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(6),
                      ),
                      clipBehavior: Clip.hardEdge,
                      child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Container(
                              width: 48,
                              clipBehavior: Clip.hardEdge,
                              decoration: BoxDecoration(
                                color: Colors.grey[100],
                                //shape: BoxShape.circle,
                              ),
                              child: company.logo == null
                                  ? Image.asset(logo)
                                  : Image.network(
                                      company.logo!,
                                      fit: BoxFit.fill,
                                    ),
                            ),
                            Text(
                              company.getName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                color: Colors.blue[300],
                              ),
                              child: Text(
                                'FY | ${company.period}',
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                ),
                                maxLines: 1,
                              ),
                            ),
                            GridView(
                                shrinkWrap: true,
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 24,
                                  vertical: 6,
                                ),
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  childAspectRatio: 1.3,
                                  crossAxisSpacing: 6,
                                  mainAxisSpacing: 6,
                                  crossAxisCount: 2,
                                ),
                                children: [
                                  TextIconButton(
                                    onPressed: () {
                                      var page = MasterView.page(reference);
                                      Navigator.push(context, page);
                                    },
                                    asset: 'assets/new/master.png',
                                  ),
                                  TextIconButton(
                                    onPressed: () {
                                      var page = ReportsView.page(reference);
                                      Navigator.push(context, page);
                                    },
                                    asset: 'assets/new/reports.png',
                                  ),
                                  TextIconButton(
                                    onPressed: () {
                                      var page = AddonView.page(reference);
                                      Navigator.push(context, page);
                                    },
                                    asset: 'assets/new/addons.png',
                                  ),
                                  TextIconButton(
                                    onPressed: () {
                                      var page = EditCompanyPage.page(
                                        reference,
                                        company,
                                      );
                                      Navigator.push(context, page);
                                    },
                                    asset: 'assets/new/profile.png',
                                  ),
                                ])
                          ]),
                    ),
                  );
                }
              },
            );
          }).toList(),
        ),
      ),
    ]);
  }
}

class TextIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String asset;

  const TextIconButton({
    super.key,
    this.onPressed,
    required this.asset,
  });

  @override
  Widget build(BuildContext context) {
    var style = TextButton.styleFrom(
      backgroundColor: const Color(0xFFFEECEA),
      elevation: 4,
    );
    return ElevatedButton(
      style: style,
      onPressed: onPressed,
      child: Image.asset(
        asset,
        fit: BoxFit.fill,
        height: 56,
      ),
    );
  }
}
