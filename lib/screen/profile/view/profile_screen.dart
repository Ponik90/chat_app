import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  TextEditingController txtName = TextEditingController();
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtEmail = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  ProfileController controller = Get.put(ProfileController());

  @override
  void initState() {
    super.initState();
    controller.getUserDetail();
    getData();
  }

  Future<void> getData() async {
    await controller.getUserDetail();

    txtEmail.text = controller.model.value.email!;
    txtName.text = controller.model.value.name!;
    txtPhone.text = controller.model.value.phone!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("ADD profile"),
      ),
      body: Form(
        key: formKey,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              const CircleAvatar(
                radius: 50,
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'name',
                  border: OutlineInputBorder(),
                ),
                controller: txtName,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(
                  hintText: 'phone',
                  border: OutlineInputBorder(),
                ),
                controller: txtPhone,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'email',
                  border: OutlineInputBorder(),
                ),
                controller: txtEmail,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Required";
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    ProfileModel model = ProfileModel(
                      phone: txtPhone.text,
                      email: txtEmail.text,
                      name: txtName.text,
                    );

                    DbFirebaseHelPer.dbFirebaseHelPer.userProfile(model);
                    Get.offAllNamed('home');
                  }

                },
                child: const Text("Submit"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
