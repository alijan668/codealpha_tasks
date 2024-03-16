import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tzdata;
import 'package:timezone/timezone.dart' as tz;

class Notification_Service {
  FlutterLocalNotificationsPlugin noti_plugin =
      FlutterLocalNotificationsPlugin();

  void initializing_Settings() {
    AndroidInitializationSettings android_settings =
        AndroidInitializationSettings('@mipmap/ic_launcher');

    DarwinInitializationSettings ios_settings = DarwinInitializationSettings();

    InitializationSettings initialization_settings =
        InitializationSettings(android: android_settings, iOS: ios_settings);

    noti_plugin.initialize(initialization_settings);
  }

//---------------------------

  Future<void> show_notification({String? title, String? body}) async {
    AndroidNotificationDetails android_Details = AndroidNotificationDetails(
        'kuch bhi', 'Kuch bhi',
        priority: Priority.high, importance: Importance.max);

    DarwinNotificationDetails ios_details = DarwinNotificationDetails();

    NotificationDetails noti_Details =
        NotificationDetails(android: android_Details, iOS: ios_details);
    await noti_plugin.show(0, title, body, noti_Details);
  }

//----------------------

  Future schedule_Notification(
      {int id = 0,
      String? title,
      String? body,
      String? payload,
      required DateTime schedule_notification_date_time}) async {
    print('hello');
    AndroidNotificationDetails android_Details = AndroidNotificationDetails(
        'kuch bhi', 'Kuch bhi',
        priority: Priority.high, importance: Importance.max);

    DarwinNotificationDetails ios_details = DarwinNotificationDetails();

    NotificationDetails noti_Details =
        NotificationDetails(android: android_Details, iOS: ios_details);

    return noti_plugin.zonedSchedule(
        id,
        title,
        body,
        tz.TZDateTime.from(schedule_notification_date_time, tz.local),
        noti_Details,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
