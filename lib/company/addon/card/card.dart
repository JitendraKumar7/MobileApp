import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

//size of 1,048,576 bytes
class BusinessCardPage extends StatefulWidget {
  const BusinessCardPage(this.document, {Key? key}) : super(key: key);

  final QueryDocumentSnapshot<CompanyModal> document;

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => BusinessCardPage(document));
  }

  @override
  State<BusinessCardPage> createState() => _BusinessCardState();
}

class _BusinessCardState extends State<BusinessCardPage> {
  final controller = ScreenshotController();

  Future<bool> onShare() async {
    final directory = (await getTemporaryDirectory()).path;
    final imagePath = await controller.captureAndSave(
      '$directory/screenshot',
      fileName: 'card.png',
    );
    if (imagePath != null) {
      await Share.shareFiles(
        [imagePath],
        subject: 'BUSINESS CARD',
        text: 'Hy download the tally mobile app',
      );
    }
    return true;
  }

  Future<bool> onSave() async {
    var page = EditBusinessCardPage.page(widget.document);
    var result = await Navigator.push(context, page);

    if (result != null) {
      modal = result;
      try {
        debugPrint('Edit Card wait');
        await reference.update(modal.toJson());
        debugPrint('Edit Card done');
      } catch (e) {
        debugPrint('Error $e');
      }
    }
    return true;
  }

  var style = const TextStyle(
    color: Colors.black,
    fontSize: 15,
  );
  late DocumentReference reference;
  late CompanyModal modal;

  bool takeScreenshot = false;
  bool uploading = false;

  @override
  void initState() {
    super.initState();
    modal = widget.document.data();
    reference = widget.document.reference;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Toolbar('BUSINESS CARD'),
      body: Column(children: [
        Screenshot(
          controller: controller,
          child: Container(
            padding: const EdgeInsets.fromLTRB(18, 24, 18, 36),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage(cardBack),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: [
              Row(children: [
                Container(
                  margin: const EdgeInsets.only(left: 9, right: 9),
                  clipBehavior: Clip.hardEdge,
                  child: modal.logo != null
                      ? Image.network(
                          modal.logo ?? '',
                          height: 45,
                          width: 60,
                          fit: BoxFit.fill,
                        )
                      : null,
                  decoration: BoxDecoration(
                    color: Colors.grey[100],
                    borderRadius: BorderRadius.circular(6),
                  ),
                ),
                Expanded(
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          modal.getName,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          modal.mobile ?? '',
                          maxLines: 1,
                          style: style.copyWith(
                            fontSize: 15,
                            fontWeight: FontWeight.bold,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ]),
                ),
              ]),
              const SizedBox(height: 18),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  width: 36,
                  child: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Text(
                    modal.email ?? '',
                    maxLines: 2,
                    style: style,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  width: 36,
                  child: Icon(
                    Icons.business,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Text(
                    modal.gstin ?? '',
                    maxLines: 1,
                    style: style,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
              const SizedBox(height: 12),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  width: 36,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                ),
                Expanded(
                  child: Text(
                    modal.getAddress,
                    maxLines: 3,
                    style: style,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ]),
            ]),
          ),
        ),
        Expanded(
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            ImageWidget(
              capture: (url) async {
                modal.signature = url;
                await reference.update({'SIGNATURE': url});
              },
              url: modal.signature ?? '',
              ref: 'signature',
              id: widget.document.id,
              shape: BoxShape.rectangle,
              width: 220,
            ),
            const Text('Update Signature'),
          ]),
        ),
        StatefulBuilder(builder: builder)
      ]),
    );
  }

  Widget builder(context, setState1) {
    return Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
      TextButton.icon(
        onPressed: uploading
            ? null
            : () async {
                setState1(() => uploading = true);
                await onSave();
                setState(() => uploading = false);
              },
        icon: uploading
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.edit),
        label: uploading ? const Text('Uploading...') : const Text('EDIT CARD'),
      ),
      TextButton.icon(
        onPressed: takeScreenshot
            ? null
            : () async {
                setState1(() => takeScreenshot = true);
                await onShare();
                setState(() => takeScreenshot = false);
              },
        icon: takeScreenshot
            ? const CupertinoActivityIndicator()
            : const Icon(Icons.share),
        label: takeScreenshot
            ? const Text('Loading...')
            : const Text('SHARE CARD'),
      ),
    ]);
  }
}

class EditBusinessCardPage extends StatelessWidget {
  const EditBusinessCardPage(this.document, {Key? key}) : super(key: key);

  final QueryDocumentSnapshot<CompanyModal> document;

  static Route page(QueryDocumentSnapshot<CompanyModal> document) {
    return MaterialPageRoute(builder: (_) => EditBusinessCardPage(document));
  }

  @override
  Widget build(BuildContext context) {
    var modal = document.data();
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
              id: document.id,
            ),
            const SizedBox(height: 24),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Company Name',
                helperText: '',
              ),
              onChanged: (value) => modal.name = value,
              controller: TextEditingController(text: modal.name),
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
          ]),
        ),
        ElevatedButton(
          onPressed: () => Navigator.pop(context, modal),
          child: const Text('SAVE'),
        )
      ]),
    );
  }
}
