import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/services/notification_service.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
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
          IconButton(
            onPressed: () {
              NotificationService.notificationService.simpleNotification();
            },
            icon: const Icon(Icons.notifications),
          ),
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
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {


            return ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text("${userList[index].name}"),
                  subtitle: Text("${userList[index].phone}"),
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
        stream: DbFirebaseHelPer.dbFirebaseHelPer.allConversationUser(),
      ),
    );
  }
}
