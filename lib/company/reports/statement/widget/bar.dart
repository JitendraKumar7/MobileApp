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
      selectedItemColor: Colors.black,
      showUnselectedLabels: true,
      showSelectedLabels: true,
      backgroundColor: Colors.blue[200],
      items: <BottomNavigationBarItem>[
        BottomNavigationBarItem(
          icon: Image.asset(
            reportStatement,
            height: 24,
            color: index == 0 ? Colors.black : Colors.grey,
          ),
          label: 'ACCOUNT STATEMENT',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            reportStatement,
            height: 24,
            color: index == 1 ? Colors.black : Colors.grey,
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
