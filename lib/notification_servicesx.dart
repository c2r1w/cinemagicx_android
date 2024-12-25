import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:firebase_messaging/firebase_messaging.dart';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:http/http.dart' as http;

class NotificationServicesx {
  FirebaseMessaging messaging = FirebaseMessaging.instance;

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initlocal() async {
    var androidinitnot = AndroidInitializationSettings("@mipmap/ic_launcher");
    var iosinitnot = DarwinInitializationSettings();

    var inits =
        InitializationSettings(android: androidinitnot, iOS: iosinitnot);

    await flutterLocalNotificationsPlugin.initialize(
      inits,
      onDidReceiveNotificationResponse: (details) {
        print("=====>${details.actionId}");
      },
    );
  }

  Future<void> firebaseinit() async {
    await initlocal();

    FirebaseMessaging.onMessage.listen((iox) {
      shownot(iox);
    });
  }

  Future<void> shownot(RemoteMessage msg) async {
    print(msg.data.containsKey('xyz'));

    late AndroidNotificationDetails ancd;
    if (msg.data.containsKey("img")) {
      final http.Response response =
          await http.get(Uri.parse(msg.data["img"].toString()));
      final fp = ByteArrayAndroidBitmapx.fromUint8List(response.bodyBytes);
      ancd = AndroidNotificationDetails(Random.secure().nextInt(5).toString(),
          Random.secure().nextInt(5).toString(),
          fullScreenIntent: true,
          importance: Importance.max,
          styleInformation:
              BigPictureStyleInformation(fp, hideExpandedLargeIcon: true),
          ticker: "ticker",
          priority: Priority.high);
    } else {
      ancd = AndroidNotificationDetails(Random.secure().nextInt(10).toString(),
          Random.secure().nextInt(10).toString(),
          fullScreenIntent: true,
          importance: Importance.max,
          ticker: "ticker",
          priority: Priority.high);
    }

    // BigPictureStyleInformation bigPictureStyleInformation =
    //     BigPictureStyleInformation(
    //         ByteArrayAndroidBitmapx.fromUint8List(response.bodyBytes),
    //         largeIcon:
    //             ByteArrayAndroidBitmapx.fromUint8List(response.bodyBytes));

    DarwinNotificationDetails ioscd = DarwinNotificationDetails();

    NotificationDetails nd = NotificationDetails(android: ancd, iOS: ioscd);

    Future.delayed(Duration.zero, () {
      flutterLocalNotificationsPlugin.show(
          Random.secure().nextInt(1000),
          msg.notification?.title ?? msg.data["title"],
          msg.notification?.body ?? msg.data["body"],
          nd);
    });
  }

  void requestNotificationPermission() async {
    NotificationSettings settings = await messaging.requestPermission(
        alert: true,
        badge: true,
        provisional: true,
        announcement: true,
        carPlay: true,
        criticalAlert: true,
        sound: true);

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
    } else {}
  }

  Future<String> gettoken() async {
    String? tok = Platform.isAndroid
        ? await messaging.getToken()
        : await messaging.getAPNSToken();
    return tok ?? "";
  }

  Future<void> subxrib() async {
    await messaging.subscribeToTopic("raju");
  }
}
