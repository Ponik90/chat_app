import 'package:chat_app/screen/profile/controller/profile_controller.dart';
import 'package:chat_app/screen/profile/model/profile_model.dart';
import 'package:chat_app/utils/helper/db_firebase_helper.dart';
import 'package:get/get.dart';

class UserController extends GetxController {
  RxList<ProfileModel> userModelList = <ProfileModel>[].obs;
  ProfileController profileController = Get.put(ProfileController());
  Future<void> getAllUser() async {
    List<ProfileModel>? model =
        await DbFirebaseHelPer.dbFirebaseHelPer.getAllUser(profileController.model.value);
    userModelList.value = model;
  }
}
