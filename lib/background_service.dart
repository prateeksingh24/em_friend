import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_background_service/flutter_background_service.dart';
import 'package:flutter_background_service_android/flutter_background_service_android.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

Future<void> initialiseService() async {
  FlutterBackgroundService().configure(
    androidConfiguration: AndroidConfiguration(
      onStart: onStart,
      autoStart: true,
      isForegroundMode: true,
    ),
    iosConfiguration: IosConfiguration(
      onForeground: onStart,
      onBackground: onIosBackground,
      autoStart: true,
    ),
  );
}

StreamController<DocumentSnapshot> _controller =
    StreamController<DocumentSnapshot>.broadcast();
void _fetchData() async {
  QuerySnapshot<Map<String, dynamic>> querySnapshot =
      await FirebaseFirestore.instance.collection('EMCall').get();
  for (var doc in querySnapshot.docs) {
    print(doc.data());
  }
}
// }
// Future<void> _showNotification() async {
//   FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//       FlutterLocalNotificationsPlugin();
//   const AndroidInitializationSettings initializationSettingsAndroid =
//       AndroidInitializationSettings('app_icon');
//   final InitializationSettings initializationSettings =
//       InitializationSettings(android: initializationSettingsAndroid);
//   await flutterLocalNotificationsPlugin.initialize(initializationSettings);

//   const AndroidNotificationDetails androidPlatformChannelSpecifics =
//       AndroidNotificationDetails(
//     'sos_channel',
//     'Channel for SOS notifications',
//     importance: Importance.max,
//     priority: Priority.high,
//     // Set the `clickAction` to open the app when the notification is tapped
//     clickAction: 'FLUTTER_NOTIFICATION_CLICK',
//     category: AndroidNotificationCategory.call,
//   );
//   const NotificationDetails platformChannelSpecifics =
//       NotificationDetails(android: androidPlatformChannelSpecifics);
//   await flutterLocalNotificationsPlugin.show(
//     0,
//     'SOS Signal',
//     'Emergency SOS signal received',
//     platformChannelSpecifics,
//   );
// }

@pragma('vm:entry-point')
Future<bool> onIosBackground(ServiceInstance service) async {
  WidgetsFlutterBinding.ensureInitialized();
  return true;
}

@pragma('vm:entry-point')
void onStart(ServiceInstance service) async {
  if (service is AndroidServiceInstance) {
    service.on('setAsForeground').listen(
      (event) {
        service.setAsForegroundService();
      },
    );
    service.on('setAsBackground').listen(
      (event) {
        service.setAsBackgroundService();
      },
    );
  }
  service.on('stopService').listen((event) {
    service.stopSelf();
  });

  // my background functional code
  // Start listening to changes in the document
  FirebaseFirestore.instance
      .collection('EMCall')
      .snapshots()
      .listen((snapshot) {
    for (var change in snapshot.docChanges) {
      if (change.doc.exists) {
        bool isSOS = change.doc.data()!['your_field'] ??
            false; // Replace 'your_field' with your actual field name
        if (isSOS) {
          // Invoke SOS screen
          // _invokeSOSScreen();
        }
      }
    }
  });
  Timer.periodic(const Duration(seconds: 30), (timer) async {});
  print('background running');
}
