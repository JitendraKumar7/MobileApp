import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

const String _apiKey = 'AIzaSyAHymgOs0UYWTDOmQqoD50YsjA4iW8CSv4';
const String _storage = 'tally-konnect-55ffb.appspot.com';
const String _projectId = 'tally-konnect-55ffb';
const String _authDomain = 'tally-konnect-55ffb.firebaseapp.com';
const String _databaseURL =
    'https://tally-konnect-55ffb-default-rtdb.firebaseio.com';

FirebaseOptions get options {
  String _appId = '1:93429636162:web:5bcd680539d281a6fa61db';
  if (!kIsWeb) {
    if (Platform.isAndroid) {
      _appId = kDebugMode
          ? '1:93429636162:android:f887b3decd26061cfa61db'
          : '1:93429636162:android:f7b998c09c752b35fa61db';
    }
  }
  return FirebaseOptions(
    messagingSenderId: '93429636162',
    measurementId: 'G-R3TKNMSTBB',
    databaseURL: _databaseURL,
    storageBucket: _storage,
    authDomain: _authDomain,
    projectId: _projectId,
    apiKey: _apiKey,
    appId: _appId,
  );
}
