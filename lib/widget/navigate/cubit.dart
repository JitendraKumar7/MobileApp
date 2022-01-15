import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class NavigateCubit extends Cubit<int> {
  NavigateCubit() : super(0);

  static int getState(BuildContext context) {
    return context.watch<NavigateCubit>().state;
  }

  static void navigation(BuildContext context, int index) {
    var obj = context.read<NavigateCubit>();
    obj.emit(index);
  }
}
