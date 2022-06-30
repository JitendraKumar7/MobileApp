import 'package:flutter/widgets.dart';

import 'package:tally/app/app.dart';
import 'package:tally/home/home.dart';
import 'package:tally/login/login.dart';
import 'package:tally/forgot/forgot.dart';

List<Page> onGenerateAppViewPages(AppStatus state, List<Page<dynamic>> pages) {
  switch (state) {
    case AppStatus.forgotten:
      return [ForgotPage.page()];
    case AppStatus.authenticated:
      return [IndexPage.page()];
    case AppStatus.unauthenticated:
    default:
      return [LoginPage.page()];
  }
}
