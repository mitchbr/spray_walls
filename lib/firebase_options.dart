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
    apiKey: 'AIzaSyD3rCmvkljc-tJ4FYBXxbetAZp8xWy7HPo',
    appId: '1:495626377974:web:5a325caa4a362a2e016ad7',
    messagingSenderId: '495626377974',
    projectId: 'spraywalls-dd36f',
    authDomain: 'spraywalls-dd36f.firebaseapp.com',
    storageBucket: 'spraywalls-dd36f.appspot.com',
    measurementId: 'G-JJ5C1R418H',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyABi1JRDZJJnYGuWqc7nys15LNwsGZ9FXA',
    appId: '1:495626377974:android:33d93c23ff9830fe016ad7',
    messagingSenderId: '495626377974',
    projectId: 'spraywalls-dd36f',
    storageBucket: 'spraywalls-dd36f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCpxBoPsk2AMCxXSkZuCGc1elt_VPvWuys',
    appId: '1:495626377974:ios:4bdc0f560c6e9b37016ad7',
    messagingSenderId: '495626377974',
    projectId: 'spraywalls-dd36f',
    storageBucket: 'spraywalls-dd36f.appspot.com',
    iosClientId: '495626377974-d8rjgc9vp6gkb960t281dt6htgnvmumj.apps.googleusercontent.com',
    iosBundleId: 'edu.oregonstate.brownmit.sprayWalls',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCpxBoPsk2AMCxXSkZuCGc1elt_VPvWuys',
    appId: '1:495626377974:ios:4bdc0f560c6e9b37016ad7',
    messagingSenderId: '495626377974',
    projectId: 'spraywalls-dd36f',
    storageBucket: 'spraywalls-dd36f.appspot.com',
    iosClientId: '495626377974-d8rjgc9vp6gkb960t281dt6htgnvmumj.apps.googleusercontent.com',
    iosBundleId: 'edu.oregonstate.brownmit.sprayWalls',
  );
}