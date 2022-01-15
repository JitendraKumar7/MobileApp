import 'package:flutter/material.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/widget/widget.dart';

class NavigatePage extends StatelessWidget {
  const NavigatePage({Key? key}) : super(key: key);

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
      currentIndex: NavigateCubit.getState(context),
      onTap: (index) => NavigateCubit.navigation(context, index),
    );
  }
}