import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:package_info/package_info.dart';
import 'package:tally/app/app.dart';
import 'package:tally/constant/constant.dart';
import 'package:tally/login/cubit/login_cubit.dart';

import 'animation/fade_animation.dart';

class LoginForm extends StatelessWidget {
  const LoginForm({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return BlocListener<LoginCubit, LoginState>(
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
        width: kIsWeb ? 420 : size.width,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(background),
            fit: BoxFit.cover,
          ),
        ),
        child: SingleChildScrollView(
          child: Column(children: [
            const SizedBox(height: 80),
            FadeAnimation(
              2,
              Container(
                height: 250,
                width: size.width - 160,
                margin: const EdgeInsets.only(right: 40),
                child: Image.asset(logo, fit: BoxFit.fill),
              ),
            ),
            FadeAnimation(2, _EmailInput()),
            FadeAnimation(2, _PasswordInput()),
            FadeAnimation(
                2,
                TextButton(
                  onPressed: () {
                    var bloc = context.read<AppBloc>();
                    bloc.add(AppForgotRequested());
                  },
                  child: const Text('Forgot Password?'),
                )),
            FadeAnimation(2, _LoginButton()),
            const SizedBox(height: 80),
            FutureBuilder(
              future: PackageInfo.fromPlatform(),
              builder: (_, AsyncSnapshot<PackageInfo> snapshot) {
                if (snapshot.hasData) {
                  var packageInfo = snapshot.data;
                  var appName = packageInfo?.appName;
                  var version = packageInfo?.version;
                  var packageName = packageInfo?.packageName;
                  var buildNumber = packageInfo?.buildNumber;
                  debugPrint('$packageName $buildNumber');
                  return Container(
                    padding: const EdgeInsets.only(right: 24),
                    alignment: Alignment.centerRight,
                    child: Text(
                      '$appName - $version',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                  );
                }
                return const SizedBox();
              },
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
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.email != current.email,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: TextField(
            onChanged: (email) =>
                context.read<LoginCubit>().emailChanged(email),
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

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var obscureText = true;
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.password != current.password,
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.only(left: 24, right: 24),
          child: StatefulBuilder(builder: (context, setState) {
            return TextField(
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: obscureText,
              decoration: InputDecoration(
                labelText: 'PASSWORD',
                helperText: '',
                filled: true,
                fillColor: Colors.grey[200],
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: const BorderSide(),
                ),
                suffixIcon: IconButton(
                  icon: Icon(
                      obscureText ? Icons.visibility_off : Icons.visibility),
                  onPressed: () {
                    setState(() => obscureText = !obscureText);
                  },
                ),
                labelStyle: const TextStyle(fontSize: 18),
                errorText: state.password.invalid ? 'invalid password' : null,
              ),
            );
          }),
        );
      },
    );
  }
}

class _LoginButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LoginCubit, LoginState>(
      buildWhen: (previous, current) => previous.status != current.status,
      builder: (context, state) {
        return state.status.isSubmissionInProgress
            ? const CircularProgressIndicator()
            : InkWell(
                onTap: state.status.isValidated
                    ? () => context.read<LoginCubit>().logInWithCredentials()
                    : null,
                child: Container(
                  width: 200,
                  alignment: Alignment.center,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 12,
                    vertical: 6,
                  ),
                  padding: const EdgeInsets.only(top: 9, bottom: 9),
                  decoration: const BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(12)),
                    color: Color(0xFF536DFE),
                  ),
                  child: const Text(
                    'Login',
                    style: TextStyle(
                      fontSize: 18,
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
