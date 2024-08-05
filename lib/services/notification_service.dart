import 'dart:io';
import 'package:flutter_timezone/flutter_timezone.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:path_provider/path_provider.dart';
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;

class NotificationService {
  static NotificationService notificationService = NotificationService._();

  NotificationService._();

  FlutterLocalNotificationsPlugin plugin = FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    AndroidInitializationSettings androidInitializationSettings =
        const AndroidInitializationSettings("app");

    DarwinInitializationSettings darwinInitializationSettings =
        const DarwinInitializationSettings();
    InitializationSettings initializationSettings = InitializationSettings(
      iOS: darwinInitializationSettings,
      android: androidInitializationSettings,
    );
    tz.initializeTimeZones();
    String timeZoneName = await FlutterTimezone.getLocalTimezone();
    tz.setLocalLocation(tz.getLocation(timeZoneName));
    plugin.initialize(initializationSettings);
  }

  void simpleNotification() {
    AndroidNotificationDetails androidNotificationDetails =
        const AndroidNotificationDetails("1", "simple notification",
            importance: Importance.high, priority: Priority.max);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();

    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    plugin.show(1, 'LOCAL', 'SIMPLE', notificationDetails);
  }

  Future<void> zonedScheduleNotification() async {
    await plugin.zonedSchedule(
        0,
        'scheduled title',
        'scheduled body',
        tz.TZDateTime.now(tz.local).add(const Duration(seconds: 5)),
        const NotificationDetails(
            android: AndroidNotificationDetails(
                'your channel id', 'your channel name',
                channelDescription: 'your channel description')),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.absoluteTime);
  }

  Future<void> imageNotification() async {
    String picture = await downloadAndSaveFile(
        "https://www.autocar.co.uk/sites/autocar.co.uk/files/styles/gallery_slide/public/images/car-reviews/first-drives/legacy/rolls_royce_phantom_top_10.jpg?itok=XjL9f1tx",
        "image");
    BigPictureStyleInformation pictureStyleInformation =
        BigPictureStyleInformation(FilePathAndroidBitmap(picture));
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("3", "Image notification",
            importance: Importance.high,
            priority: Priority.max,
            styleInformation: pictureStyleInformation);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await plugin.show(
      3,
      'image',
      'notification',
      notificationDetails,
    );
  }

  Future<String> downloadAndSaveFile(String url, String fileName) async {
    final Directory directory = await getApplicationDocumentsDirectory();
    final String filePath = '${directory.path}/$fileName';
    final http.Response response = await http.get(Uri.parse(url));
    final File file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);
    return filePath;
  }

  Future<void> soundNotification() async {
    String ringtone = "r1";
    UriAndroidNotificationSound notificationSound =
        UriAndroidNotificationSound(ringtone);
    AndroidNotificationDetails androidNotificationDetails =
        AndroidNotificationDetails("4", "Sound notification",
            importance: Importance.high,
            priority: Priority.max,
            sound: notificationSound);
    DarwinNotificationDetails darwinNotificationDetails =
        const DarwinNotificationDetails();
    NotificationDetails notificationDetails = NotificationDetails(
        android: androidNotificationDetails, iOS: darwinNotificationDetails);
    await plugin.show(
      4,
      'sound',
      'notification',
      notificationDetails,
    );
  }
}
