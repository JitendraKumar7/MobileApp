import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/widget/widget.dart';

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
            masterLedger,
            height: 24,
          ),
          label: 'LEDGER',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            masterItem,
            height: 24,
          ),
          label: 'ITEMS',
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            masterGroup,
            height: 24,
          ),
          label: 'GROUPS',
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
