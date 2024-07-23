import 'dart:async';

import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override


  void initState() {
    bool check = FireBaseHelper.fireBaseHelper.checkUser();
    super.initState();
    Timer(const Duration(seconds: 4), () {

      Get.offAllNamed(check?'home':'signIn');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Splash screen"),
      ),
    );
  }
}
