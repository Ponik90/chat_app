import 'package:chat_app/screen/home/controller/home_controller.dart';
import 'package:chat_app/services/notification_service.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../profile/controller/profile_controller.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  ProfileController profileController = Get.put(ProfileController());
  HomeController homeController = Get.put(HomeController());

  @override
  void initState() {
    super.initState();
    profileController.getUserDetail();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        actions: [
          IconButton(
            onPressed: () {
              //NotificationService.notificationService.simpleNotification();
              //NotificationService.notificationService.zonedScheduleNotification();
              // NotificationService.notificationService.imageNotification();
              NotificationService.notificationService.soundNotification();
            },
            icon: const Icon(Icons.notifications),
          ),
          // CircleAvatar(
          //   backgroundColor: const Color(0xff6fb2e4),
          //   child: IconButton(
          //     onPressed: () {
          //       Get.toNamed('profile');
          //     },
          //     icon: const Icon(Icons.person),
          //   ),
          // ),
          const SizedBox(
            width: 16,
          ),
        ],
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              height: MediaQuery.sizeOf(context).height * 0.2,
              padding: const EdgeInsets.only(
                top: 50,
                left: 20,
              ),
              width: MediaQuery.sizeOf(context).width,
              color: const Color(
                0xff3e85d1,
              ),
              child: Obx(
                () => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Get.toNamed('profile');
                      },
                      child: CircleAvatar(
                        radius: 35,
                        backgroundColor: const Color(0xff1d6cb1),
                        child: Center(
                          child: Text(
                            profileController.model.value.name![0],
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        "${profileController.model.value.name}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      subtitle: Text(
                        "${profileController.model.value.phone}",
                        style: const TextStyle(
                          color: Color(0xffa6daff),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
            ListTile(
              onTap: () {
                Get.toNamed('profile');
              },
              leading: const Icon(
                Icons.account_circle_outlined,
                size: 30,
                color: Colors.grey,
              ),
              title: const Text(
                "My Profile",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Divider(
              color: Colors.grey.shade300,
            ),
            ListTile(
              onTap: () {
                Get.toNamed('user');
              },
              leading: const Icon(
                Icons.person_2_outlined,
                size: 30,
                color: Colors.grey,
              ),
              title: const Text(
                "Contacts",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
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
      floatingActionButton: FloatingActionButton(
        elevation: 3,
        onPressed: () {
          Get.toNamed('user');
        },
        backgroundColor: const Color(0xff458ddd),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
        child: const Icon(
          Icons.edit,
          color: Colors.white,
        ),
      ),
      body: StreamBuilder(
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Text("${snapshot.error}");
          } else if (snapshot.hasData) {
            QuerySnapshot? qs = snapshot.data;
            Map m1 = qs!.docs as Map;
            if (m1['Userid1'] == FireBaseHelper.fireBaseHelper.user!.uid) {
              List<QueryDocumentSnapshot> list = qs.docs;
              for (var x in list) {
                Map m1 = x.data() as Map;
                if (m1['Userid1'] == FireBaseHelper.fireBaseHelper.user!.uid) {
                } else if (m1['Userid2'] ==
                    FireBaseHelper.fireBaseHelper.user!.uid) {}
              }
            }

            return ListView.builder(
              itemCount: 20,
              itemBuilder: (context, index) {
                return const ListTile(
                  title: Text("name}"),
                  subtitle: Text("phone}"),
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
