import 'package:flutter/material.dart';
import 'package:tally/widget/toolbar/toolbar.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  static Route page() {
    return MaterialPageRoute(builder: (_) => const AboutPage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Toolbar('About Us'),
      body: Container(
        padding: const EdgeInsets.all(18),
        child: RichText(
          text: const TextSpan(
              style: TextStyle(
                color: Colors.black,
                letterSpacing: 3,
                fontSize: 18,
              ),
              children: [
                TextSpan(
                    text:
                        'MANAGE YOUR BUSINESS  BY MANAGING YOUR  TALLY  ON MOBILE PHONE'),
                TextSpan(
                    text:
                        '\n\nTALLY IS  THE MOST  COMMON  ERP USED IN BUSINESS IN INDIA.\n\nANY BODY USING TALLY CAN  DOWNLOAD THIS APP AND START VIEWING  HIS COMPANY  FINANCIAL DATA ON MOBILE PHONE.'),
                /*TextSpan(
                text: '\n\nHOW TO DO IT', style: TextStyle(color: Colors.blue)),
            TextSpan(text: '\n\nSTEP 1 - ', children: [
              TextSpan(text: 'GO TO WWW.TALLYKONNECT.COM'),
            ]),
            TextSpan(text: '\n\nSTEP 2 - ', children: [
              TextSpan(text: 'DOWNLOAD  SETUP FOR WINDOWS DESKTOP'),
            ]),
            TextSpan(text: '\n\nSTEP 3 - ', children: [
              TextSpan(text: 'CREATE ACCOUNT BY SIGNUP'),
            ]),
            TextSpan(text: '\n\nSTEP 4 - ', children: [
              TextSpan(
                  text:
                      'SIGN IN , SLECT OPTION -  TALLY MOBILE APP IN DESKTOP UTILITY'),
            ]),
            TextSpan(text: '\n\nSTEP 5 - ', children: [
              TextSpan(text: 'OPEN TALLY  AND KEEP RUNING IT IN BACKGROUND'),
            ]),
            TextSpan(text: '\n\nSTEP 6 - ', children: [
              TextSpan(
                  text:
                      'SELECT ANY OR  MULTIPLE TALLY COMPANY  TO ADD IN UTILITY.'),
            ]),
            TextSpan(text: '\n\nSTEP 7 - ', children: [
              TextSpan(text: 'ADD COMPANY FROM TALLY TO DESKTOP UTILITY'),
            ]),
            TextSpan(text: '\n\nSTEP 8 - ', children: [
              TextSpan(text: 'LOGIN IN THE MOBILE APP WITH SAME USER ID'),
            ]),
            TextSpan(text: '\n\nSTEP 9 - ', children: [
              TextSpan(text: 'VIEW & SELECT  COMPANY IN MOBILE PHONE'),
            ]),*/
              ]),
        ),
      ),
    );
  }
}
