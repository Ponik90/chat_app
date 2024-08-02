import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/timezone.dart' as tz;

class NotificationService {
  static NotificationService notificationService = NotificationService._();

  NotificationService._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  void initNotification() {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("app.png");

    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      iOS: darwinInitializationSettings,
      android: androidInitializationSettings,
    );
    plugin.initialize(initializationSettings);
  }

  Future<void> simpleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("1", "simple notification",
            importance: Importance.high, priority: Priority.max);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await plugin.show(1, 'LOCAL', 'SIMPLE', notificationDetails);
  }

  Future<void> scheduleNotification() async {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("2", "schedule notification",
            importance: Importance.high, priority: Priority.max);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await plugin.zonedSchedule(
        2,
        'schedule',
        'notification',
        tz.TZDateTime.now(tz.local).add(
          const Duration(seconds: 5),
        ),
        notificationDetails,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }
}
