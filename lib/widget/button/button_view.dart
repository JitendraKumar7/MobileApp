import 'package:flutter/material.dart';

import '../widget.dart';

class ButtonView extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color? color;
  final String label;
  final String name;

  const ButtonView({
    Key? key,
    this.onTap,
    this.color,
    required this.name,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: color,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Image.asset(
                    name,
                    width: 60,
                    height: 60,
                  ),
                  Text(
                    label.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class TextButtonView extends StatelessWidget {
  final GestureTapCallback? onTap;
  final Color? color;
  final String label;

  const TextButtonView({
    Key? key,
    this.onTap,
    this.color,
    required this.label,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        clipBehavior: Clip.hardEdge,
        child: InkWell(
          onTap: onTap,
          child: Container(
            color: color,
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    label.toUpperCase(),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      fontSize: 15,
                      color: Colors.indigo,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ]),
          ),
        ),
      ),
    );
  }
}

class MonthGridView extends StatelessWidget {
  final GestureTapCallback? september;
  final GestureTapCallback? november;
  final GestureTapCallback? december;
  final GestureTapCallback? february;
  final GestureTapCallback? january;
  final GestureTapCallback? october;
  final GestureTapCallback? august;
  final GestureTapCallback? march;
  final GestureTapCallback? april;
  final GestureTapCallback? june;
  final GestureTapCallback? july;
  final GestureTapCallback? may;

  final String label;
  final String name;

  const MonthGridView(
    this.label,
    this.name, {
    Key? key,
    this.may,
    this.june,
    this.july,
    this.april,
    this.march,
    this.august,
    this.october,
    this.january,
    this.november,
    this.december,
    this.february,
    this.september,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(children: [
        Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.all(18),
          child: ListTitle(name),
        ),
        Expanded(
          child: Row(
            children: [
              TextButtonView(onTap: april, label: 'APRIL'),
              TextButtonView(onTap: may, label: 'MAY'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              TextButtonView(onTap: june, label: 'JUNE'),
              TextButtonView(onTap: july, label: 'JULY'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              TextButtonView(onTap: august, label: 'AUGUST'),
              TextButtonView(onTap: september, label: 'SEPTEMBER'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              TextButtonView(onTap: october, label: 'OCTOBER'),
              TextButtonView(onTap: november, label: 'NOVEMBER'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              TextButtonView(onTap: december, label: 'DECEMBER'),
              TextButtonView(onTap: january, label: 'JANUARY'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
        Expanded(
          child: Row(
            children: [
              TextButtonView(onTap: february, label: 'FEBRUARY'),
              TextButtonView(onTap: march, label: 'MARCH'),
            ],
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          ),
        ),
      ]),
      appBar: Toolbar(label),
    );
  }
}
