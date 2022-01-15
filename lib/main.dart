import 'package:authentication_repository/authentication_repository.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:url_strategy/url_strategy.dart';

import 'app/app.dart';
import 'services/options/firebase_options.dart';

//https://apps.apple.com/app/id1563459732
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  kIsWeb
      ? await Firebase.initializeApp(options: options)
      : await Firebase.initializeApp();

  final repository = AuthenticationRepository();
  await repository.user.first;
  setPathUrlStrategy();
  BlocOverrides.runZoned(
    () => runApp(App(repository: repository)),
    blocObserver: AppBlocObserver(),
  );
}
