import 'package:flutter/material.dart';

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
