import 'package:chat_app/screen/user/controller/user_controller.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:chat_app/utils/helper/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  UserController controller = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    controller.getAllUser();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("All App User"),
      ),
      body: Obx(
        () => ListView.builder(
          itemCount: controller.userModelList.length,
          itemBuilder: (context, index) {
            return ListTile(
              onTap: () async {
                print("==========${controller.userModelList[index].id}");

                await DbFirebaseHelPer.dbFirebaseHelPer.getChatDocId(
                    FireBaseHelper.fireBaseHelper.user!.uid,
                    controller.userModelList[index].id!);
                Get.toNamed('chat', arguments: controller.userModelList[index]);
              },
              title: Text("${controller.userModelList[index].name}"),
              leading: CircleAvatar(
                child: Text(controller.userModelList[index].name![0]),
              ),
              subtitle: Text("${controller.userModelList[index].phone}"),
            );
          },
        ),
      ),
    );
  }
}
