import 'dart:convert';

import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:parse_server_sdk_flutter/parse_server_sdk.dart';
import 'package:siloka_security/app/modules/home/controllers/visitor_controller.dart';
import 'package:siloka_security/app/modules/profile/controllers/profile_controller.dart';
import 'package:http/http.dart' as http;
import 'package:siloka_security/server_config.dart';
import 'emergency_controller.dart';

class HomeController extends GetxController {
  late AndroidNotificationChannel channel;
  late FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;

//GETTER TOTAL PESAN
  int getTotalPesan() {
    final totalpesanvisitor = Get.find<VisitorController>().listVisitor.length;
    final totalpesanemergency =
        Get.find<EmergencyController>().listEmergency.length;
    final datatotal = totalpesanemergency + totalpesanvisitor;
    return datatotal;
  }

  @override
  void onInit() {
    requestPermission();
    listenFCM();
    loadFCM();
    super.onInit();
  }

//TODO UNUSED GET DEVICE TOKEN FROM FCM
  Future<String?> getToken() async {
    final token = await FirebaseMessaging.instance.getToken();
    debugPrint("TOKEN : $token");
    return token;
  }

//REQUEST PERMISSION NOTIFICATION
  void requestPermission() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    NotificationSettings settings = await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    if (settings.authorizationStatus == AuthorizationStatus.authorized) {
      debugPrint('User granted permission');
    } else if (settings.authorizationStatus ==
        AuthorizationStatus.provisional) {
      debugPrint('User granted provisional permission');
    } else {
      debugPrint('User declined or has not accepted permission');
    }
  }

//LOCAL NOTIFICATION LISTEN TO FCM
  void listenFCM() async {
    const soundVisitor = 'notification_visitor.mp3';
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      RemoteNotification? notification = message.notification;
      AndroidNotification? android = message.notification?.android;

      if (notification != null && android != null && !kIsWeb) {
        flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              channel.id,
              channel.name,
              playSound: true,
              sound: RawResourceAndroidNotificationSound(
                  soundVisitor.split('.').first),
              // add a proper drawable resource to android, for now using
              //      one that already exists in example app.
              icon: '@mipmap/ic_launcher',
            ),
          ),
        );
      }
    });
  }

//LOAD LOCAL NOTIFICATION
  void loadFCM() async {
    if (!kIsWeb) {
      channel = const AndroidNotificationChannel(
        'high_importance_channel', // id
        'High Importance Notifications', // title
        importance: Importance.high,
        enableVibration: true,
      );

      flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

      /// Create an Android Notification Channel.
      ///
      /// We use this channel in the `AndroidManifest.xml` file to override the
      /// default FCM channel to enable heads up notifications.
      await flutterLocalNotificationsPlugin
          .resolvePlatformSpecificImplementation<
              AndroidFlutterLocalNotificationsPlugin>()
          ?.createNotificationChannel(channel);

      /// Update the iOS foreground notification presentation options to allow
      /// heads up notifications.
      await FirebaseMessaging.instance
          .setForegroundNotificationPresentationOptions(
        alert: true,
        badge: true,
        sound: true,
      );
    }
  }

//TODO UNUSED SAVE DEVICE TOKEN KE PARSE INSTALLATION
  void updateParseInstallation() async {
    final tokenFromFCM = await getToken();
    var installation = await ParseInstallation.currentInstallation();
    installation.deviceToken = tokenFromFCM;
    var apiResponse = await installation.save();
    if (apiResponse.success) {
      debugPrint("TOKEN SAVING INFO : ${apiResponse.result}");
    }
  }

//SEND PUSH NOTIFICATION API
  void sendPushMessage({required String title, required String message}) async {
    final userToken = Get.find<ProfileController>().dataUser.value.devicetoken;
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$keyFCMServerKey',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': message,
              'title': title,
            },
            'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done'
            },
            "to": "$userToken",
          },
        ),
      );
    } catch (e) {
      debugPrint("error push notification");
    }
  }
}
