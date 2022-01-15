import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Toolbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const Toolbar(
    this.title, {
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => AppBar(
      leading: IconButton(
        icon: const Icon(Icons.arrow_back_ios),
        onPressed: () => Navigator.pop(context),
      ),
      title: Text(title),
    );

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
