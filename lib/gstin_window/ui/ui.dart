import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../modal/company/search_company.dart';
import '../modal/gst/search_gst.dart';
import '../modal/report/gst_report.dart';

// https://api.fidypay.com/pg/

Future<Map<String, dynamic>> setting(String path) async {
  final instance = FirebaseRemoteConfig.instance;

  /*await instance.setConfigSettings(RemoteConfigSettings(
    minimumFetchInterval: Duration.zero,
    fetchTimeout: Duration.zero,
  ));*/

  await instance.fetchAndActivate();

  var url = Uri.parse('${instance.getString('FidPayUrl')}$path');
  var json = jsonDecode(instance.getString('FidPayHeaders'));

  Map<String, String> headers = {};
  json.forEach((k, v) => headers['$k'] = '$v');
  var response = await http.post(url, headers: headers);

  //debugPrint('Response url: $url');
  //debugPrint('Response headers: $headers');

  //debugPrint('Response body: ${response.body}');
  return response.statusCode == 200 ? jsonDecode(response.body) : {};
}

class GstinWindow extends StatelessWidget {
  const GstinWindow({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: TabBar(
          tabs: [
            Tab(text: 'GSTIN NUMBER'),
            Tab(text: 'BUSINESS NAME'),
            Tab(text: 'FILING REPORTS'),
          ],
          isScrollable: true,
          labelColor: Colors.blue,
          unselectedLabelColor: Colors.grey,
        ),
        body: TabBarView(children: [
          SearchGstNumber(),
          SearchBusinessName(),
          SearchFilingReport(),
        ]),
      ),
    );
  }
}

class SearchGstNumber extends StatefulWidget {
  const SearchGstNumber({Key? key}) : super(key: key);

  @override
  State<SearchGstNumber> createState() => _SearchGstNumberState();
}

class _SearchGstNumberState extends State<SearchGstNumber> {
  final controller = TextEditingController();
  var modal = SearchGst();

  Future<void> onFieldSubmitted() async {
    String url = 'gstSearch/${controller.text}';

    // fetch data from server
    modal = SearchGst.fromJson(await setting(url));
    debugPrint('Search GST => ${modal.toJson()}');
    setState(() => false);
  }

  @override
  void initState() {
    super.initState();
    controller.text = '09AAHCM0525A1ZZ';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(12), children: [
      TextFormField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => onFieldSubmitted,
        decoration: InputDecoration(
          hintText: 'Company GST',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onFieldSubmitted,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
        ),
      ),
      if (modal.isNotEmpty) ...[
        const SizedBox(height: 12),
        Text(
          'Legal name of business',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            letterSpacing: 1,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 6,
            top: 3,
          ),
          child: Text(modal.result.gstnDetailed.legalNameOfBusiness ?? ''),
        ),
        const Divider(),
        Text(
          'Nature of business',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            letterSpacing: 1,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 6,
            top: 3,
          ),
          child: Text(
              modal.result.gstnDetailed.natureOfBusinessActivities.join('\n')),
        ),
        const Divider(),
        Text(
          'Registration date',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            letterSpacing: 1,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 6,
            top: 3,
          ),
          child: Text(modal.result.gstnDetailed.registrationDate ?? ''),
        ),
        const Divider(),
        Text(
          'Principal place address',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            letterSpacing: 1,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 6,
            top: 3,
          ),
          child: Text(modal.result.gstnDetailed.principalPlaceAddress ?? ''),
        ),
        const Divider(),
        Text(
          'Tax payer type',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            letterSpacing: 1,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 6,
            top: 3,
          ),
          child: Text(modal.result.gstnDetailed.taxPayerType ?? ''),
        ),
        const Divider(),
        Text(
          'GSTIN status',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.green[900],
            letterSpacing: 1,
            fontSize: 12,
          ),
        ),
        Container(
          padding: const EdgeInsets.only(
            bottom: 6,
            top: 3,
          ),
          child: Text(modal.result.gstnDetailed.gstinStatus ?? ''),
        ),
        const Divider(),
      ],
    ]);
  }
}

class SearchBusinessName extends StatefulWidget {
  const SearchBusinessName({Key? key}) : super(key: key);

  @override
  State<SearchBusinessName> createState() => _SearchBusinessNameState();
}

class _SearchBusinessNameState extends State<SearchBusinessName> {
  final controller = TextEditingController();
  var modal = SearchCompany();

  Future<void> onFieldSubmitted() async {
    String url = 'gstSearchCompanyName/${controller.text}';

    // fetch data from server
    modal = SearchCompany.fromJson(await setting(url));
    debugPrint('Search Company => ${modal.toJson()}');
    setState(() => false);
  }

  @override
  void initState() {
    super.initState();
    controller.text = 'MRK TRADEX PRIVATE LIMITED';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(12), children: [
      TextFormField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => onFieldSubmitted,
        decoration: InputDecoration(
          hintText: 'Company Name',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onFieldSubmitted,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
        ),
      ),
      if (modal.isNotEmpty) ...[
        Container(
          padding: const EdgeInsets.only(
            bottom: 9,
            top: 18,
          ),
          child: Text(modal.essentials.companyName ?? ''),
        ),
        const Divider(),
        for (var i = 0; i < modal.result.gstDetails.length; i++)
          Container(
            padding: const EdgeInsets.only(
              bottom: 6,
              top: 6,
            ),
            child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('${modal.result.gstDetails[i].state}'),
                  Text('${modal.result.gstDetails[i].gstin}'),
                ]),
          ),
      ],
    ]);
  }
}

class SearchFilingReport extends StatefulWidget {
  const SearchFilingReport({Key? key}) : super(key: key);

  @override
  State<SearchFilingReport> createState() => _SearchFilingReportState();
}

class _SearchFilingReportState extends State<SearchFilingReport> {
  final controller = TextEditingController();
  var modal = FilingReport();

  Future<void> onFieldSubmitted() async {
    String url = 'gstDetailsSearch/${controller.text}';

    // fetch data from server
    modal = FilingReport.fromJson(await setting(url));
    debugPrint('Filing Report => ${modal.toJson()}');
    setState(() => false);
  }

  @override
  void initState() {
    super.initState();
    controller.text = '09AAHCM0525A1ZZ';
  }

  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(12), children: [
      TextFormField(
        controller: controller,
        textInputAction: TextInputAction.search,
        onFieldSubmitted: (value) => onFieldSubmitted,
        decoration: InputDecoration(
          hintText: 'GSTIN Number',
          suffixIcon: IconButton(
            icon: const Icon(Icons.search),
            onPressed: onFieldSubmitted,
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(9)),
        ),
      ),
      const SizedBox(height: 9),
      DropdownButtonFormField<String>(
        borderRadius: BorderRadius.circular(9),
        items: <String>[
          '2018-2019',
          '2019-2020',
          '2020-2021',
          '2021-2022',
        ].map((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (_) {},
      )
    ]);
  }
}
