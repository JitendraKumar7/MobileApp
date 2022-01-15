import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tally/forgot/cubit/forgot_cubit.dart';

import 'forgot_form.dart';

class ForgotPage extends StatelessWidget {
  const ForgotPage({Key? key}) : super(key: key);

  static Page page() => const MaterialPage<void>(child: ForgotPage());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBar(title: const Text('Forgot')),
      body: BlocProvider(
        create: (_) => ForgotCubit(context.read<AuthenticationRepository>()),
        child: const ForgotForm(),
      ),
    );
  }
}
