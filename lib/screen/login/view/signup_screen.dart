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
    return GestureDetector(
      onTap: () {
        FocusManager.instance.primaryFocus!.unfocus();
      },
      child: Scaffold(
        body: Padding(
          padding:
              const EdgeInsets.only(left: 16, right: 16, bottom: 16, top: 50),
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Get.back();
                      },
                      icon: const Icon(Icons.arrow_back),
                    ),
                  ),
                  Image.asset(
                    'assets/login/signup.jpg',
                    opacity: const AlwaysStoppedAnimation(.7),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: 'E-mail or Phone no',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    controller: txtEmail,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    decoration: InputDecoration(
                      contentPadding: const EdgeInsets.only(left: 16),
                      hintText: 'Password',
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(50),
                      ),
                    ),
                    controller: txtPassword,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "this is required";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xff0279f5),
                    ),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        FireBaseHelper.fireBaseHelper
                            .signUpAuth(txtEmail.text, txtPassword.text);

                        Get.offAllNamed('signIn');
                      }
                      FocusManager.instance.primaryFocus!.unfocus();
                    },
                    child: const Text(
                      "Sign up",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  InkWell(
                    onTap: () {
                      Get.offAllNamed('signIn');
                    },
                    child: RichText(
                      text: const TextSpan(
                        children: [
                          TextSpan(
                            text: "Have an Account ? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 18,
                            ),
                          ),
                          TextSpan(
                            text: "Sign In",
                            style: TextStyle(
                              color: Color(0xff0279f5),
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
