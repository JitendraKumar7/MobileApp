import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

import '../../../../services/services.dart';

class IconShape extends StatelessWidget {
  final IconData? icon;

  const IconShape(this.icon, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 6,
        right: 6,
      ),
      padding: const EdgeInsets.all(5),
      clipBehavior: Clip.hardEdge,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.white,
      ),
      child: Icon(
        icon,
        color: Colors.red[900],
        size: 15,
      ),
    );
  }
}

class ShareCardPage extends StatelessWidget {
  final DocumentReference reference;

  static Route page(DocumentReference reference) {
    return MaterialPageRoute(builder: (_) => ShareCardPage(reference));
  }

  const ShareCardPage(this.reference, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    const style = TextStyle(color: Colors.white, fontSize: 12);
    final controller = ScreenshotController();
    final size = MediaQuery.of(context).size;
    bool takeScreenshot = false;

    return Scaffold(
      appBar: const Toolbar('BUSINESS CARD'),
      backgroundColor: Colors.white,
      body: FutureBuilder(
          future: db.getCompanyQuery(reference.parent),
          builder: (_, AsyncSnapshot<DocumentSnapshot<CompanyModal>> snapshot) {
            if (snapshot.hasData) {
              final modal = snapshot.data?.data();

              return Column(children: [
                Screenshot(
                  controller: controller,
                  child: Container(
                    //padding: const EdgeInsets.fromLTRB(18, 24, 18, 36),
                    height: size.width / 1.8,
                    width: size.width,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: ExactAssetImage(cardBack),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.blue,
                    ),
                    child: Row(children: [
                      Expanded(
                        flex: 3,
                        child: Center(
                          child: Container(
                            margin: const EdgeInsets.only(left: 9, right: 9),
                            clipBehavior: Clip.hardEdge,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(3),
                              color: Colors.grey[100],
                            ),
                            child: modal?.logo != null
                                ? Image.network('${modal?.logo}', height: 60)
                                : Image.asset(logo, height: 60),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                            //mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Container(
                                alignment: Alignment.center,
                                margin: const EdgeInsets.only(
                                  bottom: 9,
                                  top: 9,
                                ),
                                child: Text(
                                  '${modal?.getName}',
                                  overflow: TextOverflow.ellipsis,
                                  style: style.copyWith(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 16,
                                  ),
                                  maxLines: 2,
                                ),
                              ),
                              const Expanded(child: SizedBox.shrink()),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const IconShape(Icons.call),
                                    Expanded(
                                      child: Text(
                                        modal?.mobile ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: style,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ]),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const IconShape(Icons.email),
                                    Expanded(
                                      child: Text(
                                        modal?.email ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: style,
                                        maxLines: 2,
                                      ),
                                    ),
                                  ]),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const IconShape(Icons.business),
                                    Expanded(
                                      child: Text(
                                        modal?.gstin ?? '',
                                        overflow: TextOverflow.ellipsis,
                                        style: style,
                                        maxLines: 1,
                                      ),
                                    ),
                                  ]),
                              Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    const IconShape(Icons.location_on),
                                    Expanded(
                                      child: Text(
                                        '${modal?.getAddress}',
                                        overflow: TextOverflow.ellipsis,
                                        style: style,
                                        maxLines: 3,
                                      ),
                                    ),
                                  ]),
                              const SizedBox(height: 9),
                            ]),
                      ),
                    ]),
                  ),
                ),
                const Expanded(child: SizedBox.shrink()),
                StatefulBuilder(builder: (_, setState) {
                  return ElevatedButton.icon(
                    onPressed: takeScreenshot
                        ? null
                        : () async {
                            await Permission.storage.request();
                            setState(() => takeScreenshot = true);
                            final directory =
                                (await getTemporaryDirectory()).path;
                            final imagePath = await controller.captureAndSave(
                              '$directory/screenshot',
                              fileName: 'card.png',
                            );
                            if (imagePath != null) {
                              await Share.shareFiles(
                                [imagePath],
                                subject: 'BUSINESS CARD',
                                text:
                                    'Start managing your business by managing tally on mobile app.'
                                    '\n\n Click: tallykonnect.com',
                              );
                            }
                            setState(() => takeScreenshot = false);
                          },
                    icon: takeScreenshot
                        ? const CupertinoActivityIndicator()
                        : const Icon(Icons.share),
                    label: takeScreenshot
                        ? const Text('Loading...')
                        : const Text('SHARE CARD'),
                  );
                })
              ]);
            }
            return const LoaderPage();
          }),
    );
  }
}
