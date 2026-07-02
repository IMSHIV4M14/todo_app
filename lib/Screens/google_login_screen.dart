import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

class GoogleLoginScreen extends StatefulWidget {
  const GoogleLoginScreen({super.key});

  @override
  State<GoogleLoginScreen> createState() => _GoogleLoginScreenState();
}

class _GoogleLoginScreenState extends State<GoogleLoginScreen> {
  String token = 'lodaing ...';

  // @override
  // void initState() {
  //   getFCMToken();
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Google Login Screen'), centerTitle: true),
      body: Column(
        crossAxisAlignment: .center,
        spacing: 50,
        children: [
          ElevatedButton(
            onPressed: () {
              getFCMToken();
            },
            child: Text('Generate FCM Token'),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text('FCM Token is : "$token"'),
          ),
        ],
      ),
    );
  }

  // get FCM token
  Future<void> getFCMToken() async {
    // requestPermission to user
    await FirebaseMessaging.instance.requestPermission();

    // get FCM token from firebase messaging

    String? t = await FirebaseMessaging.instance.getToken();
    setState(() {
      token = t ?? 'No Token Found 🥲';
    });

    print('Fcm Token is : "$token"');
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      if (kDebugMode) {
        print('Foreground: ${message.notification?.title}');
      }
    });

    RemoteMessage? initialMessage = await FirebaseMessaging.instance
        .getInitialMessage();
    if (initialMessage != null) {
      print('From Terminated Stste');
    }
  }
}
