import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          CircleAvatar(
            backgroundColor: const Color(0xff6fb2e4),
            child: IconButton(
              onPressed: () {
                Get.toNamed('profile');
              },
              icon: const Icon(Icons.person),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      drawer: Drawer(
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Column(
            children: [
              Text("${FireBaseHelper.fireBaseHelper.user!.email}"),
              const Spacer(),
              ListTile(
                onTap: () {
                  FireBaseHelper.fireBaseHelper.signOut();
                  Get.offAllNamed('signIn');
                },
                title: const Text("Log Out"),
                trailing: const Icon(Icons.logout_outlined),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.toNamed('user');
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
