import 'package:flutter/material.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';
import 'package:tally/widget/toolbar/toolbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  static Route page() {
    return MaterialPageRoute(builder: (_) => const AboutPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Toolbar('About Us'),
      body: ListView(padding: const EdgeInsets.all(18), children: [
        HtmlWidget('<p>This app get Tally desktop data on to your phone. This is the fastest tallyconnector of the world.</p><p>It easily syncs data and gives realtime reports on any mobile device.</p><p>The data is fully encrypted and stored in google firebase with full access to customer.</p><p><strong>REAL TIME UPDATE</strong></p><p>Get realtime update of SALES, PURCHASE, RECEIPTS, PAYMENTS, MASTERS, LEDGERS, ACCOUNT STATEMENTS, bank book and cash book.</p><p><strong>SHARE ON WHATSAPP</strong></p><p>All reports are in pdf format and shareable with customers and suppliers on whatsapp.</p><p><strong>ABOUT SUBSCRIPTIONS AND OTHER QUERIES</strong></p><ol><li>This app is for TALLY users and free for use</li><li>Users can create a free account at tallykonnect.com</li><li>The app runs with a desktop utility which must be installed in the users windows system to use this app.&nbsp;</li><li>There is no paid subscriptions model in app or outside app to run this app.</li><li>User must have a valid com user account to open and run this app.</li></ol>',
          textStyle: const TextStyle(
            fontWeight: FontWeight.w400,
            fontFamily: 'sans-serif',
            fontSize: 18,
          ),
        ),
      ]),
    );
  }
}
