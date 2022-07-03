import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class EditCompanyPage extends StatelessWidget {
  const EditCompanyPage(this.reference, this.modal, {Key? key})
      : super(key: key);

  static Route page(DocumentReference reference, CompanyModal modal) {
    return MaterialPageRoute(builder: (_) => EditCompanyPage(reference, modal));
  }

  final DocumentReference reference;
  final CompanyModal modal;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Toolbar('BUSINESS CARD'),
      body: Column(children: [
        Expanded(
          child: ListView(padding: const EdgeInsets.all(18), children: [
            ImageWidget(
              capture: (url) => modal.logo = url,
              url: modal.logo ?? '',
              ref: 'logo',
              id: '${modal.key}',
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Company Name',
                helperText: '',
              ),
              onChanged: (value) => modal.selectedCompany = value,
              controller: TextEditingController(text: modal.selectedCompany),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Mobile no',
                helperText: '',
              ),
              onChanged: (value) => modal.mobile = value,
              controller: TextEditingController(text: modal.mobile),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Email Id',
                helperText: '',
              ),
              onChanged: (value) => modal.email = value,
              controller: TextEditingController(text: modal.email),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Address',
                helperText: '',
              ),
              minLines: 2,
              maxLines: 5,
              onChanged: (value) => modal.address = value,
              controller: TextEditingController(text: modal.address),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'State Name',
                helperText: '',
              ),
              onChanged: (value) => modal.stateName = value,
              controller: TextEditingController(text: modal.stateName),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Country',
                helperText: '',
              ),
              onChanged: (value) => modal.countryName = value,
              controller: TextEditingController(text: modal.countryName),
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Zip Code',
                helperText: '',
              ),
              onChanged: (value) => modal.pinCode = value,
              controller: TextEditingController(text: modal.pinCode),
            ),
            Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              ImageWidget(
                capture: (url) async {
                  modal.signature = url;
                  //await reference.update({'$id.SIGNATURE': url});
                },
                id: '${modal.key}',
                ref: 'signature',
                url: modal.signature ?? '',
                shape: BoxShape.rectangle,
                height: 40,
                width: 120,
              ),
              const Text(
                'Add Digital Signature',
                style: TextStyle(fontSize: 12),
              ),
            ]),
          ]),
        ),
        ElevatedButton(
          onPressed: () {
            try {
              var data = modal.toJson();
              debugPrint('${reference.parent.parent?.path} ==> ${modal.key}');
              reference.parent.parent?.update({'${modal.key}': data});
            } catch (e) {
              debugPrint('Error $e');
            }
            Navigator.pop(context, true);
          },
          child: const Text('UPDATE PROFILE'),
        )
      ]),
    );
  }
}
