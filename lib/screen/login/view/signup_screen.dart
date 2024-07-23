import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

import '../../../utils/helper/firebase_auth.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController txtEmail = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: txtEmail,
              validator: (value) {
                if (value!.isEmpty) {
                  return "this is required";
                }
                return null;
              },
            ),
            TextFormField(
              controller: txtPassword,
              validator: (value) {
                if (value!.isEmpty) {
                  return "this is required";
                }
                return null;
              },
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  FireBaseHelper.fireBaseHelper
                      .signUpAuth(txtEmail.text, txtPassword.text);

                  Get.offAllNamed('signIn');
                }
              },
              child: const Text("Sign up"),
            ),
            TextButton(
              onPressed: () {
                Get.offAllNamed('signIn');
              },
              child: const Text("Have An account"),
            ),
          ],
        ),
      ),
    );
  }
}
