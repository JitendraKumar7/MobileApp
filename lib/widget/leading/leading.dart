import 'package:flutter/material.dart';

class Leading extends StatelessWidget {
  final String name;

  const Leading(
    this.name, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      padding: const EdgeInsets.all(3),
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        border: Border.all(
          color: Colors.indigo,
          width: 0.5,
        ),
      ),
      child: Image.asset(name),
    );
  }
}
