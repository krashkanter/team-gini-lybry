import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, TargetPlatform;

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;

      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBCuAV4F5bP9NaXqgPTlSkjPGuX9gpVPA4',
    appId: '1:1053827720703:android:4d3890bed78d8cd70af3ca',
    messagingSenderId: '1053827720703',
    projectId: 'hacknight-gini',
    // storageBucket: 'tasc-app-ae1ac.appspot.com',
  );
}
