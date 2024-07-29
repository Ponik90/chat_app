import 'package:chat_app/screen/user/controller/user_controller.dart';
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
      body: ListView.builder(
        itemCount: controller.userModelList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${controller.userModelList[index].name}"),
            leading: CircleAvatar(
              child: Text(controller.userModelList[index].name![0]),
            ),
            subtitle: Text("${controller.userModelList[index].phone}"),
          );
        },
      ),
    );
  }
}
