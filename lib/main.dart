import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.dart';
import 'services/options/firebase_options.dart';

//https://apps.apple.com/app/id1601196670
//All month reports in a single list
//
// Sales Purchase TextButton to ElevatedButton in party master (Ledger)
//
// Sales Purchase reports month view then show reports
//
//
// bank details of require ds -> name, account number, bank ifsc code, branch name
//
// gst window task -> party master (verify) ElevatedButton
//
// ---------------------------------------------------------------------------

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

  final repository = AuthenticationRepository();
  await repository.user.first;
  setPathUrlStrategy();

  BlocOverrides.runZoned(
    () => runApp(App(repository: repository)),
    blocObserver: AppBlocObserver(),
  );
}
