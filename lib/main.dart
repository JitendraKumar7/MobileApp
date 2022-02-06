import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:safe_device/safe_device.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.dart';
import 'services/options/firebase_options.dart';

//https://apps.apple.com/app/id1601196670

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(options: options);
  }
  // is mobile device
  else {
    await Firebase.initializeApp();
   /* bool isSafeDevice = await SafeDevice.isSafeDevice;
    if (!isSafeDevice) {
      return runApp(
        const MaterialApp(
          home: Center(
            child: Text(
              'Device is not safe or broken',
              style: TextStyle(
                fontSize: 18,
                color: Colors.blueGrey,
              ),
            ),
          ),
          debugShowCheckedModeBanner: false,
        ),
      );
    }*/
  }

  // -> profile page

  // forgot password
  // logo change
  // feedback submit
  // about page (web open)
  // master title dynamic

  final repository = AuthenticationRepository();
  await repository.user.first;
  setPathUrlStrategy();

  BlocOverrides.runZoned(
    () => runApp(App(repository: repository)),
    blocObserver: AppBlocObserver(),
  );
}
