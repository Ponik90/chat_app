import 'package:chat_app/screen/login/view/signin_screen.dart';
import 'package:chat_app/screen/login/view/signup_screen.dart';
import 'package:chat_app/screen/profile/view/profile_screen.dart';
import 'package:chat_app/screen/user/view/user_screen.dart';
import 'package:flutter/material.dart';

import '../screen/home/view/home_screen.dart';
import '../screen/splash/view/splash_screen.dart';

Map<String, WidgetBuilder> screen = {
  '/': (context) => const SplashScreen(),
  'signIn': (context) => const SignInScreen(),
  'signUp': (context) => const SignUpScreen(),
  'home': (context) => const HomeScreen(),
  'profile': (context) => const ProfileScreen(),
  'user': (context) => const UserScreen(),
};
