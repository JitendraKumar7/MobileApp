import 'package:flutter/material.dart';
import 'package:tally/widget/widget.dart';
import 'package:tally/constant/constant.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigatePage extends StatelessWidget {
  final int index;

  const NavigatePage(this.index, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      unselectedItemColor: Colors.grey,
      selectedItemColor: Colors.blue,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            reportStatement,
            height: 24,
          ),
          label: 'ACCOUNT STATEMENT',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            reportStatement,
            height: 24,
          ),
          label: 'OUTSTANDING',
        ),
      ],
      currentIndex: index,
      onTap: (index) {
        var obj = context.read<NavigateCubit>();
        obj.change(index);
      },
    );
  }
}
