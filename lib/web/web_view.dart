import 'package:flutter/material.dart';
import 'package:easy_web_view/easy_web_view.dart';
import 'package:tally/widget/toolbar/toolbar.dart';

class WebViewPage extends StatelessWidget {
  const WebViewPage(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  static Route page(title) {
    return MaterialPageRoute(builder: (_) => WebViewPage(title));
  }

  @override
  Widget build(BuildContext context) {
    //var args = ModalRoute.of(context)?.settings.arguments;
    return Scaffold(
      appBar: Toolbar(title),
      body: EasyWebView(
        src: 'https://tallykonnect.com/',
        onLoaded: () {},
        isHtml: false,
        isMarkdown: false,
        convertToWidgets: false,
      ),
    );
  }
}
