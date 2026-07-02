import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/firebase_options.dart';
import 'package:todo_app/helper/local_notification_service.dart';
import 'package:todo_app/my_app.dart';

// step 1
@pragma('vm:entry-point')
Future<void> _backgroundHandler(RemoteMessage message) async {
  if (kDebugMode) {
    print('Message is : ${message.notification?.title}');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Must be first!
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // step 2 register and initilized
  FirebaseMessaging.onBackgroundMessage(_backgroundHandler);

  await initLocalNotification();

  runApp(const MyApp());
}
