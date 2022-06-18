import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final List<Widget>? actions;
  final String title;

  const Toolbar(
    this.title, {
    Key? key,
    this.actions,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 15),
        ),
        actions: actions,
      );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
