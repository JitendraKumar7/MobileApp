import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share/share.dart';
import 'package:tally/modal/modal.dart';
import 'package:tally/widget/widget.dart';

class CardPage extends StatelessWidget {
  CardPage(this.modal, {Key? key}) : super(key: key);

  final CompanyModal modal;
  final controller = ScreenshotController();

  static Route page(CompanyModal modal) {
    return MaterialPageRoute(builder: (_) => CardPage(modal));
  }

  Future<bool> onPressed() async {
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

  @override
  Widget build(BuildContext context) {
    bool takeScreenshot = false;

    var style = const TextStyle(
      fontSize: 15,
      color: Colors.black,
    );
    return Scaffold(
      appBar: const Toolbar('BUSINESS CARD'),
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        Screenshot(
          controller: controller,
          child: Container(
            padding: const EdgeInsets.all(38),
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: ExactAssetImage('assets/card_back.jpg'),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(children: [
              Text(
                modal.name ?? '',
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 24),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  width: 36,
                  child: Icon(
                    Icons.email,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  modal.email ?? '',
                  style: style,
                ),
              ]),
              const SizedBox(height: 15),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  width: 36,
                  child: Icon(
                    Icons.business,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  modal.gstin ?? '',
                  style: style,
                ),
              ]),
              const SizedBox(height: 15),
              Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                const SizedBox(
                  width: 36,
                  child: Icon(
                    Icons.location_on,
                    color: Colors.blue,
                  ),
                ),
                Text(
                  modal.getAddress,
                  style: style,
                ),
              ]),
            ]),
          ),
        ),
        const SizedBox(height: 24),
        StatefulBuilder(
            builder: (context, setState) => TextButton.icon(
                  onPressed: takeScreenshot
                      ? null
                      : () async {
                          setState(() => takeScreenshot = true);
                          await onPressed();
                          setState(() => takeScreenshot = false);
                        },
                  icon: takeScreenshot
                      ? const CupertinoActivityIndicator()
                      : const Icon(Icons.screen_share),
                  label: takeScreenshot
                      ? const Text('Loading...')
                      : const Text('Share'),
                ))
      ]),
    );
  }
}
