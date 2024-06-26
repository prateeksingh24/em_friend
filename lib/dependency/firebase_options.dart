// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyCdmR7MT1moH68HTC2slJqm6YcqANsUsWg',
    appId: '1:263981879460:web:d16d69e5e2731984ed5631',
    messagingSenderId: '263981879460',
    projectId: 'em-friend',
    authDomain: 'em-friend.firebaseapp.com',
    storageBucket: 'em-friend.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAvYrrPjLhFwv_A0U3zdMTFNa4HqtGa05s',
    appId: '1:263981879460:android:952925235f1c3bd6ed5631',
    messagingSenderId: '263981879460',
    projectId: 'em-friend',
    storageBucket: 'em-friend.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCFWZCo3vNa2f3qKiiDwDvXnRJrAheJui0',
    appId: '1:263981879460:ios:372f0ad50f45b5d1ed5631',
    messagingSenderId: '263981879460',
    projectId: 'em-friend',
    storageBucket: 'em-friend.appspot.com',
    iosBundleId: 'com.wipeduck.emFriend',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCFWZCo3vNa2f3qKiiDwDvXnRJrAheJui0',
    appId: '1:263981879460:ios:a87d2c9d4f4b922ded5631',
    messagingSenderId: '263981879460',
    projectId: 'em-friend',
    storageBucket: 'em-friend.appspot.com',
    iosBundleId: 'com.wipeduck.emFriend.RunnerTests',
  );
}
