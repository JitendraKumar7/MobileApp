import 'package:flutter/material.dart';
import 'package:tally/widget/widget.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  static Route page() {
    return MaterialPageRoute(builder: (_) => const ProfilePage());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const Toolbar('PROFILE'),
      body: ListView(padding: const EdgeInsets.all(12), children: <Widget>[
        const ProfileWidget(),
        Container(
          padding: const EdgeInsets.all(12),
          alignment: Alignment.center,
          child: const Text(
            'JITENDRA KUMAR',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),

        //Address
        const CardView('address', children: [
          RowView(title: 'Address', value: 'Ghaziabad'),
          RowView(title: 'State', value: 'Uttar Pradesh'),
          RowView(title: 'Country', value: 'India'),
          RowView(title: 'PIN Code', value: '201015'),
        ]),
      ]),
    );
  }
}
