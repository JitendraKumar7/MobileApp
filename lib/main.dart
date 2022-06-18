import 'package:authentication_repository/authentication_repository.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.dart';
import 'services/options/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: kIsWeb ? options : null,
  );

  final repository = AuthenticationRepository();
  await repository.user.first;
  setPathUrlStrategy();

  BlocOverrides.runZoned(() => runApp(App(repository: repository)),
      blocObserver: AppBlocObserver());
}
