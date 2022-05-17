import 'package:flutter/material.dart';

class RowView extends StatelessWidget {
  final Widget? button;
  final String? value;
  final String title;

  const RowView({
    Key? key,
    this.value,
    this.button,
    required this.title,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) =>
      Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
        SizedBox(
          width: MediaQuery.of(context).size.width / 3.5,
          child: Text(
            title.toUpperCase(),
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
        ),
        Expanded(child: Text(value ?? '')),
        if (button != null) button!,
      ]);
}

class CardView extends StatelessWidget {
  final List<Widget> children;
  final String title;

  const CardView(
    this.title, {
    Key? key,
    this.children = const <Widget>[],
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(9),
        ),
        clipBehavior: Clip.hardEdge,
        color: Colors.blue[300],
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Container(
            padding: const EdgeInsets.all(12),
            width: double.infinity,
            child: Text(
              title.toUpperCase(),
              style: const TextStyle(color: Colors.white),
            ),
          ),
          Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              bottom: 9,
              right: 1,
              left: 1,
            ),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(3),
              color: Colors.white,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: children
                  .map((child) => Container(
                        padding: const EdgeInsets.only(
                          bottom: 9,
                          right: 12,
                          left: 12,
                          top: 9,
                        ),
                        child: child,
                      ))
                  .toList(),
            ),
          ),
        ]),
      );
}
