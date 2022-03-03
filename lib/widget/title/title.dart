import 'package:flutter/material.dart';

class ListTitle extends StatelessWidget {
  final String title;

  const ListTitle(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      title.toUpperCase(),
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      style: const TextStyle(
        fontWeight: FontWeight.bold,
        fontSize: 13,
      ),
    );
  }
}

class ListSubTitle extends StatelessWidget {
  final String title;
  final String date;

  const ListSubTitle(
    this.title,
    this.date, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(
            child: Text(
              title,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(fontSize: 11),
            ),
          ),
          Text(
            date,
            style: const TextStyle(fontSize: 11),
          ),
        ],
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
      );
}
