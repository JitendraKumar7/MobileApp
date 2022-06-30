import 'package:flutter/material.dart';

class EmptyView extends StatelessWidget {
  const EmptyView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Image.asset(
      'assets/empty.jpeg',
      fit: BoxFit.cover,
      width: size.width,
      height: size.height,
    );
  }
}
