import 'dart:async';

import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {

    bool check = FireBaseHelper.fireBaseHelper.checkUser();
    super.initState();
    Timer(const Duration(seconds: 4), () {
      Get.offAllNamed(check ? 'home' : 'signIn');
    });
    controller.getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: MediaQuery.sizeOf(context).height,
            width: MediaQuery.sizeOf(context).width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment(0, 0),
                end: Alignment(0, 1),
                colors: [
                  Color(0xff1b87d4),
                  Color(0xff4bbd7c),
                ],
              ),
            ),
          ),
          Center(
            child: Image.asset(
              'assets/logo/app_logo.png',
              width: 200,
              height: 200,
            ),
          ),
        ],
      ),
    );
  }
}
