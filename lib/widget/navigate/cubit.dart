import 'package:flutter_bloc/flutter_bloc.dart';

class NavigateCubit extends Cubit<int> {
  NavigateCubit() : super(0);

  void change(int index) => emit(index);
}
