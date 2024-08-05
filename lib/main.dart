import 'package:chat_app/services/notification_service.dart';
import 'package:chat_app/utils/app_routes.dart';
import 'package:chat_app/utils/theme/light_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  NotificationService.notificationService.initNotification();
  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      routes: screen,
      theme: lightTheme,
    ),
  );
}
