import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/screen/user/model/user_model.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxList<UserModel> userModelList = <UserModel>[].obs;
  ProfileController profileController = Get.put(ProfileController());

  Future<void> getAllUser() async {
    List<UserModel>? model = await DbFirebaseHelPer.dbFirebaseHelPer
        .getAllUser(profileController.model.value);
    userModelList.value = model;
  }
}
