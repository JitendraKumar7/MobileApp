import 'package:flutter/material.dart';
import 'package:tally/widget/toolbar/toolbar.dart';

class WebViewPage extends StatefulWidget {
  const WebViewPage(
    this.title, {
    Key? key,
  }) : super(key: key);

  final String title;

  static Route page(title) {
    return MaterialPageRoute(builder: (_) => WebViewPage(title));
  }

  @override
  State<WebViewPage> createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    //var args = ModalRoute.of(context)?.settings.arguments;
    //https://tallykonnect.com/

    return Scaffold(appBar: Toolbar(widget.title));
  }
}
