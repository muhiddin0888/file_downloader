import 'dart:math';
import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:open_file_safe/open_file_safe.dart';
import 'package:timezone/data/latest_all.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

class LocalNotificationService {
  static final LocalNotificationService localNotificationService =
      LocalNotificationService._();

  factory LocalNotificationService() {
    return localNotificationService;
  }

  LocalNotificationService._();

  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  void init() {
    // Android
    const AndroidInitializationSettings androidInitializationSettings =
        AndroidInitializationSettings("app_icon");

    //IOS
    final DarwinInitializationSettings initializationSettingsDarwin =
        DarwinInitializationSettings(
      onDidReceiveLocalNotification: onDidReceiveLocalNotification,
    );

    //Set
    InitializationSettings initializationSettings = InitializationSettings(
      android: androidInitializationSettings,
      iOS: initializationSettingsDarwin,
    );

    flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      // onDidReceiveBackgroundNotificationResponse: notificationTapBackground,
      onDidReceiveNotificationResponse: (
        NotificationResponse notificationResponse,
      ) async {
        final String? payload = notificationResponse.payload;
        OpenFile.open(payload);
        debugPrint('NOTIFICATION PAYLOAD: ${payload.toString()}');
      },
    );

    flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.requestPermission();

    tz.initializeTimeZones();
  }

  @pragma('vm:entry-point')
  void notificationTapBackground(NotificationResponse notificationResponse) {
    // handle action
  }

  ValueChanged<String> onOpenedPage(String valueChanged) {
    late ValueChanged<String> valueChanged = (valueChanged) {};
    return valueChanged;
  }

  //IOS

  void onDidReceiveLocalNotification(
    int id,
    String? title,
    String? body,
    String? payload,
  ) async {
    print(payload);
    OpenFile.open(payload);
  }

  //channel
  AndroidNotificationChannel androidNotificationChannel =
      const AndroidNotificationChannel(
    "high_importance_channel",
    "Notification Lesson",
    importance: Importance.max,
    description: "My Notification description",
  );

  void showNotification(String remoteMessage) {
    var random =
        Random(); // keep this somewhere in a static variable. Just make sure to initialize only once.
    int id = random.nextInt(1000);
    flutterLocalNotificationsPlugin.show(
      id,
      "title",
      "downloded",
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          priority: Priority.max,
          playSound: true,
          icon: "app_icon",
          showProgress: true,
          largeIcon: const DrawableResourceAndroidBitmap('app_icon'),
        ),
      ),
      payload: remoteMessage,
    );
  }

  void scheduleNotification(int seconds) async {
    await flutterLocalNotificationsPlugin.zonedSchedule(
      12,
      "scheduleNotification",
      "EXAMPLE",
      tz.TZDateTime.now(tz.local).add(Duration(seconds: seconds)),
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      payload: "Notification DATA",
      androidAllowWhileIdle: true,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
    );
  }

  void showPeriodically() async {
    await flutterLocalNotificationsPlugin.periodicallyShow(
      1234,
      'repeating title',
      'repeating body',
      RepeatInterval.daily,
      NotificationDetails(
        android: AndroidNotificationDetails(
          androidNotificationChannel.id,
          androidNotificationChannel.name,
          channelDescription: 'To remind you about upcoming birthdays',
        ),
      ),
      androidAllowWhileIdle: true,
      payload: "DATA",
    );
  }

  void cancelAllNotifications() {
    flutterLocalNotificationsPlugin.cancelAll();
  }

  void cancelNotificationById(int id) {
    flutterLocalNotificationsPlugin.cancel(id);
  }
}
