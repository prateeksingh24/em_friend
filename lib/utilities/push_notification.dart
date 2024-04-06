import 'package:firebase_messaging/firebase_messaging.dart';

class PushNotification {
  Future<String> setupPopNotifications() async {
    final fcm = FirebaseMessaging.instance;
    final notiSetting = await fcm.requestPermission();

    final token = await fcm.getToken();
    print(token);
    fcm.subscribeToTopic('chat');
    return token!;
  }
}
