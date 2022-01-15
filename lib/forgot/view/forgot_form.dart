import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:tally/app/app.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/forgot/cubit/forgot_cubit.dart';

import 'animation/fade_animation.dart';

class ForgotForm extends StatelessWidget {
  const ForgotForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<ForgotCubit, ForgotState>(
      listener: (context, state) {
        if (state.status.isSubmissionFailure) {
          ScaffoldMessenger.of(context)
            ..hideCurrentSnackBar()
            ..showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'Authentication Failure'),
              ),
            );
        }
      },
      child: Container(
        height: size.height,
        width: size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 80),
            const FadeAnimation(
              2,
              Text(
                'Forgot Password',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 2,
                  fontFamily: 'Lobster',
                ),
              ),
            ),
            FadeAnimation(
              2,
              Container(
                height: 250,
                width: size.width,
                child: Image.asset(
                  logo,
                  fit: BoxFit.fill,
                ),
                margin: const EdgeInsets.only(right: 40),
              ),
            ),
            FadeAnimation(2, _EmailInput()),
            FadeAnimation(2, _ForgotButton()),
            FadeAnimation(
              2,
              TextButton(
                onPressed: () {
                  var bloc = context.read<AppBloc>();
                  bloc.add(AppLogoutRequested());
                },
                child: const Text('Login'),
              ),
            ),
          ]),
        ),
      ),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotCubit, ForgotState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: TextField(
            onChanged: (email) =>
                context.read<ForgotCubit>().emailChanged(email),
            keyboardType: TextInputType.emailAddress,
            decoration: InputDecoration(
              labelText: 'EMAIL ID',
              helperText: '',
              filled: true,
              fillColor: Colors.grey[200],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(),
              ),
              suffixIcon: const Icon(Icons.email),
              labelStyle: const TextStyle(fontSize: 18),
              errorText: state.email.invalid ? 'invalid email' : null,
            ),
          ),
        );
      },
    );
  }
}

class _ForgotButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ForgotCubit, ForgotState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : InkWell(
                onTap: state.status.isValidated
                    ? () => context.read<ForgotCubit>().resetPassword()
                    : null,
                child: Container(
                  width: double.infinity,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 24,
                    vertical: 10,
                  ),
                  padding: const EdgeInsets.only(top: 10, bottom: 10),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0xFF536DFE),
                  ),
                  child: const Text(
                    'Send',
                    style: TextStyle(
                      fontSize: 30,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              );
      },
    );
  }
}
