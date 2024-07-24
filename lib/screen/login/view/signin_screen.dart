import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import '../../../utils/helper/firebase_auth.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
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
              onPressed: () async {
                if(formKey.currentState!.validate())
                  {
                   await FireBaseHelper.fireBaseHelper
                        .signinAuth(txtEmail.text, txtPassword.text);

                    bool response = FireBaseHelper.fireBaseHelper.checkUser();
                    if (response) {
                      Get.offAllNamed("home");
                    }
                  }

              },
              child: const Text("Sign in"),
            ),
            ElevatedButton(
              onPressed: () {
                bool response = FireBaseHelper.fireBaseHelper.checkUser();
                FireBaseHelper.fireBaseHelper.googleSignIn();
                if (response) {
                  Get.offAllNamed("home");
                }
              },
              child: const Text("google Sign in"),
            ),
            TextButton(
              onPressed: () {
                Navigator.pushNamed(context, 'signUp');
              },
              child: const Text("Don't Have An account"),
            ),
          ],
        ),
      ),
    );
  }
}
